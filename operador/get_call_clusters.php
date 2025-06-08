<?php
session_start();
require_once '../db.php';

// Get call clusters (grouped by emergency type and location)
$query = "
    SELECT 
        id_emergency_type,
        COUNT(*) as call_count,
        AVG(latitud) as avg_lat,
        AVG(longitud) as avg_lng,
        MAX(fecha) as last_call_time
    FROM llamadas
    WHERE estatus IN ('Atender', 'Clasificada')
    GROUP BY id_emergency_type, 
             FLOOR(latitud * 100),  -- Rough grouping by location
             FLOOR(longitud * 100)
    HAVING COUNT(*) > 1  -- Only show actual clusters
    ORDER BY last_call_time DESC
";

$stmt = $pdo->query($query);
$clusters = $stmt->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: application/json');
echo json_encode($clusters);