<?php
require_once '../db.php';

// 1. Get all incidents with coordinates
$incidents = $pdo->query(
    "SELECT folio_incidente, latitud, longitud 
     FROM incidentes 
     WHERE latitud IS NOT NULL AND longitud IS NOT NULL"
)->fetchAll(PDO::FETCH_ASSOC);

// 2. Get all locations
$locations = $pdo->query(
    "SELECT id_location, nombre, latitud, longitud 
     FROM locations"
)->fetchAll(PDO::FETCH_ASSOC);

// 3. Find nearest location for each incident (PHP-side calculation)
$incidentsWithNearest = [];
foreach ($incidents as $incident) {
    $minDistance = PHP_FLOAT_MAX;
    $nearestLocation = null;
    
    foreach ($locations as $location) {
        $distance = sqrt(
            pow($incident['latitud'] - $location['latitud'], 2) + 
            pow($incident['longitud'] - $location['longitud'], 2)
        );
        
        if ($distance < $minDistance) {
            $minDistance = $distance;
            $nearestLocation = $location;
        }
    }
    
    if ($nearestLocation) {
        $incidentsWithNearest[] = [
            'incident' => $incident,
            'nearest_location' => $nearestLocation,
            'distance' => $minDistance
        ];
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Nearest Location Finder</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <style>
        #map {
            height: 700px;
            width: 100%;
            border: 2px solid #3498db;
        }
        .info-panel {
            padding: 10px;
            background: #f8f9fa;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="info-panel">
        <h2>Nearest Locations to Incidents</h2>
        <p>Showing <?= count($incidentsWithNearest) ?> incidents with routes</p>
    </div>
    
    <div id="map"></div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>
    <script>
        // Initialize map
        const map = L.map('map').setView([19.4326, -99.1332], 12);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

        // Store all routes
        const routeControls = [];

        // Process PHP data in JavaScript
        const routes = <?= json_encode($incidentsWithNearest) ?>;

        // Add markers and routes
        routes.forEach(route => {
            const incident = route.incident;
            const location = route.nearest_location;
            
            // Incident marker (red)
            L.marker([incident.latitud, incident.longitud], {
                icon: L.icon({
                    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png',
                    iconSize: [25, 41]
                })
            }).addTo(map).bindPopup(`Incident #${incident.folio_incidente}`);
            
            // Location marker (blue)
            L.marker([location.latitud, location.longitud], {
                icon: L.icon({
                    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png',
                    iconSize: [25, 41]
                })
            }).addTo(map).bindPopup(`${location.nombre}<br>Distance: ${route.distance.toFixed(6)}`);
            
            // Add route
            const routeControl = L.Routing.control({
                waypoints: [
                    L.latLng(incident.latitud, incident.longitud),
                    L.latLng(location.latitud, location.longitud)
                ],
                lineOptions: { styles: [{ color: '#3498db', weight: 3 }] },
                show: false, // Hide instructions panel
                addWaypoints: false,
                draggableWaypoints: false
            }).addTo(map);
            
            routeControls.push(routeControl);
        });

        // Fit map to show all routes
        if (routes.length > 0) {
            const group = new L.featureGroup(
                routes.map(route => [
                    [route.incident.latitud, route.incident.longitud],
                    [route.nearest_location.latitud, route.nearest_location.longitud]
                ]).flat()
            );
            map.fitBounds(group.getBounds());
        }
    </script>
</body>
</html>