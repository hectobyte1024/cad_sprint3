<?php
require_once '../db.php';

// Get all incidents with coordinates
$incidents = $pdo->query(
    "SELECT folio_incidente, latitud, longitud 
     FROM incidentes 
     WHERE latitud IS NOT NULL AND longitud IS NOT NULL"
)->fetchAll(PDO::FETCH_ASSOC);

// Get all locations
$locations = $pdo->query(
    "SELECT id_location, nombre, latitud, longitud 
     FROM locations"
)->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Incident Navigator</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <style>
        #map {
            height: 600px;
            width: 100%;
            border: 2px solid #3498db;
            margin-bottom: 10px;
        }
        .controls {
            padding: 10px;
            background: #f8f9fa;
            display: flex;
            gap: 10px;
            align-items: center;
        }
        button {
            padding: 8px 15px;
            cursor: pointer;
        }
        .incident-info {
            padding: 10px;
            background: #e9f7fe;
            border-left: 4px solid #3498db;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>Incident Navigator</h1>
    
    <div class="incident-info" id="incidentInfo">
        Select an incident to begin
    </div>
    
    <div class="controls">
        <button id="prevBtn">Previous</button>
        <span id="counter">0 / <?= count($incidents) ?></span>
        <button id="nextBtn">Next</button>
    </div>
    
    <div id="map"></div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>
    <script>
        // Initialize map
        const map = L.map('map').setView([19.4326, -99.1332], 12);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

        // Store data
        const incidents = <?= json_encode($incidents) ?>;
        const locations = <?= json_encode($locations) ?>;
        let currentIndex = -1;
        let currentRoute = null;

        // Find nearest location to an incident
        function findNearestLocation(incident) {
            let minDistance = Infinity;
            let nearestLoc = null;
            
            locations.forEach(location => {
                const dist = Math.sqrt(
                    Math.pow(incident.latitud - location.latitud, 2) + 
                    Math.pow(incident.longitud - location.longitud, 2)
                );
                
                if (dist < minDistance) {
                    minDistance = dist;
                    nearestLoc = location;
                }
            });
            
            return nearestLoc;
        }

        // Display incident and route
        function showIncident(index) {
            // Clear previous
            if (currentRoute) map.removeControl(currentRoute);
            map.eachLayer(layer => {
                if (layer instanceof L.Marker) map.removeLayer(layer);
            });

            // Get incident data
            const incident = incidents[index];
            const nearestLoc = findNearestLocation(incident);
            
            // Update UI
            document.getElementById('counter').textContent = `${index + 1} / ${incidents.length}`;
            document.getElementById('incidentInfo').innerHTML = `
                <strong>Incident #${incident.folio_incidente}</strong><br>
                Nearest location: <strong>${nearestLoc.nombre}</strong>
            `;
            
            // Add markers
            const incidentMarker = L.marker([incident.latitud, incident.longitud], {
                icon: L.icon({
                    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png',
                    iconSize: [25, 41]
                })
            }).addTo(map).bindPopup(`Incident #${incident.folio_incidente}`);
            
            const locationMarker = L.marker([nearestLoc.latitud, nearestLoc.longitud], {
                icon: L.icon({
                    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png',
                    iconSize: [25, 41]
                })
            }).addTo(map).bindPopup(nearestLoc.nombre);
            
            // Add route
            currentRoute = L.Routing.control({
                waypoints: [
                    L.latLng(incident.latitud, incident.longitud),
                    L.latLng(nearestLoc.latitud, nearestLoc.longitud)
                ],
                lineOptions: { styles: [{ color: '#3498db', weight: 4 }] },
                show: false,
                addWaypoints: false,
                fitSelectedRoutes: false // Disable automatic fitting by routing machine
            }).addTo(map);
            
            // Calculate optimal view with padding
            const incidentPoint = L.latLng(incident.latitud, incident.longitud);
            const locationPoint = L.latLng(nearestLoc.latitud, nearestLoc.longitud);
            
            const bounds = L.latLngBounds([incidentPoint, locationPoint]);
            
            // Apply padding (in pixels) and set maxZoom to prevent over-zooming
            map.fitBounds(bounds, {
                padding: [50, 50], // Adds 50px padding on all sides
                maxZoom: 14, // Prevents zooming too close
                animate: true // Smooth transition
            });
        }


        // Navigation controls
        document.getElementById('prevBtn').addEventListener('click', () => {
            if (currentIndex > 0) {
                currentIndex--;
                showIncident(currentIndex);
            }
        });

        document.getElementById('nextBtn').addEventListener('click', () => {
            if (currentIndex < incidents.length - 1) {
                currentIndex++;
                showIncident(currentIndex);
            }
        });

        // Initialize first incident
        if (incidents.length > 0) {
            currentIndex = 0;
            showIncident(currentIndex);
        }
    </script>
</body>
</html>