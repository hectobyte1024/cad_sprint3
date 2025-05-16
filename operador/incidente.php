<?php
session_start();

// CSRF Protection
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

if (empty($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

require_once '../db.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);

$mensaje_exito = '';
$mensaje_error = '';
$incidente = null;
$edicion = false;

// Load emergency types directly from database
$stmt = $conn->prepare("SELECT * FROM EmergencyTypes");
$stmt->execute();
$result = $stmt->get_result();
$emergencyTypes = $result->fetch_all(MYSQLI_ASSOC);

// Handle call data if coming from calls.php
if (isset($_GET['call_id'])) {
    $call_id = intval($_GET['call_id']);
    
    $stmt = $conn->prepare("SELECT i.* FROM llamadas l
                          JOIN incidentes i ON l.id_incidente = i.folio_incidente
                          WHERE l.id_llamada = ?");
    $stmt->bind_param("i", $call_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $incidente = $result->fetch_assoc();
        $edicion = true;
        
        $update_stmt = $conn->prepare("UPDATE llamadas SET estatus = 'En curso' WHERE id_llamada = ?");
        $update_stmt->bind_param("i", $call_id);
        $update_stmt->execute();
    }
}

// If lat/lng provided but no full incident, pre-fill map
if (isset($_GET['lat']) && isset($_GET['lng']) && !$edicion) {
    $lat = floatval($_GET['lat']);
    $lng = floatval($_GET['lng']);
    
    $incidente = [
        'latitud' => $lat,
        'longitud' => $lng,
        'quepaso' => 'Llamada entrante',
        'tipo_auxilio' => '',
        'num_personas' => 1,
        'telefono' => '',
        'prioridad' => 'Media',
        'colonia' => '',
        'localidad' => '',
        'municipio' => '',
        'id_emergency_type' => null
    ];
    
    // Reverse geocode with error handling
    try {
        $url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&accept-language=es";
        $response = file_get_contents($url);
        
        if ($response === false) {
            throw new Exception("Error al conectar con el servicio de geocodificación");
        }
        
        $data = json_decode($response, true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Error al decodificar la respuesta JSON");
        }
        
        if ($data && isset($data['address'])) {
            $incidente['colonia'] = $data['address']['suburb'] ?? $data['address']['neighbourhood'] ?? '';
            $incidente['localidad'] = $data['address']['city'] ?? $data['address']['town'] ?? $data['address']['village'] ?? '';
            $incidente['municipio'] = $data['address']['state'] ?? '';
        }
    } catch (Exception $e) {
        error_log("Geocoding error: " . $e->getMessage());
    }
    
    $edicion = false;
}

// Process form
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // CSRF validation
    if (!hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die('Token CSRF inválido');
    }

    try {
        $conn->begin_transaction();
        
        if (empty($_POST['coordenadas'])) {
            throw new Exception("Debes seleccionar una ubicación en el mapa");
        }

        [$latitud, $longitud] = explode(',', $_POST['coordenadas']);
        $latitud = trim($latitud);
        $longitud = trim($longitud);

        $quepaso = trim($_POST['paso'] ?? '');
        $tipo_auxilio = trim($_POST['tipo_auxilio'] ?? '');
        $num_personas = intval($_POST['num_personas'] ?? 1);
        $telefono = trim($_POST['telefono'] ?? '');
        $prioridad = trim($_POST['prioridad'] ?? 'Media');
        $colonia = trim($_POST['colonia'] ?? '');
        $localidad = trim($_POST['localidad'] ?? '');
        $municipio = trim($_POST['municipio'] ?? '');
        $id_usuario_reporta = $_SESSION['id_usuario'] ?? NULL;
        $id_unidad_asignada = $_POST['id_unidad_asignada'] ?? NULL;
        $id_emergency_type = $_POST['id_emergency_type'] ?? NULL;

        // Handle prank calls (if needed)
        if (isset($_POST['call_id'])) {
            $call_id = intval($_POST['call_id']);
            
            // Update call status
            $update_stmt = $conn->prepare("UPDATE llamadas 
                SET estatus = 'Finalizada' 
                WHERE id_llamada = ?");
            $update_stmt->bind_param("i", $call_id);
            $update_stmt->execute();
        }

        if (isset($_POST['folio_incidente'])) {
            $folio_incidente = intval($_POST['folio_incidente']);
            $stmt = $conn->prepare("UPDATE incidentes SET 
                quepaso=?, tipo_auxilio=?, num_personas=?, telefono=?, 
                prioridad=?, latitud=?, longitud=?, 
                colonia=?, localidad=?, municipio=?, id_emergency_type=?
                WHERE folio_incidente=?");
            $stmt->bind_param("ssissssssssi", 
                $quepaso, $tipo_auxilio, $num_personas, $telefono, 
                $prioridad, $latitud, $longitud, 
                $colonia, $localidad, $municipio, $id_emergency_type,
                $folio_incidente
            );
            $stmt->execute();
            $mensaje_exito = "Incidente actualizado correctamente";
        } else {
            $stmt = $conn->prepare("INSERT INTO incidentes 
                (quepaso, tipo_auxilio, hora_incidente, fecha_incidente, 
                fecha_actualizacion, num_personas, latitud, longitud, 
                telefono, id_usuario_reporta, prioridad, 
                id_unidad_asignada, colonia, localidad, municipio, id_emergency_type) 
                VALUES (?, ?, CURTIME(), NOW(), NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            $stmt->bind_param("ssisssissssss", 
                $quepaso, $tipo_auxilio, $num_personas, $latitud, $longitud,
                $telefono, $id_usuario_reporta, $prioridad,
                $id_unidad_asignada, $colonia, $localidad, $municipio, $id_emergency_type
            );

            $stmt->execute();
            $folio_incidente = $conn->insert_id;
            $mensaje_exito = "Incidente registrado correctamente";
        }
        
        $conn->commit();
    } catch (Exception $e) {
        $conn->rollback();
        $mensaje_error = $e->getMessage();
    }
}

// Helper function to get emergency type name by code
function getEmergencyTypeName($code, $emergencyTypes) {
    foreach ($emergencyTypes as $type) {
        if ($type['code'] == $code) {
            return $type['code'] . ' - ' . $type['name'];
        }
    }
    return '';
}

// When loading an incident
if (isset($incidente['id_emergency_type']) && $incidente['id_emergency_type']) {
    foreach ($emergencyTypes as $type) {
        if ($type['code'] == $incidente['id_emergency_type']) {
            $incidente['tipo_auxilio'] = $type['category'];
            $incidente['prioridad'] = $type['priority'];
            break;
        }
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión de Incidentes</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css" />
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            background-color: #f5f7fa;
        }

        .navbar {
            background: var(--primary);
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: var(--box-shadow);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .main-container {
            display: flex;
            flex: 1;
            overflow: hidden;
        }

        .form-container {
            width: 40%;
            padding: 2rem;
            overflow-y: auto;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .map-container {
            width: 60%;
            height: 100%;
            position: relative;
        }

        #map {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            border-left: 1px solid #ddd;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        input[type="text"],
        input[type="tel"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background-color: white;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            gap: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-warning {
            background-color: var(--warning);
            color: white;
        }

        .location-details {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-top: 1rem;
            border: 1px solid #eee;
        }

        .location-details p {
            margin: 0.5rem 0;
            font-size: 0.9rem;
        }

        .location-details strong {
            color: var(--primary);
        }

        /* Autocomplete styles */
        .autocomplete-container {
            position: relative;
        }

        .autocomplete-results {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            max-height: 200px;
            overflow-y: auto;
            background: white;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            z-index: 1000;
            display: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .autocomplete-item {
            padding: 0.75rem 1rem;
            cursor: pointer;
            border-bottom: 1px solid #eee;
            transition: var(--transition);
        }

        .autocomplete-item:last-child {
            border-bottom: none;
        }

        .autocomplete-item:hover {
            background-color: #f0f7ff;
        }

        .emergency-type {
            font-weight: bold;
            color: var(--dark);
            margin-bottom: 0.25rem;
        }

        .emergency-desc {
            font-size: 0.85rem;
            color: var(--gray);
            line-height: 1.4;
        }

        .emergency-priority {
            float: right;
            padding: 0.2rem 0.5rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: bold;
            text-transform: uppercase;
        }

        .priority-high {
            background-color: #f8d7da;
            color: #721c24;
        }

        .priority-medium {
            background-color: #fff3cd;
            color: #856404;
        }

        .priority-low {
            background-color: #d4edda;
            color: #155724;
        }

        .readonly-field {
            background-color: #f8f9fa;
            cursor: not-allowed;
            border-color: #e9ecef;
        }

        .readonly-field:focus {
            outline: none;
            box-shadow: none;
            border-color: #e9ecef;
        }

        .select2-container--disabled .select2-selection {
            background-color: #f8f9fa;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
            }
            
            .form-container, .map-container {
                width: 100%;
                height: 50%;
            }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="incidente.php" class="navbar-brand">
        <i class="fas fa-exclamation-triangle"></i> SGI
    </a>
    <div class="navbar-links">
        <a href="calls.php" class="nav-link"><i class="fas fa-phone"></i> Llamadas</a>
        <a href="incidente.php" class="nav-link"><i class="fas fa-list"></i> Incidentes</a>
        <a href="chat.php" class="nav-link"><i class="fas fa-comments"></i> Chat</a>
        <a href="dashboard.php" class="nav-link"><i class="fas fa-chart-line"></i> Dashboard</a>
        <a href="../logout.php" class="nav-link"><i class="fas fa-sign-out-alt"></i> Salir</a>
    </div>
</nav>

<div class="main-container">
    <div class="form-container">
        <?php if ($mensaje_exito): ?>
            <div class="alert alert-success"><?= htmlspecialchars($mensaje_exito) ?></div>
        <?php endif; ?>
        
        <?php if ($mensaje_error): ?>
            <div class="alert alert-danger"><?= htmlspecialchars($mensaje_error) ?></div>
        <?php endif; ?>

        <h2>Formulario de Incidente</h2>
        <form method="POST" onsubmit="return validarFormulario()">
            <?php if ($edicion): ?>
                <input type="hidden" name="folio_incidente" value="<?= htmlspecialchars($incidente['folio_incidente']) ?>">
            <?php endif; ?>
            
            <?php if (isset($_GET['call_id'])): ?>
                <input type="hidden" name="call_id" value="<?= htmlspecialchars($_GET['call_id']) ?>">
            <?php endif; ?>

            <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">
            <input type="hidden" id="id_emergency_type" name="id_emergency_type" value="<?= htmlspecialchars($incidente['id_emergency_type'] ?? '') ?>">

            <div class="form-group autocomplete-container">
                <label for="incident_search"><i class="fas fa-search"></i> Buscar tipo de incidente</label>
                <input type="text" id="incident_search" class="form-control" placeholder="Escriba para buscar..." 
                       value="<?= isset($incidente['id_emergency_type']) ? 
                           htmlspecialchars(getEmergencyTypeName($incidente['id_emergency_type'], $emergencyTypes)) : '' ?>">
                <div id="autocomplete_results" class="autocomplete-results"></div>
            </div>

            <div class="form-group">
                <label for="paso"><i class="fas fa-question-circle"></i> ¿Cuál es su emergencia?</label>
                <textarea id="paso" name="paso" required class="readonly-field" readonly><?= htmlspecialchars($incidente['quepaso'] ?? '') ?></textarea>
            </div>

            <div class="form-group">
                <label for="tipo_auxilio"><i class="fas fa-ambulance"></i> Tipo de auxilio</label>
                <select id="tipo_auxilio" name="tipo_auxilio" required class="readonly-field" readonly>
                    <option value="">Seleccione...</option>
                    <option value="Medical" <?= ($incidente['tipo_auxilio'] ?? '') == 'Medical' ? 'selected' : '' ?>>Médico</option>
                    <option value="Civil Protection" <?= ($incidente['tipo_auxilio'] ?? '') == 'Civil Protection' ? 'selected' : '' ?>>Protección Civil</option>
                    <option value="Security" <?= ($incidente['tipo_auxilio'] ?? '') == 'Security' ? 'selected' : '' ?>>Seguridad</option>
                    <option value="Assistance" <?= ($incidente['tipo_auxilio'] ?? '') == 'Assistance' ? 'selected' : '' ?>>Asistencia</option>
                    <option value="Public Services" <?= ($incidente['tipo_auxilio'] ?? '') == 'Public Services' ? 'selected' : '' ?>>Servicios Públicos</option>
                </select>
            </div>

            <div class="form-group">
                <label for="num_personas"><i class="fas fa-users"></i> Número de personas</label>
                <input type="number" id="num_personas" name="num_personas" value="<?= htmlspecialchars($incidente['num_personas'] ?? '1') ?>" min="1">
            </div>

            <div class="form-group">
                <label for="telefono"><i class="fas fa-phone"></i> Teléfono</label>
                <input type="tel" id="telefono" name="telefono" value="<?= htmlspecialchars($incidente['telefono'] ?? '') ?>" required class="readonly-field" readonly>
            </div>

            <div class="form-group">
                <label for="prioridad"><i class="fas fa-exclamation"></i> Prioridad</label>
                <select id="prioridad" name="prioridad_display" required class="readonly-field" readonly disabled>
                    <option value="Media" <?= !isset($incidente['prioridad']) || $incidente['prioridad'] == 'Media' ? 'selected' : '' ?>>Media</option>
                    <option value="Alta" <?= isset($incidente['prioridad']) && $incidente['prioridad'] == 'Alta' ? 'selected' : '' ?>>Alta</option>
                    <option value="Baja" <?= isset($incidente['prioridad']) && $incidente['prioridad'] == 'Baja' ? 'selected' : '' ?>>Baja</option>
                </select>
                <input type="hidden" id="prioridad_hidden" name="prioridad" value="<?= htmlspecialchars($incidente['prioridad'] ?? 'Media') ?>">
            </div>

            <input type="hidden" id="colonia" name="colonia" value="<?= htmlspecialchars($incidente['colonia'] ?? '') ?>">
            <input type="hidden" id="localidad" name="localidad" value="<?= htmlspecialchars($incidente['localidad'] ?? '') ?>">
            <input type="hidden" id="municipio" name="municipio" value="<?= htmlspecialchars($incidente['municipio'] ?? '') ?>">

            <div class="form-group">
                <label><i class="fas fa-map-marked-alt"></i> Ubicación en el mapa</label>
                <input type="text" id="coordenadas_display" class="form-control readonly-field" readonly 
                       value="<?= $edicion ? htmlspecialchars($incidente['latitud'] . ', ' . $incidente['longitud']) : '' ?>">
                <input type="hidden" id="coordenadas" name="coordenadas" 
                       value="<?= $edicion ? htmlspecialchars($incidente['latitud'] . ',' . $incidente['longitud']) : '' ?>">
                
                <div class="location-details" id="location-details" style="<?= $edicion ? '' : 'display:none;' ?>">
                    <p><strong>Colonia:</strong> <span id="colonia-display"><?= htmlspecialchars($incidente['colonia'] ?? '') ?></span></p>
                    <p><strong>Localidad:</strong> <span id="localidad-display"><?= htmlspecialchars($incidente['localidad'] ?? '') ?></span></p>
                    <p><strong>Municipio:</strong> <span id="municipio-display"><?= htmlspecialchars($incidente['municipio'] ?? '') ?></span></p>
                </div>
                
                <small class="text-muted">Haz clic en el mapa para seleccionar la ubicación</small>
            </div>

            
            <div class="form-group">
                <a href="prank_call.php?call_id=<?= isset($_GET['call_id']) ? htmlspecialchars($_GET['call_id']) : '' ?>" 
                class="btn btn-warning">
                    <i class="fas fa-exclamation-triangle"></i> Marcar como Llamada de Broma
                </a>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> <?= $edicion ? 'Actualizar' : 'Registrar' ?>
            </button>
        </form>
    </div>
    
    <div class="map-container">
        <div id="map"></div>
    </div>
</div>

<script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    // Initialize map with possible pre-filled location
    let initialLat = 19.4326;
    let initialLng = -99.1332;
    let initialZoom = 12;

    <?php if (isset($incidente['latitud']) && isset($incidente['longitud'])): ?>
        initialLat = <?= $incidente['latitud'] ?>;
        initialLng = <?= $incidente['longitud'] ?>;
        initialZoom = 15;
    <?php endif; ?>

    const map = L.map('map').setView([initialLat, initialLng], initialZoom);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    let marker = null;

    <?php if (isset($incidente['latitud']) && isset($incidente['longitud'])): ?>
        marker = L.marker([<?= $incidente['latitud'] ?>, <?= $incidente['longitud'] ?>]).addTo(map);
        document.getElementById('location-details').style.display = 'block';
    <?php endif; ?>

    map.on('click', async function(e) {
        if (marker) map.removeLayer(marker);
        marker = L.marker(e.latlng).addTo(map);

        const lat = e.latlng.lat.toFixed(6);
        const lon = e.latlng.lng.toFixed(6);
        
        document.getElementById('coordenadas').value = `${lat},${lon}`;
        document.getElementById('coordenadas_display').value = `${lat}, ${lon}`;

        // Display basic coordinates while we try geocoding
        const locationDetails = document.getElementById('location-details');
        locationDetails.style.display = 'block';
        locationDetails.innerHTML = `
            <p><strong>Coordenadas:</strong> ${lat}, ${lon}</p>
            <p>Buscando detalles de dirección...</p>
        `;

        // Try to get address details (may fail due to CORS)
        try {
            const response = await fetch(`https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lon}&format=json`, {
                headers: {
                    'User-Agent': 'YourAppName/1.0 (your@email.com)'
                }
            });
            
            if (!response.ok) throw new Error('API error');
            
            const data = await response.json();
            
            if (data.error) throw new Error(data.error);
            
            // Update UI with address components
            const address = data.address || {};
            const colonia = address.suburb || address.neighbourhood || 'No especificado';
            const localidad = address.city || address.town || address.village || 'No especificado';
            const municipio = address.state || 'No especificado';

            locationDetails.innerHTML = `
                <p><strong>Coordenadas:</strong> ${lat}, ${lon}</p>
                <p><strong>Colonia:</strong> ${colonia}</p>
                <p><strong>Localidad:</strong> ${localidad}</p>
                <p><strong>Municipio:</strong> ${municipio}</p>
            `;

            // Update form fields
            document.getElementById('colonia').value = colonia;
            document.getElementById('localidad').value = localidad;
            document.getElementById('municipio').value = municipio;

        } catch (error) {
            // If geocoding fails, just show coordinates
            locationDetails.innerHTML = `
                <p><strong>Coordenadas:</strong> ${lat}, ${lon}</p>
                <p class="text-warning">No se pudieron obtener detalles de dirección (${error.message})</p>
            `;
        }
    });

    function validarFormulario() {
        // Validate coordinates
        if (!document.getElementById('coordenadas').value) {
            alert('Debes seleccionar una ubicación en el mapa');
            return false;
        }
        
        return true;
    }

    // Fix map display on load
    setTimeout(() => {
        map.invalidateSize();
    }, 100);

    // Emergency types data from PHP
    const emergencyTypes = <?php echo json_encode($emergencyTypes); ?>;

    // Autocomplete functionality
    const searchInput = document.getElementById('incident_search');
    const resultsContainer = document.getElementById('autocomplete_results');
    const descriptionTextarea = document.getElementById('paso');
    const prioritySelect = document.getElementById('prioridad');
    const typeSelect = document.getElementById('tipo_auxilio');
    const numPersonasInput = document.getElementById('num_personas');
    const emergencyTypeIdInput = document.getElementById('id_emergency_type');
    const telefonoInput = document.getElementById('telefono');

    // Function to highlight matching text
    function highlightMatch(text, searchTerm) {
        if (!searchTerm) return text;
        const regex = new RegExp(`(${searchTerm})`, 'gi');
        return text.replace(regex, '<span style="background-color: yellow;">$1</span>');
    }

    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        resultsContainer.innerHTML = '';
        
        if (searchTerm.length < 2) {
            resultsContainer.style.display = 'none';
            return;
        }
        
        const filtered = emergencyTypes.filter(item => {
            // Search in name, code, and description
            return item.name.toLowerCase().includes(searchTerm) || 
                   item.code.toLowerCase().includes(searchTerm) ||
                   (item.description && item.description.toLowerCase().includes(searchTerm));
        });
        
        if (filtered.length === 0) {
            resultsContainer.innerHTML = '<div class="autocomplete-item">No se encontraron resultados</div>';
            resultsContainer.style.display = 'block';
            return;
        }
        
        filtered.slice(0, 10).forEach(item => {
            const div = document.createElement('div');
            div.className = 'autocomplete-item';
            
            // Create priority badge
            let priorityBadge = '';
            let priorityClass = '';
            // Set priority if available
            if (item.priority) {
                prioritySelect.value = item.priority;
                document.getElementById('prioridad_hidden').value = item.priority;
            }
            
            // Highlight matching text
            const highlightedName = highlightMatch(item.name, searchTerm);
            const highlightedCode = highlightMatch(item.code, searchTerm);
            const highlightedDesc = item.description ? highlightMatch(item.description, searchTerm) : 'Sin descripción';
            
            div.innerHTML = `
                <div class="emergency-type">${highlightedCode} - ${highlightedName} ${priorityBadge}</div>
                <div class="emergency-desc">${highlightedDesc}</div>
            `;
            
            div.addEventListener('click', function() {
                // Fill the form fields
                searchInput.value = `${item.code} - ${item.name}`;
                descriptionTextarea.value = item.description || '';
                
                // Set priority if available
                if (item.priority) {
                    // Remove readonly/disabled classes first
                    prioritySelect.classList.remove('readonly-field');
                    prioritySelect.disabled = false;
                    prioritySelect.value = item.priority;
                    // Add the classes back
                    prioritySelect.classList.add('readonly-field');
                    prioritySelect.disabled = true;
                }
                
                // Set emergency type (category)
                typeSelect.value = item.category;
                
                // Set emergency type ID
                emergencyTypeIdInput.value = item.code;
                
                // Set number of affected people (default to 1)
                numPersonasInput.value = 1;
                
                // Set phone number if not already set
                if (!telefonoInput.value) {
                    telefonoInput.value = '';
                }
                
                // Hide results
                resultsContainer.style.display = 'none';
            });
            
            resultsContainer.appendChild(div);
        });
        
        resultsContainer.style.display = 'block';
    });

    // Hide results when clicking outside
    document.addEventListener('click', function(e) {
        if (e.target !== searchInput) {
            resultsContainer.style.display = 'none';
        }
    });
    
    // Make all fields except classification readonly when loaded
    document.addEventListener('DOMContentLoaded', function() {
        const readonlyFields = document.querySelectorAll('.readonly-field');
        readonlyFields.forEach(field => {
            field.readOnly = true;
        });
        
        // Make select elements readonly
        const readonlySelects = document.querySelectorAll('select.readonly-field');
        readonlySelects.forEach(select => {
            select.disabled = true;
        });
    });
</script>

</body>
</html>