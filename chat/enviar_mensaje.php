<?php
session_start();
require_once __DIR__ . '/../db.php';

header('Content-Type: application/json');

// Verificar sesión
if (!isset($_SESSION['id_usuario'])) {
    echo json_encode(['success' => false, 'error' => 'No autenticado']);
    exit();
}

// Validar datos
if (!isset($_POST['incidente_id']) || !isset($_POST['mensaje']) || !isset($_POST['remitente_tipo'])) {
    echo json_encode(['success' => false, 'error' => 'Datos incompletos']);
    exit();
}

$incidente_id = (int)$_POST['incidente_id'];
$mensaje = trim($_POST['mensaje']);
$remitente_id = (int)$_SESSION['id_usuario'];
$remitente_tipo = $_POST['remitente_tipo']; // 'operador' o 'unidad'

if (empty($mensaje)) {
    echo json_encode(['success' => false, 'error' => 'El mensaje no puede estar vacío']);
    exit();
}

// Verificar que el usuario tiene permiso para enviar mensajes sobre este incidente
$permiso = false;

if ($remitente_tipo == 'operador') {
    // Para operadores/despachadores: verificar que el incidente está asignado a ellos
    $query = "SELECT 1 FROM incidentes 
              WHERE folio_incidente = ? 
              AND (id_usuario_reporta = ? OR id_despachador_asignado = ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("iii", $incidente_id, $remitente_id, $remitente_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $permiso = $result->num_rows > 0;
} else {
    // Para unidades: verificar que la unidad está asignada al incidente
    $query = "SELECT 1 FROM asignaciones_unidades 
              WHERE id_incidente = ? 
              AND id_unidad = (SELECT id_personal FROM usuarios WHERE id_usuario = ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ii", $incidente_id, $remitente_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $permiso = $result->num_rows > 0;
}

if (!$permiso) {
    echo json_encode(['success' => false, 'error' => 'No tienes permiso para enviar mensajes sobre este incidente']);
    exit();
}

// Insertar mensaje en la base de datos
try {
    $query = "INSERT INTO mensajes (incidente_id, usuario_id, mensaje, fecha, remitente_tipo)
              VALUES (?, ?, ?, NOW(), ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("iiss", $incidente_id, $remitente_id, $mensaje, $remitente_tipo);
    $stmt->execute();
    
    echo json_encode(['success' => true]);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => 'Error en la base de datos: ' . $e->getMessage()]);
}
?>