<?php
session_start();
require_once '../db.php';

if (!isset($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

$folio_asignado = "";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['atender'])) {
    try {
        $id_despachador_actual = $_SESSION['id_usuario'];
        
        $pdo->beginTransaction();
        
        // 1. Find next incident to assign
        $sql = "SELECT folio_incidente 
                FROM incidentes 
                WHERE id_despachador_asignado IS NULL 
                ORDER BY 
                    CASE prioridad 
                        WHEN 'Alta' THEN 1 
                        WHEN 'Media' THEN 2 
                        WHEN 'Baja' THEN 3 
                    END,
                    fecha_incidente ASC
                LIMIT 1 FOR UPDATE"; // FOR UPDATE locks the row
        
        $stmt = $pdo->query($sql);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($row) {
            $folio_asignado = $row['folio_incidente'];
            
            // 2. Update the incident
            $update_sql = "UPDATE incidentes 
                          SET id_despachador_asignado = :id_despachador 
                          WHERE folio_incidente = :folio";
            
            $stmt = $pdo->prepare($update_sql);
            $stmt->bindParam(':id_despachador', $id_despachador_actual, PDO::PARAM_INT);
            $stmt->bindParam(':folio', $folio_asignado, PDO::PARAM_INT);
            
            if ($stmt->execute()) {
                $pdo->commit();
                header("Location: menu.php?folio=" . $folio_asignado);
                exit();
            } else {
                $pdo->rollBack();
                $folio_asignado = "Error al asignar incidente";
            }
        } else {
            $pdo->rollBack();
            $folio_asignado = "No hay incidentes pendientes para asignar";
        }
    } catch (PDOException $e) {
        $pdo->rollBack();
        error_log("Database error: " . $e->getMessage());
        $folio_asignado = "Error en el sistema. Por favor intente más tarde.";
    }
}
?>

<!-- Rest of your HTML remains exactly the same -->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Incidente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        
        .blue-bar {
            background-color: #93D8E8;
            color: white;
            padding: 30px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .logo {
            position: absolute;
            top: 50%;
            right: 20px;
            transform: translateY(-50%);
            max-height: 60px;
            width: auto;
        }
        
        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .card-header {
            border-bottom: 2px solid #93D8E8;
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-title {
            font-size: 20px;
            color: #2c3e50;
            margin: 0;
        }
        
        .btn-atender {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        
        .btn-atender:hover {
            background-color: #45a049;
        }
        
        .folio-info {
            margin-top: 20px;
            padding: 15px;
            background-color: #e8f5e9;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }
        
        @media (max-width: 768px) {
            .detail-grid {
                grid-template-columns: 1fr;
            }
            
            .blue-bar {
                font-size: 20px;
                padding: 20px;
            }
            
            .logo {
                max-height: 50px;
            }
        }
    </style>
</head>
<body>
    <div class="blue-bar">
        <img src="../logo.png" alt="Logo" class="logo">
        Detalles del Incidente 
    </div>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">ATENDER</h2>
            </div>
            
            <form method="post" action="">
                <button type="submit" name="atender" class="btn-atender">Atender Incidente</button>
            </form>
            
            <?php if (!empty($folio_asignado)): ?>
                <div class="folio-info">
                    <?php echo htmlspecialchars($folio_asignado); ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>