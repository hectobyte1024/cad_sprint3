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

// Verify database connection
if (!isset($pdo) || !($pdo instanceof PDO)) {
    die("Error: No se pudo establecer conexión con la base de datos");
}

ini_set('display_errors', 1);
error_reporting(E_ALL);

$mensaje_exito = '';
$mensaje_error = '';
$incidente = null;
$edicion = false;

// Load emergency types directly from database
$stmt = $pdo->query("SELECT * FROM EmergencyTypes ORDER BY category, name");
$emergencyTypes = $stmt->fetchAll();

// Handle incident editing if coming with incident ID
if (isset($_GET['incident_id'])) {
    $incident_id = intval($_GET['incident_id']);
    
    $stmt = $pdo->prepare("SELECT * FROM incidentes WHERE folio_incidente = ?");
    $stmt->execute([$incident_id]);
    $incidente = $stmt->fetch();
    
    if ($incidente) {
        $edicion = true;
    }
}

// Handle call data if coming from calls.php
if (isset($_GET['call_id'])) {
    $call_id = intval($_GET['call_id']);
    
    $stmt = $pdo->prepare("SELECT * FROM llamadas WHERE id_llamada = ?");
    $stmt->execute([$call_id]);
    $llamada = $stmt->fetch();
    
    if ($llamada) {
        // Check if there's already an incident for this call
        $stmt = $pdo->prepare("SELECT * FROM incidentes WHERE id_llamada = ?");
        $stmt->execute([$call_id]);
        $incidente = $stmt->fetch();
        
        if ($incidente) {
            $edicion = true;
        } else {
            // Create new incident from call data
            $incidente = [
                'quepaso' => 'Llamada entrante',
                'tipo_auxilio' => '',
                'num_personas' => 1,
                'telefono' => $llamada['telefono'] ?? '',
                'prioridad' => '',
                'latitud' => $llamada['latitud'] ?? null,
                'longitud' => $llamada['longitud'] ?? null,
                'id_llamada' => $call_id,
                'id_emergency_type' => null,
                'colonia' => '',
                'localidad' => '',
                'municipio' => '',
                'hora' => date('H:i')
            ];
            
            // Reverse geocode to get address details
            if ($llamada['latitud'] && $llamada['longitud']) {
                try {
                    $url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=".$llamada['latitud']."&lon=".$llamada['longitud']."&accept-language=es";
                    $context = stream_context_create(['http' => ['header' => 'User-Agent: MyApp/1.0']]);
                    $response = file_get_contents($url, false, $context);
                    
                    if ($response !== false) {
                        $data = json_decode($response, true);
                        
                        if ($data && isset($data['address'])) {
                            $incidente['colonia'] = $data['address']['suburb'] ?? $data['address']['neighbourhood'] ?? '';
                            $incidente['localidad'] = $data['address']['city'] ?? $data['address']['town'] ?? $data['address']['village'] ?? '';
                            $incidente['municipio'] = $data['address']['state'] ?? '';
                        }
                    }
                } catch (Exception $e) {
                    error_log("Geocoding error: " . $e->getMessage());
                }
            }
        }
        
        // Update call status to "En curso" if not already
        if ($llamada['estatus'] !== 'En curso') {
            $pdo->prepare("UPDATE llamadas SET estatus = 'En curso' WHERE id_llamada = ?")
                ->execute([$call_id]);
        }
    }
}

