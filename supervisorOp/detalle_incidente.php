<?php
session_start();

if (!isset($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

if (!isset($_GET['id'])) {
    header("Location: incidents_report.php");
    exit();
}

$folio_incidente = $_GET['id'];

require_once '../db.php';

try {
    $sql = "SELECT i.*, 
                   CONCAT(u.nombre, ' ', u.apellido) as nombre_usuario,
                   CONCAT(op.nombre, ' ', op.apellido) as operador_nombre,
                   et.name as tipo_emergencia,
                   un.nombre_unidad as unidad_nombre
            FROM incidentes i
            JOIN usuarios u ON i.id_usuario_reporta = u.id_usuario
            LEFT JOIN llamadas l ON i.id_llamada = l.id_llamada
            LEFT JOIN usuarios op ON l.id_operador = op.id_usuario
            LEFT JOIN EmergencyTypes et ON i.id_emergency_type = et.code
            LEFT JOIN unidades un ON i.id_unidad_asignada = un.id_unidad
            WHERE i.folio_incidente = ?";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$folio_incidente]);
    $incidente = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$incidente) {
        header("Location: incidents_report.php");
        exit();
    }
} catch (PDOException $e) {
    die("Error al consultar la base de datos: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Incidente #<?= htmlspecialchars($folio_incidente) ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        
        .blue-bar {
            background-color: #4361ee;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            margin-bottom: 30px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .card-header {
            border-bottom: 2px solid #4361ee;
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
        
        .priority-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .priority-high {
            background-color: #dc3545;
            color: white;
        }
        
        .priority-medium {
            background-color: #ffc107;
            color: #000;
        }
        
        .priority-low {
            background-color: #28a745;
            color: white;
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .detail-item {
            margin-bottom: 15px;
        }
        
        .detail-label {
            font-weight: bold;
            color: #6c757d;
            margin-bottom: 5px;
            font-size: 14px;
        }
        
        .detail-value {
            font-size: 16px;
            padding: 8px 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .description-box {
            background-color: #f8f9fa;
            border-left: 4px solid #4361ee;
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 4px 4px 0;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background-color: #4361ee;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #3a56d4;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        @media (max-width: 768px) {
            .detail-grid {
                grid-template-columns: 1fr;
            }
            
            .blue-bar {
                font-size: 20px;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="blue-bar">
        Detalles del Incidente #<?= htmlspecialchars($folio_incidente) ?>
    </div>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Información General</h2>
                <span class="priority-badge priority-<?= strtolower($incidente['prioridad']) ?>">
                    <?= htmlspecialchars($incidente['prioridad']) ?>
                </span>
            </div>
            
            <div class="detail-grid">
                <div class="detail-item">
                    <div class="detail-label">Reportado por</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['nombre_usuario']) ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Operador</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['operador_nombre'] ?? 'N/A') ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Fecha y Hora</div>
                    <div class="detail-value"><?= date('d/m/Y H:i', strtotime($incidente['fecha_incidente'])) ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Tipo de Auxilio</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['tipo_auxilio']) ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Tipo de Emergencia</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['tipo_emergencia'] ?? 'N/A') ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Clasificación</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['clasificacion']) ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Unidad Asignada</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['unidad_nombre'] ?? 'Ninguna') ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Personas Involucradas</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['num_personas']) ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Teléfono Reporte</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['telefono']) ?></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label">Tipo de Teléfono</div>
                    <div class="detail-value"><?= htmlspecialchars($incidente['tipo_telefono'] ?? 'N/A') ?></div>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">Ubicación</div>
                <div class="detail-value">
                    <?= htmlspecialchars($incidente['colonia'] . ', ' . $incidente['localidad'] . ', ' . $incidente['municipio']) ?>
                    <br>
                    Coordenadas: <?= htmlspecialchars($incidente['latitud'] . ', ' . $incidente['longitud']) ?>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">Descripción del Incidente</div>
                <div class="description-box">
                    <?= htmlspecialchars($incidente['quepaso']) ?>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">Referencia del Lugar</div>
                <div class="description-box">
                    <?= htmlspecialchars($incidente['referencia_lugar'] ?? 'N/A') ?>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">Detalles Adicionales</div>
                <div class="description-box">
                    <?= htmlspecialchars($incidente['detalle'] ?? 'N/A') ?>
                </div>
            </div>
            
            <div class="detail-item">
                <div class="detail-label">Objetos Involucrados</div>
                <div class="description-box">
                    <?= htmlspecialchars($incidente['objetos_involucrados'] ?? 'N/A') ?>
                </div>
            </div>
            
            <div class="d-flex justify-content-between mt-4">
                <a href="incidents_report.php" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver al Reporte
                </a>
                
                <a href="edit_incident.php?id=<?= $folio_incidente ?>" class="btn btn-primary">
                    <i class="fas fa-edit"></i> Editar Incidente
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>