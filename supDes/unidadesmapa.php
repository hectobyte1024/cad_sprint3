<?php
require_once '../db.php';

try {
    $query = "SELECT id, acronimo, latitud, longitud
              FROM unidades_fuerza 
              WHERE activo = 1";
    $stmt = $pdo->prepare($query);
    $stmt->execute();
    $unidades = $stmt->fetchAll();
    
} catch(PDOException $e) {
    error_log("Error en consulta: " . $e->getMessage());
    die("Error al cargar datos. Contacte al administrador.");
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <!-- Metadata mejorada -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Dashboard de seguimiento de unidades">
    <title>Sistema de Monitoreo - Ubicaciones de Unidades</title>
    
    <!-- Hojas de estilo -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --color-primary: #2c3e50;
            --color-secondary: #3498db;
            --color-light: #ecf0f1;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
        .header {
            background: var(--color-primary);
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .dashboard {
            display: flex;
            height: calc(100vh - 60px);
        }
        
        .sidebar {
            width: 320px;
            background: white;
            padding: 15px;
            overflow-y: auto;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        
        .map-container {
            flex-grow: 1;
            position: relative;
        }
        
        #map {
            height: 100%;
            z-index: 1;
        }
        
        .unidad-item {
            padding: 12px;
            margin-bottom: 8px;
            background: white;
            border-radius: 6px;
            cursor: pointer;
            border-left: 4px solid var(--color-secondary);
            transition: all 0.3s ease;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .unidad-item:hover {
            background: var(--color-light);
            transform: translateX(5px);
        }
        
        .unidad-info {
            font-size: 0.9em;
            color: #666;
            margin-top: 5px;
        }
        
        .search-box {
            margin-bottom: 15px;
        }
        
        #search {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .map-controls {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 1000;
            background: white;
            padding: 10px;
            border-radius: 4px;
            box-shadow: 0 1px 5px rgba(0,0,0,0.2);
        }
        
        .control-btn {
            display: block;
            margin-bottom: 5px;
            padding: 5px 10px;
            background: var(--color-primary);
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-map-marked-alt"></i> Sistema de Monitoreo</h1>
        <div id="last-update">Última actualización: <?= date('d/m/Y H:i') ?></div>
    </div>
    
    <div class="dashboard">
        <div class="sidebar">
            <div class="search-box">
                <input type="text" id="search" placeholder="Buscar unidad...">
            </div>
            <h2><i class="fas fa-list"></i> Lista de Unidades</h2>
            <div id="unidades-list">
                <?php foreach ($unidades as $unidad): ?>
                    <div class="unidad-item" 
                         data-id="<?= $unidad['id'] ?>"
                         data-lat="<?= htmlspecialchars($unidad['latitud']) ?>" 
                         data-lng="<?= htmlspecialchars($unidad['longitud']) ?>"
                         onclick="centrarMapa(<?= htmlspecialchars($unidad['latitud']) ?>, <?= htmlspecialchars($unidad['longitud']) ?>, '<?= htmlspecialchars($unidad['acronimo']) ?>')">
                        <strong><?= htmlspecialchars($unidad['acronimo']) ?></strong>
                        <div class="unidad-info">
                            <i class="fas fa-clock"></i> <?= $unidad['fecha_actualizacion'] ?>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
        
        <div class="map-container">
            <div id="map"></div>
            <div class="map-controls">
                <button class="control-btn" onclick="zoomToAll()">
                    <i class="fas fa-expand"></i> Ver todas
                </button>
                <button class="control-btn" onclick="refreshData()">
                    <i class="fas fa-sync-alt"></i> Actualizar
                </button>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    
    <script>
        // Variables globales
        var map;
        var markers = [];
        var markersLayer = L.layerGroup();
        
        // Inicialización del mapa
        function initMap() {
            map = L.map('map').setView([19.4326, -99.1332], 6);
            
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
            }).addTo(map);
            
            // Añadir capa de marcadores
            markersLayer.addTo(map);
            
            // Crear marcadores
            <?php foreach ($unidades as $unidad): ?>
                var marker = L.marker([<?= $unidad['latitud'] ?>, <?= $unidad['longitud'] ?>], {
                    unidadId: <?= $unidad['id'] ?>
                }).bindPopup(`
                    <b><?= addslashes($unidad['acronimo']) ?></b><br>
                    <small>Actualizado: <?= $unidad['fecha_actualizacion'] ?></small><br>
                    <small>Lat: <?= $unidad['latitud'] ?>, Lng: <?= $unidad['longitud'] ?></small>
                `);
                
                markers.push(marker);
                markersLayer.addLayer(marker);
            <?php endforeach; ?>
            
            // Ajustar vista a todos los marcadores
            if (markers.length > 0) {
                var grupo = new L.featureGroup(markers);
                map.fitBounds(grupo.getBounds().pad(0.2));
            }
        }
        
        // Funciones de utilidad
        function centrarMapa(lat, lng, nombre) {
            map.setView([lat, lng], 15);
            
            markers.forEach(function(marker) {
                if (marker.getLatLng().lat === lat && marker.getLatLng().lng === lng) {
                    marker.openPopup();
                }
            });
        }
        
        function zoomToAll() {
            if (markers.length > 0) {
                var grupo = new L.featureGroup(markers);
                map.fitBounds(grupo.getBounds().pad(0.2));
            }
        }
        
        function refreshData() {
            fetch('get_units.php')
                .then(response => response.json())
                .then(data => {
                    // Actualizar marcadores
                    markersLayer.clearLayers();
                    markers = [];
                    
                    data.forEach(unidad => {
                        var marker = L.marker([unidad.latitud, unidad.longitud], {
                            unidadId: unidad.id
                        }).bindPopup(`
                            <b>${unidad.acronimo}</b><br>
                            <small>Actualizado: ${unidad.fecha_actualizacion}</small><br>
                            <small>Lat: ${unidad.latitud}, Lng: ${unidad.longitud}</small>
                        `);
                        
                        markers.push(marker);
                        markersLayer.addLayer(marker);
                    });
                    
                    // Actualizar lista
                    document.getElementById('unidades-list').innerHTML = data.map(unidad => `
                        <div class="unidad-item" 
                             data-id="${unidad.id}"
                             data-lat="${unidad.latitud}" 
                             data-lng="${unidad.longitud}"
                             onclick="centrarMapa(${unidad.latitud}, ${unidad.longitud}, '${unidad.acronimo.replace(/'/g, "\\'")}')">
                            <strong>${unidad.acronimo}</strong>
                            <div class="unidad-info">
                                <i class="fas fa-clock"></i> ${unidad.fecha_actualizacion}
                            </div>
                        </div>
                    `).join('');
                    
                    document.getElementById('last-update').innerText = `Última actualización: ${new Date().toLocaleString()}`;
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error al actualizar datos');
                });
        }
        
        // Búsqueda en tiempo real
        document.getElementById('search').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const items = document.querySelectorAll('.unidad-item');
            
            items.forEach(item => {
                const text = item.textContent.toLowerCase();
                if (text.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });
        
        // Inicializar el mapa cuando el DOM esté listo
        document.addEventListener('DOMContentLoaded', initMap);
    </script>
</body>
</html>