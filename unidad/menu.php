<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Unidad </title>
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
            <?php
            $folio_incidente = isset($_GET['folio']) ? $_GET['folio'] : null;
            
            if ($folio_incidente) {
                echo '<div class="folio-number">FOLIO: #' . htmlspecialchars($folio_incidente) . '</div>';
            } else {
                echo '<div class="no-folio">No hay incidente asignado actualmente</div>';
            }
            ?>
        </div>
        
        <div class="buttons-container">
            <a href="../chat/unidad_chat.php?folio=<?php echo $folio_incidente ? htmlspecialchars($folio_incidente) : ''; ?>" class="action-button mensajes <?php echo !$folio_incidente ? 'disabled' : ''; ?>" <?php echo !$folio_incidente ? 'onclick="return false;"' : ''; ?>>
                <i class="fas fa-comments"></i> MENSAJES
            </a>
        </div>
    </div>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const folio = '<?php echo $folio_incidente ? "true" : "false"; ?>';
            if (folio === 'false') {
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