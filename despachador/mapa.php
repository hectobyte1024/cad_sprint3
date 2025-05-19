<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../db.php'; // This should contain your PDO connection

// Verify user is logged in
if (!isset($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

$folio_incidente = isset($_GET['folio']) ? intval($_GET['folio']) : 0;
$incidente = null;

try {
    // Query to get incident location and info
    $sql = "SELECT latitud, longitud, quepaso, tipo_auxilio, colonia, localidad, municipio 
            FROM incidentes 
            WHERE folio_incidente = :folio";
    
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':folio', $folio_incidente, PDO::PARAM_INT);
    $stmt->execute();
    
    $incidente = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$incidente) {
        throw new Exception("Incidente no encontrado");
    }
    
} catch (PDOException $e) {
    error_log("Database error: " . $e->getMessage());
    die("Error al conectar con la base de datos");
} catch (Exception $e) {
    die($e->getMessage());
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Ubicación del Incidente - Folio <?= htmlspecialchars($folio_incidente) ?></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        
        .map-container {
            width: 90%;
            height: 70vh;
            margin: 20px auto;
            border: 2px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            position: relative;
        }
        
        #map {
            width: 100%;
            height: 100%;
            border-radius: 6px;
        }
        
        .btn-regresar {
            position: absolute;
            top: 15px;
            right: 15px;
            z-index: 1000;
            background: #2c3e50;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        
        .btn-regresar:hover {
            background: #1a252f;
        }
        
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-top: 20px;
        }
        
        .info-box {
            width: 90%;
            margin: 10px auto;
            padding: 10px;
            background: #93D8E8;
            border-radius: 4px;
            text-align: center;
        }
        
        .error-box {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            background: #ffdddd;
            border: 1px solid #ff9999;
            border-radius: 4px;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Ubicación del Incidente</h1>
    
    <?php if (empty($incidente['latitud']) || empty($incidente['longitud'])): ?>
        <div class="error-box">
            <strong>Advertencia:</strong> Este incidente no tiene coordenadas geográficas registradas.
        </div>
    <?php endif; ?>
    
    <div class="info-box">
        Folio de Incidente: <strong><?= htmlspecialchars($folio_incidente) ?></strong><br>
        Tipo: <strong><?= htmlspecialchars($incidente['tipo_auxilio']) ?></strong> | 
        Ubicación: <strong><?= htmlspecialchars($incidente['colonia'] . ', ' . $incidente['localidad'] . ', ' . $incidente['municipio']) ?></strong>
    </div>
    
    <div class="map-container">
        <div id="map"></div>
        <button class="btn-regresar" onclick="window.history.back();">
            ← Regresar
        </button>
    </div>
    
    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    
    <script>
        // Datos del incidente desde PHP
        var incidente = <?= json_encode($incidente) ?>;
        var folio = <?= json_encode($folio_incidente) ?>;
        
        // Inicializar mapa
        var map = L.map('map');
        
        // Capa de OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
        
        // Verificar si hay coordenadas
        if (incidente.latitud && incidente.longitud) {
            var latlng = [parseFloat(incidente.latitud), parseFloat(incidente.longitud)];
            
            // Centrar el mapa en la ubicación del incidente
            map.setView(latlng, 16);
            
            // Agregar marcador
            L.marker(latlng)
                .addTo(map)
                .bindPopup(`
                    <b>Incidente #${folio}</b><br>
                    <b>${incidente.tipo_auxilio}</b><br>
                    ${incidente.quepaso}<br>
                    <b>Ubicación:</b> ${incidente.colonia}, ${incidente.localidad}, ${incidente.municipio}
                `);
        } else {
            // Mostrar mensaje si no hay coordenadas
            map.setView([19.4326, -99.1332], 10); // Vista por defecto (CDMX)
            L.popup()
                .setLatLng(map.getCenter())
                .setContent("Este incidente no tiene ubicación geográfica registrada")
                .openOn(map);
        }
    </script>
</body>
</html>