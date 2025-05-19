<?php

require '../db.php';

header('Content-Type: application/json');

$stmt = $pdo->query("SELECT * FROM locations");
$locations = $stmt->fetchAll();

foreach ($locations as &$loc) {
    $loc['color'] = match(true) {
        str_contains($loc['nombre'], 'Policía') => 'blue',
        str_contains($loc['nombre'], 'C2') => 'blue',
        str_contains($loc['nombre'], 'C5') => 'blue',
        str_contains($loc['nombre'], 'Hospital') => 'red',
        str_contains($loc['nombre'], 'Civil') => 'green',
        default => 'orange'
    };
}

echo json_encode($locations);

?>

