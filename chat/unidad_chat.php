<?php
session_start();
require_once __DIR__ . '/../db.php';


// Verificación de sesión y rol
if (!isset($_SESSION['id_usuario']) || !isset($_SESSION['rol_id']) || !in_array($_SESSION['rol_id'], [6, 7])) {
    header("Location: ../login.php");
    exit();
}

// Verificar que la unidad existe
if (!isset($_SESSION['id_unidad'])) {
    die("Error: No se ha asignado una unidad a este usuario");
}

// Obtener incidentes asignados a ESTA unidad específica
$query = "SELECT i.folio_incidente, i.quepaso, i.fecha_incidente
          FROM asignaciones_unidades au
          JOIN incidentes i ON au.id_incidente = i.folio_incidente
          WHERE au.id_unidad = ?
          ORDER BY i.fecha_incidente DESC";
          
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $_SESSION['id_unidad']);
$stmt->execute();
$result = $stmt->get_result();
$incidentes = $result->fetch_all(MYSQLI_ASSOC);


// 4. Manejar el incidente seleccionado
$incidente_actual = isset($_GET['incidente_id']) ? (int)$_GET['incidente_id'] : null;

// Verificar que el incidente está asignado a esta unidad
if ($incidente_actual) {
    $query = "SELECT 1 FROM asignaciones_unidades 
              WHERE id_incidente = ? AND id_unidad = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ii", $incidente_actual, $id_unidad);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows === 0) {
        $incidente_actual = null; // No está asignado
    }
}

// 5. Configurar tipo de unidad para la interfaz
$tipo_unidad = ($rol_usuario == 6) ? 'Bomberos' : 'Patrulla';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat de <?= $tipo_unidad ?></title>
    <link rel="stylesheet" href="estilos_chat.css">
</head>
<body>
    <div class="chat-container">
        <h1>Chat de <?= $tipo_unidad ?></h1>
        
        <!-- Lista de incidentes asignados -->
        <div class="incidentes-list">
            <h2>Tus Incidentes Asignados</h2>
            <?php if (!empty($incidentes)): ?>
                <ul>
                    <?php foreach ($incidentes as $incidente): ?>
                        <li>
                            <a href="unidad_chat.php?incidente_id=<?= $incidente['folio_incidente'] ?>">
                                Incidente #<?= $incidente['folio_incidente'] ?>: 
                                <?= htmlspecialchars(substr($incidente['quepaso'], 0, 30)) ?>...
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            <?php else: ?>
                <p>No tienes incidentes asignados actualmente</p>
            <?php endif; ?>
        </div>
        
        <!-- Área de chat (solo si hay incidente seleccionado) -->
        <?php if ($incidente_actual): ?>
            <?php
            // Obtener detalles del incidente
            $query = "SELECT quepaso FROM incidentes WHERE folio_incidente = ?";
            $stmt = $conn->prepare($query);
            $stmt->bind_param("i", $incidente_actual);
            $stmt->execute();
            $result = $stmt->get_result();
            $incidente_data = $result->fetch_assoc();
            ?>
            
            <div class="chat-area">
                <h2>Comunicación sobre Incidente #<?= $incidente_actual ?></h2>
                <p><strong>Descripción:</strong> <?= htmlspecialchars($incidente_data['quepaso']) ?></p>
                
                <!-- Contenedor de mensajes -->
                <div class="mensajes-container" id="mensajes-container">
                    <!-- Los mensajes se cargan via AJAX -->
                </div>
                
                <!-- Formulario para enviar mensajes -->
                <form id="form-mensaje" class="mensaje-form">
                    <input type="hidden" name="incidente_id" value="<?= $incidente_actual ?>">
                    <input type="hidden" name="remitente_id" value="<?= $id_usuario ?>">
                    <input type="hidden" name="remitente_tipo" value="unidad">
                    
                    <textarea name="mensaje" placeholder="Escribe tu mensaje al operador..." required></textarea>
                    <button type="submit">Enviar Mensaje</button>
                </form>
            </div>
        <?php elseif (!empty($incidentes)): ?>
            <div class="no-seleccionado">
                <p>Selecciona un incidente para comunicarte con el operador</p>
            </div>
        <?php endif; ?>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Cargar mensajes iniciales
            if ($('#mensajes-container').length) {
                cargarMensajes();
                setInterval(cargarMensajes, 3000); // Actualizar cada 3 segundos
            }
            
            // Enviar mensaje
            $('#form-mensaje').submit(function(e) {
                e.preventDefault();
                $.post('enviar_mensaje.php', $(this).serialize(), function(response) {
                    if (response.success) {
                        $('#form-mensaje textarea').val('');
                        cargarMensajes();
                    } else {
                        alert('Error: ' + response.error);
                    }
                }, 'json');
            });
        });
        
        function cargarMensajes() {
            const incidenteId = $('input[name="incidente_id"]').val();
            $.get('recibir_mensajes.php', {incidente_id: incidenteId}, function(data) {
                $('#mensajes-container').html(data);
                $('#mensajes-container').scrollTop($('#mensajes-container')[0].scrollHeight);
            });
        }
    </script>
</body>
</html>