<?php
session_start();
require_once '../db.php';

$prank_calls = [];
$error = null;

try {
    $sql = "SELECT pc.folio_prank_call, pc.motivo, pc.tipo_broma, 
                   pc.hora_prank_call, pc.fecha_prank_call, pc.clasificacion,
                   pc.telefono_origen, pc.acciones_tomadas, pc.bloqueo_numero,
                   CONCAT(u.nombre, ' ', u.apellido) as operador,
                   CASE 
                       WHEN pc.clasificacion = 'Inocente' THEN 'clasificacion-inocente'
                       WHEN pc.clasificacion = 'Molesta' THEN 'clasificacion-molesta'
                       ELSE 'clasificacion-peligrosa'
                   END as clase_clasificacion
            FROM prank_calls pc
            JOIN llamadas l ON pc.id_llamada = l.id_llamada
            JOIN usuarios u ON l.id_operador = u.id_usuario
            ORDER BY pc.fecha_prank_call DESC";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $prank_calls = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    $error = "Error al obtener datos: " . $e->getMessage();
}

// No need to close connection explicitly in PDO
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Llamadas Falsas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        
        .blue-bar {
            background-color: #93D8E8;
            color: white;
            padding: 40px;
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
            max-height: 70px;
            width: auto;
        }
        
        .search-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .search-box {
            display: flex;
            margin-bottom: 20px;
        }
        
        .search-box input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            font-size: 16px;
        }
        
        .search-box button {
            padding: 10px 20px;
            background-color: #93D8E8;
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
        }
        
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto 30px;
        }
        
        .panel {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 15px;
            margin-bottom: 20px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f8f8f8;
        }
        
        .clasificacion-circle {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .clasificacion-inocente { background-color: #4CAF50; }
        .clasificacion-molesta { background-color: #FFA500; }
        .clasificacion-peligrosa { background-color: #F44336; }
        
        .action-btn {
            padding: 6px 12px;
            background-color: #93D8E8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        
        .action-btn:hover {
            background-color: #82c8d8;
        }
        
        .blocked {
            color: #F44336;
            font-weight: bold;
        }
        
        .no-blocked {
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <div class="blue-bar">
        <img src="../logo.png" alt="Logo" class="logo">
        Reporte de Llamadas Falsas (Prank Calls)
    </div>
    
    <div class="search-container">
        <form method="GET" class="search-box">
            <input type="text" name="busqueda" placeholder="Buscar en llamadas falsas...">
            <button type="submit">Buscar</button>
        </form>
    </div>
    
    <div class="dashboard-container">
        <div class="panel">
            <h3>Todas las Llamadas Falsas Registradas</h3>
            <?php if (!empty($error)): ?>
                <p style="color: red;"><?php echo $error; ?></p>
            <?php endif; ?>
            
            <table>
                <thead>
                    <tr>
                        <th>Folio</th>
                        <th>Fecha/Hora</th>
                        <th>Teléfono</th>
                        <th>Motivo</th>
                        <th>Tipo</th>
                        <th>Clasificación</th>
                        <th>Bloqueado</th>
                        <th>Operador</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($prank_calls as $call): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($call['folio_prank_call']); ?></td>
                        <td><?php echo htmlspecialchars($call['fecha_prank_call'] . ' ' . $call['hora_prank_call']); ?></td>
                        <td><?php echo htmlspecialchars($call['telefono_origen']); ?></td>
                        <td><?php echo htmlspecialchars($call['motivo']); ?></td>
                        <td><?php echo htmlspecialchars($call['tipo_broma']); ?></td>
                        <td>
                            <span class="clasificacion-circle <?php echo htmlspecialchars($call['clase_clasificacion']); ?>"></span>
                            <?php echo htmlspecialchars($call['clasificacion']); ?>
                        </td>
                        <td class="<?php echo $call['bloqueo_numero'] ? 'blocked' : 'no-blocked'; ?>">
                            <?php echo $call['bloqueo_numero'] ? 'Sí' : 'No'; ?>
                        </td>
                        <td><?php echo htmlspecialchars($call['operador']); ?></td>
                        <td>
                            <button class="action-btn" 
                                    onclick="window.location.href='detalle_prank_call.php?id=<?php echo $call['folio_prank_call']; ?>'">
                                Detalles
                            </button>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                    <?php if (empty($prank_calls)): ?>
                    <tr>
                        <td colspan="9" style="text-align: center;">No se encontraron llamadas falsas registradas</td>
                    </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>