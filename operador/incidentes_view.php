<?php
session_start();
require_once '../db.php';

// Get all incidents with location data
$incidents = $pdo->query(
    "SELECT 
        folio_incidente,
        quepaso,
        tipo_auxilio,
        fecha_incidente,
        latitud,
        longitud,
        colonia,
        municipio,
        prioridad,
        num_personas,
        detalle,
        referencia_lugar,
        nombre_completo,
        objetos_involucrados
    FROM incidentes 
    WHERE latitud IS NOT NULL 
    AND longitud IS NOT NULL
    ORDER BY fecha_incidente DESC"
)->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa de Incidentes</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .container {
            display: flex;
            flex-direction: column;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        #incidentsMap {
            height: 700px;
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .stats {
            background: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .stat-card {
            flex: 1;
            min-width: 200px;
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            border-left: 4px solid #3498db;
        }
        .stat-card h3 {
            margin-top: 0;
            color: #2c3e50;
            font-size: 14px;
            text-transform: uppercase;
        }
        .stat-card p {
            margin-bottom: 0;
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }
        .priority-high { color: #e74c3c; }
        .priority-medium { color: #f39c12; }
        .priority-low { color: #2ecc71; }
        .leaflet-popup-content {
            min-width: 250px;
        }
        .popup-header {
            font-weight: bold;
            margin-bottom: 8px;
            color: #2c3e50;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }
        .popup-row {
            margin-bottom: 5px;
            display: flex;
        }
        .popup-label {
            font-weight: bold;
            min-width: 100px;
            color: #7f8c8d;
        }
        .popup-value {
            flex: 1;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-map-marked-alt"></i> Mapa de Incidentes</h1>
    </div>

    <div class="container">
        <div class="stats">
            <div class="stat-card">
                <h3>Total Incidentes</h3>
                <p><?= count($incidents) ?></p>
            </div>
            <div class="stat-card">
                <h3>Incidentes Recientes</h3>
                <p><?= date('d/m/Y', strtotime($incidents[0]['fecha_incidente'])) ?></p>
            </div>
            <div class="stat-card">
                <h3>Tipos de Auxilio</h3>
                <p><?= count(array_unique(array_column($incidents, 'tipo_auxilio'))) ?></p>
            </div>
            <div class="stat-card">
                <h3>Municipios</h3>
                <p><?= count(array_unique(array_column($incidents, 'municipio'))) ?></p>
            </div>
        </div>

        <div id="incidentsMap"></div>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        // Initialize the map centered on Mexico City
        const map = L.map('incidentsMap').setView([19.4326, -99.1332], 11);

        // Add tile layer
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Custom icons based on priority
        const icons = {
            'Alta': L.icon({
                iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34]
            }),
            'Media': L.icon({
                iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-orange.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34]
            }),
            'Baja': L.icon({
                iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34]
            }),
            'default': L.icon({
                iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34]
            })
        };

        // Add incident markers to the map
        <?php foreach ($incidents as $incident): ?>
            try {
                const lat = <?= $incident['latitud'] ?>;
                const lng = <?= $incident['longitud'] ?>;
                const priority = "<?= $incident['prioridad'] ?>" || 'default';
                
                if (isNaN(lat) || isNaN(lng)) {
                    console.error("Invalid coordinates for incident <?= $incident['folio_incidente'] ?>:", lat, lng);
                    continue;
                }

                const icon = icons[priority] || icons['default'];
                
                const marker = L.marker([lat, lng], { icon: icon }).addTo(map);
                
                // Create detailed popup content
                let popupContent = `
                    <div class="popup-header">
                        <i class="fas fa-exclamation-triangle"></i> Incidente #<?= $incident['folio_incidente'] ?>
                        <span class="priority-<?= strtolower($incident['prioridad']) ?>">
                            (<?= $incident['prioridad'] ?>)
                        </span>
                    </div>
                    
                    <div class="popup-row">
                        <div class="popup-label">Tipo:</div>
                        <div class="popup-value"><?= $incident['tipo_auxilio'] ?></div>
                    </div>
                    
                    <div class="popup-row">
                        <div class="popup-label">Fecha:</div>
                        <div class="popup-value"><?= date('d/m/Y H:i', strtotime($incident['fecha_incidente'])) ?></div>
                    </div>
                    
                    <div class="popup-row">
                        <div class="popup-label">Ubicación:</div>
                        <div class="popup-value"><?= $incident['colonia'] ?>, <?= $incident['municipio'] ?></div>
                    </div>
                    
                    <div class="popup-row">
                        <div class="popup-label">Personas:</div>
                        <div class="popup-value"><?= $incident['num_personas'] ?></div>
                    </div>
                `;

                <?php if (!empty($incident['nombre_completo'])): ?>
                    popupContent += `
                        <div class="popup-row">
                            <div class="popup-label">Reportó:</div>
                            <div class="popup-value"><?= $incident['nombre_completo'] ?></div>
                        </div>
                    `;
                <?php endif; ?>

                <?php if (!empty($incident['detalle'])): ?>
                    popupContent += `
                        <div class="popup-row">
                            <div class="popup-label">Detalle:</div>
                            <div class="popup-value"><?= $incident['detalle'] ?></div>
                        </div>
                    `;
                <?php endif; ?>

                <?php if (!empty($incident['objetos_involucrados'])): ?>
                    popupContent += `
                        <div class="popup-row">
                            <div class="popup-label">Objetos:</div>
                            <div class="popup-value"><?= $incident['objetos_involucrados'] ?></div>
                        </div>
                    `;
                <?php endif; ?>

                <?php if (!empty($incident['referencia_lugar'])): ?>
                    popupContent += `
                        <div class="popup-row">
                            <div class="popup-label">Referencia:</div>
                            <div class="popup-value"><?= $incident['referencia_lugar'] ?></div>
                        </div>
                    `;
                <?php endif; ?>

                marker.bindPopup(popupContent);
                
            } catch (e) {
                console.error("Error with incident <?= $incident['folio_incidente'] ?>:", e);
            }
        <?php endforeach; ?>

        // Add layer control
        const overlayMaps = {
            "Incidentes": map
        };
    </script>
</body>
</html>