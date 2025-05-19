<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../db.php'; // This should contain your PDO connection

// Verify user is logged in
if (!isset($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

// Get incident folio safely
$folio_incidente = isset($_GET['folio']) ? intval($_GET['folio']) : null;

// If you need to validate the folio exists in database, you could add:
if ($folio_incidente) {
    try {
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM incidentes WHERE folio_incidente = :folio");
        $stmt->bindParam(':folio', $folio_incidente, PDO::PARAM_INT);
        $stmt->execute();
        if ($stmt->fetchColumn() == 0) {
            $folio_incidente = null; // Invalid folio
        }
    } catch (PDOException $e) {
        error_log("Database error: " . $e->getMessage());
        // Continue with folio as null if there's a database error
        $folio_incidente = null;
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Despachador</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            background-color: #f5f5f5;
        }
        
        .blue-bar {
            background-color: #93D8E8;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
        }
        
        .logo {
            position: absolute;
            top: 50%;
            right: 20px;
            transform: translateY(-50%);
            max-height: 50px;
            width: auto;
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .folio-display {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            width: 100%;
            text-align: center;
        }
        
        .folio-number {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }
        
        .no-folio {
            font-size: 18px;
            color: #777;
            font-style: italic;
        }
        
        .buttons-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            width: 100%;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .action-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 15px 30px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 18px;
            margin: 10px 0;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.3s ease;
            flex: 1;
            min-width: 250px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .action-button:hover {
            background-color: #45a049;
            transform: translateY(-3px);
            box-shadow: 0 6px 8px rgba(0,0,0,0.15);
        }
        
        .action-button.mensajes {
            background-color: #2196F3;
        }
        
        .action-button.mensajes:hover {
            background-color: #0b7dda;
        }
        
        .action-button.notificaciones {
            background-color: #ff9800;
        }
        
        .action-button.notificaciones:hover {
            background-color: #e68a00;
        }
        
        .action-button.pdf {
            background-color: #9c27b0;
        }
        
        .action-button.pdf:hover {
            background-color: #7b1fa2;
        }
        
        .action-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .pdf-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            width: 100%;
            gap: 20px;
        }
        
        .pdf-box {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 20px;
            text-align: center;
            flex: 1;
            min-width: 300px;
            transition: all 0.3s ease;
        }
        
        .pdf-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .pdf-box h3 {
            color: #333;
            margin-bottom: 15px;
        }
        
        .pdf-link {
            display: inline-block;
            background-color: #9c27b0;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        
        .pdf-link:hover {
            background-color: #7b1fa2;
        }
        
        @media (max-width: 768px) {
            .buttons-container, .pdf-container {
                flex-direction: column;
            }
            
            .action-button, .pdf-box {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="blue-bar">
        <span>SISTEMA DE DESPACHO CAD</span>
        <img src="../logo.png" alt="Logo" class="logo">
    </div>
    
    <div class="container">
        <div class="folio-display">
            <h2>INCIDENTE ACTUAL</h2>
            <?php if ($folio_incidente): ?>
                <div class="folio-number">FOLIO: #<?= htmlspecialchars($folio_incidente) ?></div>
            <?php else: ?>
                <div class="no-folio">No hay incidente asignado actualmente</div>
            <?php endif; ?>
        </div>
        
        <div class="buttons-container">
            <a href="../chat/operador_chat.php?folio=<?= $folio_incidente ? htmlspecialchars($folio_incidente) : '' ?>" 
               class="action-button mensajes <?= !$folio_incidente ? 'disabled' : '' ?>" 
               <?= !$folio_incidente ? 'onclick="return false;"' : '' ?>>
                <i class="fas fa-comments"></i> MENSAJES
            </a>
            
            <a href="../despachador/asignar_recursos.php?folio=<?= $folio_incidente ? htmlspecialchars($folio_incidente) : '' ?>" 
               class="action-button <?= !$folio_incidente ? 'disabled' : '' ?>" 
               <?= !$folio_incidente ? 'onclick="return false;"' : '' ?>>
                <i class="fas fa-tasks"></i> ASIGNAR RECURSOS
            </a>
            
            <a href="../despachador/enviar_notificacion.php?folio=<?= $folio_incidente ? htmlspecialchars($folio_incidente) : '' ?>" 
               class="action-button notificaciones <?= !$folio_incidente ? 'disabled' : '' ?>" 
               <?= !$folio_incidente ? 'onclick="return false;"' : '' ?>>
                <i class="fas fa-bell"></i> ENVIAR NOTIFICACIÓN
            </a>
        </div>
        
        <h2 style="width: 100%; text-align: center; margin: 20px 0; color: #333;">DOCUMENTOS RELACIONADOS</h2>
        
        <div class="pdf-container">
            <div class="pdf-box">
                <h3>Protocolo de Emergencia</h3>
                <p>Documento con los protocolos a seguir en caso de emergencia</p>
                <a href="../protocolo1.pdf" class="pdf-link" target="_blank">
                    <i class="fas fa-file-pdf"></i> Ver PDF
                </a>
            </div>
            
            <div class="pdf-box">
                <h3>Manual de Procedimientos</h3>
                <p>Manual completo de procedimientos para despachadores</p>
                <a href="../protocolo3.pdf" class="pdf-link" target="_blank">
                    <i class="fas fa-file-pdf"></i> Ver PDF
                </a>
            </div>
            
            <div class="pdf-box">
                <h3>PDF</h3>
                <p>PDF</p>
                <a href="../protocolo2.pdf" class="pdf-link" target="_blank">
                    <i class="fas fa-file-pdf"></i> Ver PDF
                </a>
            </div>
        </div>
    </div>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const folio = <?= $folio_incidente ? 'true' : 'false' ?>;
            if (!folio) {
                const buttons = document.querySelectorAll('.action-button');
                buttons.forEach(button => {
                    button.style.pointerEvents = 'none';
                    button.style.opacity = '0.6';
                });
            }
        });
    </script>
</body>
</html>