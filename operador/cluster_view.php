<?php
session_start();
require_once '../db.php';

// Get call clusters (grouped by location only, since emergency type isn't available)
$query = "SELECT 
            ROUND(l.latitud, 3) as cluster_lat, 
            ROUND(l.longitud, 3) as cluster_lng,
            COUNT(*) as call_count,
            GROUP_CONCAT(l.id_llamada) as call_ids,
            MIN(l.fecha) as first_call,
            MAX(l.fecha) as last_call
          FROM llamadas l
          WHERE l.latitud IS NOT NULL AND l.longitud IS NOT NULL
          GROUP BY cluster_lat, cluster_lng
          HAVING call_count > 1
          ORDER BY call_count DESC";
$clusters = $pdo->query($query)->fetchAll(PDO::FETCH_ASSOC);
$calls = $pdo->query(
    "SELECT id_llamada, latitud, longitud, fecha 
    FROM llamadas 
    WHERE latitud IS NOT NULL AND longitud IS NOT NULL")->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Call Clusters</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <style>
        #clusterMap { height: 600px; }
        .cluster-info { margin: 20px; padding: 15px; background: #f8f9fa; border-radius: 5px; }
        .cluster-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .cluster-table th, .cluster-table td { border: 1px solid #ddd; padding: 8px; }
        .cluster-table tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Call Clusters</h1>
    
    <div class="cluster-info">
        <p>Total clusters found: <?= count($clusters) ?></p>
    </div>
    
    <div id="clusterMap"></div>
    
    <table class="cluster-table">
        <thead>
            <tr>
                <th>Location</th>
                <th>Call Count</th>
                <th>Time Range</th>
                <th>Call IDs</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($clusters as $cluster): ?>
            <tr>
                <td><?= $cluster['cluster_lat'] ?>, <?= $cluster['cluster_lng'] ?></td>
                <td><?= $cluster['call_count'] ?></td>
                <td>
                    <?= date('H:i', strtotime($cluster['first_call'])) ?> - 
                    <?= date('H:i', strtotime($cluster['last_call'])) ?>
                </td>
                <td><?= $cluster['call_ids'] ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <script>
        const map = L.map('clusterMap').setView([19.4326, -99.1332], 11);
        
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map);

        // Add cluster markers
        <?php foreach ($clusters as $cluster): ?>
            L.circleMarker(
                [<?= $cluster['cluster_lat'] ?>, <?= $cluster['cluster_lng'] ?>], 
                {
                    radius: <?= min(10 + $cluster['call_count'] * 2, 30) ?>,
                    fillColor: "#ff7800",
                    color: "#000",
                    weight: 1,
                    opacity: 1,
                    fillOpacity: 0.8
                }
            ).addTo(map).bindPopup(`
                <b>Location:</b> <?= $cluster['cluster_lat'] ?>, <?= $cluster['cluster_lng'] ?><br>
                <b>Call Count:</b> <?= $cluster['call_count'] ?><br>
                <b>Time Range:</b> <?= date('H:i', strtotime($cluster['first_call'])) ?> - <?= date('H:i', strtotime($cluster['last_call'])) ?><br>
                <b>Call IDs:</b> <?= $cluster['call_ids'] ?>
            `);
        <?php endforeach; ?>


// ...existing code...
    // Add cluster markers
    <?php foreach ($clusters as $cluster): ?>
        L.circleMarker(
            [<?= $cluster['cluster_lat'] ?>, <?= $cluster['cluster_lng'] ?>], 
            {
                radius: <?= min(10 + $cluster['call_count'] * 2, 30) ?>,
                fillColor: "#ff7800",
                color: "#000",
                weight: 1,
                opacity: 1,
                fillOpacity: 0.8
            }
        ).addTo(map).bindPopup(`
            <b>Location:</b> <?= $cluster['cluster_lat'] ?>, <?= $cluster['cluster_lng'] ?><br>
            <b>Call Count:</b> <?= $cluster['call_count'] ?><br>
            <b>Time Range:</b> <?= date('H:i', strtotime($cluster['first_call'])) ?> - <?= date('H:i', strtotime($cluster['last_call'])) ?><br>
            <b>Call IDs:</b> <?= $cluster['call_ids'] ?>
        `);
    <?php endforeach; ?>

    // Add individual call markers
    <?php foreach ($calls as $call): ?>
        L.marker(
            [<?= $call['latitud'] ?>, <?= $call['longitud'] ?>],
            { icon: L.icon({ iconUrl: 'https://unpkg.com/leaflet@1.7.1/dist/images/marker-icon.png', iconAnchor: [12, 41] }) }
        ).addTo(map).bindPopup(
            `<b>Call ID:</b> <?= $call['id_llamada'] ?><br><b>Date:</b> <?= date('d/m/Y H:i', strtotime($call['fecha'])) ?>`
        );
    <?php endforeach; ?>
// ...existing code...
    </script>
</body>
</html>