// Process form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // CSRF validation
    if (!hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die('Token CSRF inválido');
    }

    try {
        $pdo->beginTransaction();
        
        // Validate required fields
        $required = ['coordenadas', 'paso', 'tipo_auxilio', 'telefono', 'prioridad', 'id_emergency_type', 'hora'];
        foreach ($required as $field) {
            if (empty($_POST[$field])) {
                throw new Exception("El campo $field es requerido");
            }
        }

        [$latitud, $longitud] = explode(',', $_POST['coordenadas']);
        $latitud = trim($latitud);
        $longitud = trim($longitud);

        $quepaso = trim($_POST['paso']);
        $tipo_auxilio = trim($_POST['tipo_auxilio']);
        $num_personas = intval($_POST['num_personas'] ?? 1);
        $telefono = trim($_POST['telefono']);
        $prioridad = trim($_POST['prioridad']);
        $colonia = trim($_POST['colonia'] ?? '');
        $localidad = trim($_POST['localidad'] ?? '');
        $municipio = trim($_POST['municipio'] ?? '');
        $hora = trim($_POST['hora']);
        $id_usuario_reporta = $_SESSION['id_usuario'];
        $id_emergency_type = $_POST['id_emergency_type'];
        $id_llamada = isset($_POST['call_id']) ? intval($_POST['call_id']) : null;
        $nombre_completo = trim($_POST['nombre_completo'] ?? '');
        $tipo_telefono = trim($_POST['tipo_telefono'] ?? '');
        $referencia_lugar = trim($_POST['referencia_lugar'] ?? '');
        
        // Objetos involucrados y detalles
        $objetos_involucrados = [];
        if (isset($_POST['vehiculos_check']) && $_POST['vehiculos_check'] == '1') {
            $objetos_involucrados[] = 'Vehículos';
            if (!empty($_POST['detalles_vehiculos'])) {
                $objetos_involucrados[] = 'Detalles vehículos: ' . trim($_POST['detalles_vehiculos']);
            }
        }
        if (isset($_POST['armas_check']) && $_POST['armas_check'] == '1') {
            $objetos_involucrados[] = 'Armas';
            if (!empty($_POST['detalles_armas'])) {
                $objetos_involucrados[] = 'Detalles armas: ' . trim($_POST['detalles_armas']);
            }
        }
        $objetos_involucrados_str = implode('; ', $objetos_involucrados);

        if (isset($_POST['folio_incidente'])) {
            // Update existing incident - incluyendo hora_edicion
            $stmt = $pdo->prepare("UPDATE incidentes SET 
                quepaso=?, tipo_auxilio=?, num_personas=?, telefono=?, 
                prioridad=?, latitud=?, longitud=?, 
                colonia=?, localidad=?, municipio=?, id_emergency_type=?, hora=?,
                nombre_completo=?, tipo_telefono=?, referencia_lugar=?, objetos_involucrados=?,
                hora_edicion=CURTIME(), fecha_actualizacion=NOW()
                WHERE folio_incidente=?");
            $stmt->execute([
                $quepaso, $tipo_auxilio, $num_personas, $telefono, 
                $prioridad, $latitud, $longitud, 
                $colonia, $localidad, $municipio, $id_emergency_type, $hora,
                $nombre_completo, $tipo_telefono, $referencia_lugar, $objetos_involucrados_str,
                $_POST['folio_incidente']
            ]);
            $mensaje_exito = "Incidente actualizado correctamente";
        } else {
            // Create new incident
            $stmt = $pdo->prepare("INSERT INTO incidentes 
                (quepaso, tipo_auxilio, hora_incidente, fecha_incidente, 
                num_personas, latitud, longitud, 
                telefono, id_usuario_reporta, prioridad, 
                colonia, localidad, municipio, id_emergency_type, id_llamada, hora,
                nombre_completo, tipo_telefono, referencia_lugar, objetos_involucrados) 
                VALUES (?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            $stmt->execute([
                $quepaso, $tipo_auxilio, $hora, $num_personas, $latitud, $longitud,
                $telefono, $id_usuario_reporta, $prioridad,
                $colonia, $localidad, $municipio, $id_emergency_type, $id_llamada, $hora,
                $nombre_completo, $tipo_telefono, $referencia_lugar, $objetos_involucrados_str
            ]);
            $folio_incidente = $pdo->lastInsertId();
            $mensaje_exito = "Incidente registrado correctamente";
            
            // Update call status to "Finalizada" if this was from a call
            if ($id_llamada) {
                $pdo->prepare("UPDATE llamadas 
                    SET estatus = 'Finalizada'
                    WHERE id_llamada = ?")
                    ->execute([$id_llamada]);
            }
        }
        
        $pdo->commit();
        
        // Redirect to prevent form resubmission
        if (isset($_POST['call_id'])) {
            header("Location: calls.php");
            exit();
        } else {
            header("Location: incidente.php?success=1");
            exit();
        }
    } catch (Exception $e) {
        $pdo->rollBack();
        $mensaje_error = $e->getMessage();
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css">
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

        .navbar-brand {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.2rem;
        }

        .navbar-links {
            display: flex;
            gap: 1.5rem;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
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

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #3ab0d9;
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

        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: var(--border-radius);
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .autocomplete-container {
            position: relative;
        }

        .ui-autocomplete {
            max-height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
            background: white;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            z-index: 1000;
        }

        .ui-menu-item {
            padding: 8px 12px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }

        .ui-menu-item:hover {
            background-color: #f0f7ff;
        }

        .emergency-type {
            font-weight: bold;
            color: var(--dark);
        }

        .emergency-desc {
            font-size: 0.85rem;
            color: var(--gray);
            margin-top: 4px;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        /* Estilos para objetos involucrados */
        .checkbox-group {
            margin-bottom: 15px;
        }

        .checkbox-group label {
            display: block;
            margin-bottom: 8px;
            cursor: pointer;
        }

        .detalles-objeto {
            margin-top: 10px;
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
            display: none;
        }

        .detalles-objeto label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
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
        <a href="cluster_view.php" class="nav-link">Clusters</a>
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

        <h2><?= $edicion ? 'Editar Incidente' : 'Registrar Nuevo Incidente' ?></h2>
        <form method="POST" onsubmit="return validarFormulario()">
            <?php if ($edicion): ?>
                <input type="hidden" name="folio_incidente" value="<?= htmlspecialchars($incidente['folio_incidente']) ?>">
            <?php endif; ?>
            
            <?php if (isset($_GET['call_id'])): ?>
                <input type="hidden" name="call_id" value="<?= htmlspecialchars($_GET['call_id']) ?>">
            <?php endif; ?>

            <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">

            <div class="form-group autocomplete-container">
                <label for="emergency_type_search"><i class="fas fa-ambulance"></i> Tipo de emergencia *</label>
                <input type="text" id="emergency_type_search" placeholder="Buscar tipo de emergencia..." 
                       value="<?= isset($incidente['id_emergency_type']) ? 
                           htmlspecialchars(getEmergencyTypeName($incidente['id_emergency_type'], $emergencyTypes)) : '' ?>"
                       class="form-control">
                <input type="hidden" id="id_emergency_type" name="id_emergency_type" 
                       value="<?= htmlspecialchars($incidente['id_emergency_type'] ?? '') ?>">
                <input type="hidden" id="tipo_auxilio" name="tipo_auxilio" 
                       value="<?= htmlspecialchars($incidente['tipo_auxilio'] ?? '') ?>">
            </div>

            <div class="form-group">
                <label for="paso"><i class="fas fa-question-circle"></i> ¿Qué pasó? *</label>
                <textarea id="paso" name="paso" required><?= htmlspecialchars($incidente['quepaso'] ?? '') ?></textarea>
            </div>

            <div class="form-group">
                <label for="telefono"><i class="fas fa-phone"></i> Teléfono *</label>
                <input type="tel" id="telefono" name="telefono" value="<?= htmlspecialchars($incidente['telefono'] ?? '') ?>" required <?= isset($incidente['telefono']) ? 'readonly' : '' ?>>
            </div>

            <div class="form-group">
                <label for="hora"><i class="fas fa-clock"></i> Hora del incidente *</label>
                <input type="time" id="hora" name="hora" value="<?= htmlspecialchars($incidente['hora'] ?? date('H:i')) ?>" required>
            </div>
           
            <div class="form-group">
                <label for="prioridad"><i class="fas fa-exclamation"></i> Prioridad *</label>
                <select id="prioridad" name="prioridad" required>
                    <option value="Media" <?= !isset($incidente['prioridad']) || $incidente['prioridad'] == 'Media' ? 'selected' : '' ?>>Media</option>
                    <option value="Alta" <?= isset($incidente['prioridad']) && $incidente['prioridad'] == 'Alta' ? 'selected' : '' ?>>Alta</option>
                    <option value="Baja" <?= isset($incidente['prioridad']) && $incidente['prioridad'] == 'Baja' ? 'selected' : '' ?>>Baja</option>
                </select>
            </div>

            <div class="form-group">
                <label for="num_personas"><i class="fas fa-users"></i> Número de personas *</label>
                <input type="number" id="num_personas" name="num_personas" value="<?= htmlspecialchars($incidente['num_personas'] ?? '1') ?>" min="1" required>
            </div>

            <div class="form-group">
                <label><i class="fas fa-map-marked-alt"></i> Ubicación *</label>
                <p class="small-text">Haz clic en el mapa o arrastra el marcador para cambiar la ubicación</p>
                <input type="text" id="coordenadas_display" class="form-control" readonly 
                       value="<?= isset($incidente['latitud']) ? htmlspecialchars($incidente['latitud'] . ', ' . $incidente['longitud']) : '' ?>">
                <input type="hidden" id="coordenadas" name="coordenadas" 
                       value="<?= isset($incidente['latitud']) ? htmlspecialchars($incidente['latitud'] . ',' . $incidente['longitud']) : '' ?>" required>
                
                <div class="location-details" id="location-details" style="<?= isset($incidente['colonia']) && !empty($incidente['colonia']) ? '' : 'display:none;' ?>">
                    <p><strong>Colonia:</strong> <span id="colonia-display"><?= htmlspecialchars($incidente['colonia'] ?? '') ?></span></p>
                    <p><strong>Localidad:</strong> <span id="localidad-display"><?= htmlspecialchars($incidente['localidad'] ?? '') ?></span></p>
                    <p><strong>Municipio:</strong> <span id="municipio-display"><?= htmlspecialchars($incidente['municipio'] ?? '') ?></span></p>
                </div>
            </div>

            <input type="hidden" id="colonia" name="colonia" value="<?= htmlspecialchars($incidente['colonia'] ?? '') ?>">
            <input type="hidden" id="localidad" name="localidad" value="<?= htmlspecialchars($incidente['localidad'] ?? '') ?>">
            <input type="hidden" id="municipio" name="municipio" value="<?= htmlspecialchars($incidente['municipio'] ?? '') ?>">

            <div class="form-group">
                <label> Nombre completo : </label>
                <input type="text" id="nombre_completo" name="nombre_completo" value="<?= htmlspecialchars($incidente['nombre_completo'] ?? '') ?>" required>
            </div>

            <div class="form-group">
                <label for="tipo_telefono"> Tipo de teléfono </label>
                <select id="tipo_telefono" name="tipo_telefono">
                    <option value="">Selecciona...</option>
                    <option value="Local" <?= isset($incidente['tipo_telefono']) && $incidente['tipo_telefono'] == 'Local' ? 'selected' : '' ?>>Local</option>
                    <option value="Celular" <?= isset($incidente['tipo_telefono']) && $incidente['tipo_telefono'] == 'Celular' ? 'selected' : '' ?>>Celular</option>
                    <option value="Público" <?= isset($incidente['tipo_telefono']) && $incidente['tipo_telefono'] == 'Público' ? 'selected' : '' ?>>Público</option>
                </select>
            </div>

            <div class="form-group">
                <label for="referencia_lugar"> Referencia del lugar </label>
                <textarea id="referencia_lugar" name="referencia_lugar"><?= htmlspecialchars($incidente['referencia_lugar'] ?? '') ?></textarea>
            </div>

               <!-- Sección de objetos involucrados simplificada -->
            <div class="form-group">
                <label>Objetos involucrados</label>
                <div class="checkbox-group">
                    <label>
                        <input type="checkbox" id="vehiculos_check" name="vehiculos_check" value="1" <?= (isset($incidente['objetos_involucrados']) && strpos($incidente['objetos_involucrados'], 'Vehículos') !== false) ? 'checked' : '' ?>>
                        Vehículos
                    </label>
                    <label>
                        <input type="checkbox" id="armas_check" name="armas_check" value="1" <?= (isset($incidente['objetos_involucrados']) && strpos($incidente['objetos_involucrados'], 'Armas') !== false) ? 'checked' : '' ?>>
                        Armas
                    </label>
                </div>
            </div>

            <!-- Campo único de detalles -->
            <div class="form-group">
                <label for="detalles">Detalles</label>
                <textarea id="detalles" name="detalles" class="form-control" rows="3" placeholder="Proporciona detalles relevantes sobre el incidente"><?= htmlspecialchars($incidente['detalles'] ?? '') ?></textarea>
            </div>
            
            <div class="button-group">
                <?php if ($edicion): ?>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Actualizar Incidente
                    </button>
                    <a href="incidente.php" class="btn btn-warning">
                        <i class="fas fa-times"></i> Cancelar
                    </a>
                <?php else: ?>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus-circle"></i> Registrar Incidente
                    </button>
                <?php endif; ?>
                
                <?php if (isset($_GET['call_id'])): ?>
                    <a href="prank_call.php?call_id=<?= htmlspecialchars($_GET['call_id']) ?>" 
                       class="btn btn-warning">
                        <i class="fas fa-exclamation-triangle"></i> Marcar como Llamada de Broma
                    </a>
                <?php endif; ?>
            </div>
        </form>
    </div>
    
    <div class="map-container">
        <div id="map"></div>
    </div>
</div>

<script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<script>
    // Initialize map with incident location if available
    let initialLat = 19.4326;
    let initialLng = -99.1332;
    let initialZoom = 12;

    <?php if (isset($incidente['latitud']) && isset($incidente['longitud'])): ?>
        initialLat = <?= $incidente['latitud'] ?>;
        initialLng = <?= $incidente['longitud'] ?>;
        initialZoom = 15;
    <?php elseif (isset($llamada['latitud']) && isset($llamada['longitud'])): ?>
        initialLat = <?= $llamada['latitud'] ?>;
        initialLng = <?= $llamada['longitud'] ?>;
        initialZoom = 15;
    <?php endif; ?>

    const map = L.map('map').setView([initialLat, initialLng], initialZoom);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    let marker = null;

    // Función para actualizar los campos del formulario con las nuevas coordenadas
    function updateFormFields(lat, lng) {
        document.getElementById('coordenadas').value = lat + ',' + lng;
        document.getElementById('coordenadas_display').value = lat + ', ' + lng;
        
        // Limpiar detalles de ubicación mientras se carga la nueva
        document.getElementById('location-details').style.display = 'none';
        document.getElementById('colonia').value = '';
        document.getElementById('localidad').value = '';
        document.getElementById('municipio').value = '';
        document.getElementById('colonia-display').textContent = '';
        document.getElementById('localidad-display').textContent = '';
        document.getElementById('municipio-display').textContent = '';
        
        // Hacer geocoding inverso para obtener la nueva dirección
        fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&accept-language=es`, {
            headers: {
                'User-Agent': 'MyApp/1.0'
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data && data.address) {
                const colonia = data.address.suburb || data.address.neighbourhood || '';
                const localidad = data.address.city || data.address.town || data.address.village || '';
                const municipio = data.address.state || '';
                
                document.getElementById('colonia').value = colonia;
                document.getElementById('localidad').value = localidad;
                document.getElementById('municipio').value = municipio;
                document.getElementById('colonia-display').textContent = colonia;
                document.getElementById('localidad-display').textContent = localidad;
                document.getElementById('municipio-display').textContent = municipio;
                document.getElementById('location-details').style.display = 'block';
            }
        })
        .catch(error => {
            console.error("Error en geocoding inverso:", error);
        });
    }

    <?php if (isset($incidente['latitud']) && isset($incidente['longitud'])): ?>
        marker = L.marker([<?= $incidente['latitud'] ?>, <?= $incidente['longitud'] ?>], {
            draggable: true // Hacer el marcador arrastrable
        }).addTo(map);
        
        marker.on('dragend', function(e) {
            const newLatLng = e.target.getLatLng();
            updateFormFields(newLatLng.lat, newLatLng.lng);
        });
        
        document.getElementById('location-details').style.display = 'block';
    <?php elseif (isset($llamada['latitud']) && isset($llamada['longitud'])): ?>
        marker = L.marker([<?= $llamada['latitud'] ?>, <?= $llamada['longitud'] ?>], {
            draggable: true // Hacer el marcador arrastrable
        }).addTo(map);
        
        marker.on('dragend', function(e) {
            const newLatLng = e.target.getLatLng();
            updateFormFields(newLatLng.lat, newLatLng.lng);
        });
        
        document.getElementById('location-details').style.display = 'block';
    <?php else: ?>
        // Si no hay ubicación previa, crear un marcador arrastrable en la ubicación inicial
        marker = L.marker([initialLat, initialLng], {
            draggable: true
        }).addTo(map);
        
        marker.on('dragend', function(e) {
            const newLatLng = e.target.getLatLng();
            updateFormFields(newLatLng.lat, newLatLng.lng);
        });
    <?php endif; ?>

    // Permitir también hacer clic en el mapa para mover el marcador
    map.on('click', function(e) {
        if (!marker) {
            marker = L.marker(e.latlng, {
                draggable: true
            }).addTo(map);
            
            marker.on('dragend', function(e) {
                const newLatLng = e.target.getLatLng();
                updateFormFields(newLatLng.lat, newLatLng.lng);
            });
        } else {
            marker.setLatLng(e.latlng);
        }
        
        updateFormFields(e.latlng.lat, e.latlng.lng);
    });

    // Emergency types data for autocomplete
    const emergencyTypes = <?php echo json_encode($emergencyTypes); ?>;

    // Emergency type autocomplete
    $('#emergency_type_search').autocomplete({
        source: function(request, response) {
            const term = request.term.toLowerCase();
            const results = emergencyTypes.filter(type => 
                type.name.toLowerCase().includes(term) || 
                type.code.toLowerCase().includes(term) ||
                type.category.toLowerCase().includes(term)
            );
            response(results.map(type => ({
                label: `${type.code} - ${type.name} (${type.category})`,
                value: type.code,
                category: type.category,
                priority: mapPriorityToEnum(type.priority),
                id: type.id,
                description: type.description || ''
            })));
        },
        minLength: 2,
        select: function(event, ui) {
            $('#tipo_auxilio').val(ui.item.category);
            $('#prioridad').val(ui.item.priority);
            $('#id_emergency_type').val(ui.item.value);
            $('#emergency_type_search').val(ui.item.label);
            $('#paso').val(ui.item.description);
            return false;
        }
    }).data('ui-autocomplete')._renderItem = function(ul, item) {
        return $('<li>')
            .append(`<div class="emergency-type">${item.label}</div>
                    <div class="emergency-desc">${item.description}</div>`)
            .appendTo(ul);
    };

    function mapPriorityToEnum(priority) {
        if (!priority) return 'Media';
        const map = {
            'ALTA': 'Alta',
            'MEDIA': 'Media',
            'BAJA': 'Baja'
        };
        return map[priority.toUpperCase()] || 'Media';
    }

    // If we have emergency type info from call data
    <?php if (isset($incidente['id_emergency_type']) && !empty($incidente['id_emergency_type'])): ?>
        const emergencyType = emergencyTypes.find(t => t.code === '<?= $incidente['id_emergency_type'] ?>');
        if (emergencyType) {
            $('#emergency_type_search').val(`${emergencyType.code} - ${emergencyType.name} (${emergencyType.category})`);
            $('#tipo_auxilio').val(emergencyType.category);
            $('#prioridad').val(emergencyType.priority || 'Media');
            $('#id_emergency_type').val(emergencyType.code);
        }
    <?php endif; ?>

    // Control de visibilidad de detalles de objetos involucrados
    document.addEventListener('DOMContentLoaded', function() {
        const vehiculosCheck = document.getElementById('vehiculos_check');
        const armasCheck = document.getElementById('armas_check');
        const detallesVehiculos = document.getElementById('detalles-vehiculos');
        const detallesArmas = document.getElementById('detalles-armas');

        // Mostrar/ocultar detalles según el estado inicial
        if (vehiculosCheck.checked) {
            detallesVehiculos.style.display = 'block';
        }
        if (armasCheck.checked) {
            detallesArmas.style.display = 'block';
        }

        // Event listeners para cambios en los checkboxes
        vehiculosCheck.addEventListener('change', function() {
            detallesVehiculos.style.display = this.checked ? 'block' : 'none';
            if (!this.checked) {
                document.getElementById('detalles_vehiculos').value = '';
            }
        });

        armasCheck.addEventListener('change', function() {
            detallesArmas.style.display = this.checked ? 'block' : 'none';
            if (!this.checked) {
                document.getElementById('detalles_armas').value = '';
            }
        });
    });

    function validarFormulario() {
        const required = ['coordenadas', 'tipo_auxilio', 'telefono', 'prioridad', 'paso', 'num_personas', 'hora'];
        let valid = true;
        
        required.forEach(field => {
            const element = document.querySelector(`[name="${field}"]`);
            if (!element || !element.value) {
                alert(`El campo ${field} es requerido`);
                valid = false;
                return false;
            }
        });
        
        return valid;
    }

    // Fix map display on load
    setTimeout(() => {
        map.invalidateSize();
    }, 100);
</script>
</body>
</html>

<?php
function getEmergencyTypeName($code, $emergencyTypes) {
    foreach ($emergencyTypes as $type) {
        if ($type['code'] == $code) {
            return $type['code'] . ' - ' . $type['name'] . ' (' . $type['category'] . ')';
        }
    }
    return '';
}



function findRelatedCalls($pdo, $lat, $lng, $emergencyType, $maxDistanceMeters = 500, $timeWindowMinutes = 30) {
    // Calculate time window
    $timeWindowStart = date('Y-m-d H:i:s', strtotime("-$timeWindowMinutes minutes"));
    
    // Prepare query to find calls with same emergency type within distance and time
    $query = "
        SELECT l.id_llamada, l.latitud, l.longitud, l.fecha
        FROM llamadas l
        WHERE l.id_emergency_type = :emergencyType
        AND l.fecha >= :timeWindowStart
        AND l.estatus IN ('Atender', 'Clasificada')
        AND ST_Distance_Sphere(
            POINT(:lng, :lat),
            POINT(l.longitud, l.latitud)
        ) <= :maxDistance
    ";
    
    $stmt = $pdo->prepare($query);
    $stmt->execute([
        ':emergencyType' => $emergencyType,
        ':timeWindowStart' => $timeWindowStart,
        ':lat' => $lat,
        ':lng' => $lng,
        ':maxDistance' => $maxDistanceMeters
    ]);
    
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
