<?php
session_start();
require_once __DIR__ . '/../db.php';

// Verificar sesión
if (!isset($_SESSION['id_usuario'])) {
    die('No autenticado');
}

// Validar datos
if (!isset($_GET['incidente_id'])) {
    die('Datos incompletos');
}

$incidente_id = (int)$_GET['incidente_id'];
$usuario_id = (int)$_SESSION['id_usuario'];

// Verificar que el usuario tiene permiso para ver mensajes de este incidente
$permiso = false;

// Para operadores/despachadores
$query = "SELECT 1 FROM incidentes 
          WHERE folio_incidente = ? 
          AND (id_usuario_reporta = ? OR id_despachador_asignado = ?)";
$stmt = $conn->prepare($query);
$stmt->bind_param("iii", $incidente_id, $usuario_id, $usuario_id);
$stmt->execute();
$result = $stmt->get_result();
$permiso = $result->num_rows > 0;

// Si no es operador/despachador, verificar si es unidad asignada
if (!$permiso) {
    $query = "SELECT 1 FROM asignaciones_unidades 
              WHERE id_incidente = ? 
              AND id_unidad = (SELECT id_personal FROM usuarios WHERE id_usuario = ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ii", $incidente_id, $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $permiso = $result->num_rows > 0;
}

if (!$permiso) {
    die('No tienes permiso para ver mensajes de este incidente');
}

// Obtener mensajes del incidente
$query = "SELECT m.*, u.nombre, u.apellido 
          FROM mensajes m
          JOIN usuarios u ON m.usuario_id = u.id_usuario
          WHERE m.incidente_id = ?
          ORDER BY m.fecha ASC";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $incidente_id);
$stmt->execute();
$result = $stmt->get_result();
$mensajes = $result->fetch_all(MYSQLI_ASSOC);

foreach ($mensajes as $mensaje) {
    $clase = ($mensaje['usuario_id'] == $usuario_id) ? 'mensaje-propio' : 'mensaje-otro';
    $nombre = htmlspecialchars($mensaje['nombre'] . ' ' . $mensaje['apellido']);
    $texto = htmlspecialchars($mensaje['mensaje']);
    $hora = date('H:i', strtotime($mensaje['fecha']));
    
    echo "<div class='mensaje $clase'>";
    echo "<div class='mensaje-cabecera'><strong>$nombre</strong> <span class='hora'>$hora</span></div>";
    echo "<div class='mensaje-texto'>$texto</div>";
    echo "</div>";
}
?>