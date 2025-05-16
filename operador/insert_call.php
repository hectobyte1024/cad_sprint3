<?php
session_start();
require_once '../db.php';

header('Content-Type: application/json');

try {
    // Check POST parameters
    if (!isset($_POST['quepaso']) || !isset($_POST['tipo_auxilio']) || !isset($_POST['num_personas']) || 
        !isset($_POST['telefono']) || !isset($_POST['clasificacion']) || !isset($_POST['prioridad']) || 
        !isset($_POST['latitud']) || !isset($_POST['longitud'])) {
        throw new Exception('Faltan datos');
    }

    // Insert incident first
    $quepaso = trim($_POST['quepaso']);
    $tipo_auxilio = trim($_POST['tipo_auxilio']);
    $num_personas = intval($_POST['num_personas']);
    $telefono = trim($_POST['telefono']);
    $clasificacion = trim($_POST['clasificacion']);
    $prioridad = trim($_POST['prioridad']);
    $latitud = trim($_POST['latitud']);
    $longitud = trim($_POST['longitud']);
    $id_usuario_reporta = $_SESSION['id_usuario'] ?? NULL;

    $conn->begin_transaction();

    // Insert incident
    $stmt = $conn->prepare("INSERT INTO incidentes (quepaso, tipo_auxilio, hora_incidente, fecha_incidente, num_personas, telefono, id_usuario_reporta, clasificacion, prioridad, latitud, longitud) 
        VALUES (?, ?, CURTIME(), NOW(), ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sisisssss", $quepaso, $tipo_auxilio, $num_personas, $telefono, $id_usuario_reporta, $clasificacion, $prioridad, $latitud, $longitud);
    $stmt->execute();
    $incident_id = $conn->insert_id;

    // Insert call record
    $random_operator = rand(1, 3); // Assign to random operator
    $stmt = $conn->prepare("INSERT INTO llamadas (id_operador, id_incidente, estatus) VALUES (?, ?, 'Atender')");
    $stmt->bind_param("ii", $random_operator, $incident_id);
    $stmt->execute();

    $conn->commit();

    echo json_encode(['success' => true, 'incident_id' => $incident_id]);
} catch (Exception $e) {
    $conn->rollback();
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>