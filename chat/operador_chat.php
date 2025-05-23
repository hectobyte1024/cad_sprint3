<?php
session_start();
require_once __DIR__ . '/../db.php'; 


if (!isset($_GET['folio'])) {
    die("No se ha especificado un folio de incidente");
}
$folio_incidente = (int)$_GET['folio'];

$query = "SELECT i.folio_incidente, i.quepaso 
          FROM incidentes i 
          WHERE i.folio_incidente = ? 
          AND (i.id_usuario_reporta = ? OR i.id_despachador_asignado = ?)";
$stmt = $conn->prepare($query);
$stmt->bind_param("iii", $folio_incidente, $_SESSION['id_usuario'], $_SESSION['id_usuario']);
$stmt->execute();
$result = $stmt->get_result();
$incidente = $result->fetch_assoc();

if (!$incidente) {
    die("No tienes acceso a este incidente o no existe");
}

// Obtener unidades asignadas al incidente
$query_unidades = "SELECT u.id_unidad, u.nombre_unidad, t.nombre_tipo 
                   FROM asignaciones_unidades au
                   JOIN unidades u ON au.id_unidad = u.id_unidad
                   JOIN tipos_unidad t ON u.id_tipo_unidad = t.id_tipo
                   WHERE au.id_incidente = ?";
$stmt_unidades = $conn->prepare($query_unidades);
$stmt_unidades->bind_param("i", $folio_incidente);
$stmt_unidades->execute();
$result_unidades = $stmt_unidades->get_result();
$unidades_asignadas = $result_unidades->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Operador - Incidente #<?= $folio_incidente ?></title>
    <link rel="stylesheet" href="estilos_chat.css">
</head>
<body>
    <div class="chat-container">
        <h1>Chat para Incidente #<?= $folio_incidente ?></h1>
        <h2><?= htmlspecialchars($incidente['quepaso']) ?></h2>
        
        <div class="unidades-list">
            <h3>Unidades Asignadas:</h3>
            <ul>
                <?php foreach ($unidades_asignadas as $unidad): ?>
                    <li><?= htmlspecialchars($unidad['nombre_tipo']) ?> - <?= htmlspecialchars($unidad['nombre_unidad']) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
        
        <div class="mensajes-container" id="mensajes-container">
            <!-- Los mensajes se cargarán aquí via AJAX -->
        </div>
        
        <form id="form-mensaje" class="mensaje-form">
            <input type="hidden" name="incidente_id" value="<?= $folio_incidente ?>">
            <input type="hidden" name="remitente_id" value="<?= $_SESSION['id_usuario'] ?>">
            <input type="hidden" name="remitente_tipo" value="operador">
            
            <textarea name="mensaje" placeholder="Escribe tu mensaje..." required></textarea>
            <button type="submit">Enviar</button>
        </form>
        <button class="btn-regresar" onclick="window.history.back();">
            ← Regresar
        </button>
        
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Cargar mensajes iniciales
            cargarMensajes();
            
            // Actualizar mensajes cada 3 segundos
            setInterval(cargarMensajes, 3000);
            
            // Enviar mensaje
            $('#form-mensaje').submit(function(e) {
                e.preventDefault();
                
                $.post('enviar_mensaje.php', $(this).serialize(), function(response) {
                    if (response.success) {
                        $('#form-mensaje textarea').val('');
                        cargarMensajes();
                    } else {
                        alert('Error al enviar el mensaje: ' + response.error);
                    }
                }, 'json');
            });
        });
        
        function cargarMensajes() {
            const incidenteId = <?= $folio_incidente ?>;
            
            $.get('recibir_mensajes.php', {incidente_id: incidenteId}, function(data) {
                $('#mensajes-container').html(data);
                // Scroll al final
                $('#mensajes-container').scrollTop($('#mensajes-container')[0].scrollHeight);
            });
        }
    </script>
</body>
</html>