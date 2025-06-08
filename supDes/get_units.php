<?php
require_once '../db.php';

header('Content-Type: application/json');

try {
    $query = "SELECT id, acronimo, latitud, longitud, 
                     DATE_FORMAT(ultima_actualizacion, '%d/%m/%Y %H:%i') as fecha_actualizacion 
              FROM unidades_fuerza 
              WHERE activo = 1";
    $stmt = $pdo->prepare($query);
    $stmt->execute();
    $unidades = $stmt->fetchAll();
    
    echo json_encode($unidades);
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener datos']);
}
?>