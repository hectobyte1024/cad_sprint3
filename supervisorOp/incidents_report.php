<?php
session_start();
require_once '../db.php';

if (!isset($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

function fetchData($pdo, $query, $params = []) {
    try {
        $stmt = $pdo->prepare($query);
        $stmt->execute($params);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        die("Query failed: " . $e->getMessage());
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Incidentes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .table-container {
            margin-bottom: 50px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .table-header {
            background-color: #4361ee;
            color: white;
            padding: 15px;
        }
        .filter-section {
            background-color: #f8f9fa;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .badge-high {
            background-color: #dc3545;
        }
        .badge-medium {
            background-color: #ffc107;
            color: #000;
        }
        .badge-low {
            background-color: #28a745;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Reporte de Incidentes</h1>
            <a href="prank_calls_report.php" class="btn btn-danger">
                <i class="fas fa-phone-slash"></i> Ver Llamadas Falsas
            </a>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <form method="get" class="row g-3">
                <div class="col-md-2">
                    <label for="date_from" class="form-label">Desde:</label>
                    <input type="date" class="form-control" id="date_from" name="date_from" 
                           value="<?= $_GET['date_from'] ?? '' ?>">
                </div>
                <div class="col-md-2">
                    <label for="date_to" class="form-label">Hasta:</label>
                    <input type="date" class="form-control" id="date_to" name="date_to" 
                           value="<?= $_GET['date_to'] ?? '' ?>">
                </div>
                <div class="col-md-2">
                    <label for="hour_from" class="form-label">Hora Desde:</label>
                    <input type="time" class="form-control" id="hour_from" name="hour_from" 
                           value="<?= $_GET['hour_from'] ?? '' ?>">
                </div>
                <div class="col-md-2">
                    <label for="hour_to" class="form-label">Hora Hasta:</label>
                    <input type="time" class="form-control" id="hour_to" name="hour_to" 
                           value="<?= $_GET['hour_to'] ?? '' ?>">
                </div>
                <div class="col-md-2">
                    <label for="operator" class="form-label">Operador:</label>
                    <select class="form-select" id="operator" name="operator">
                        <option value="">Todos</option>
                        <?php
                        $operators = fetchData($pdo, "SELECT id_usuario, CONCAT(nombre, ' ', apellido) as name FROM usuarios WHERE rol_id IN (SELECT id_rol FROM roles WHERE nombre LIKE '%operador%')");
                        foreach ($operators as $op) {
                            $selected = ($_GET['operator'] ?? '') == $op['id_usuario'] ? 'selected' : '';
                            echo "<option value='{$op['id_usuario']}' $selected>{$op['name']}</option>";
                        }
                        ?>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="priority" class="form-label">Prioridad:</label>
                    <select class="form-select" id="priority" name="priority">
                        <option value="">Todas</option>
                        <option value="Alta" <?= ($_GET['priority'] ?? '') == 'Alta' ? 'selected' : '' ?>>Alta</option>
                        <option value="Media" <?= ($_GET['priority'] ?? '') == 'Media' ? 'selected' : '' ?>>Media</option>
                        <option value="Baja" <?= ($_GET['priority'] ?? '') == 'Baja' ? 'selected' : '' ?>>Baja</option>
                    </select>
                </div>
                <div class="col-md-12 d-flex justify-content-end mt-2">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fas fa-filter"></i> Filtrar
                    </button>
                    <a href="incidents_report.php" class="btn btn-outline-secondary">
                        <i class="fas fa-sync-alt"></i> Limpiar
                    </a>
                </div>
            </form>
        </div>
        
        <!-- Incidents Table -->
        <div class="table-container">
            <div class="table-header d-flex justify-content-between align-items-center">
                <h2>Incidentes Registrados</h2>
                <span class="badge bg-primary">
                    <?php 
                    $countQuery = "SELECT COUNT(*) FROM incidentes i";
                    $countParams = [];
                    
                    // Apply filters if set
                    if (!empty($_GET['date_from']) || !empty($_GET['date_to']) || 
                        !empty($_GET['hour_from']) || !empty($_GET['hour_to']) || 
                        !empty($_GET['operator']) || !empty($_GET['priority'])) {
                        
                        $countQuery .= " LEFT JOIN llamadas l ON i.id_llamada = l.id_llamada WHERE 1=1";
                        
                        if (!empty($_GET['date_from'])) {
                            $countQuery .= " AND i.fecha_incidente >= ?";
                            $countParams[] = $_GET['date_from'] . ' 00:00:00';
                        }
                        
                        if (!empty($_GET['date_to'])) {
                            $countQuery .= " AND i.fecha_incidente <= ?";
                            $countParams[] = $_GET['date_to'] . ' 23:59:59';
                        }
                        
                        if (!empty($_GET['hour_from'])) {
                            $countQuery .= " AND TIME(i.fecha_incidente) >= ?";
                            $countParams[] = $_GET['hour_from'];
                        }
                        
                        if (!empty($_GET['hour_to'])) {
                            $countQuery .= " AND TIME(i.fecha_incidente) <= ?";
                            $countParams[] = $_GET['hour_to'];
                        }
                        
                        if (!empty($_GET['operator'])) {
                            $countQuery .= " AND l.id_operador = ?";
                            $countParams[] = $_GET['operator'];
                        }
                        
                        if (!empty($_GET['priority'])) {
                            $countQuery .= " AND i.prioridad = ?";
                            $countParams[] = $_GET['priority'];
                        }
                    }
                    
                    $count = $pdo->prepare($countQuery);
                    $count->execute($countParams);
                    echo $count->fetchColumn();
                    ?>
                </span>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Folio</th>
                            <th>Fecha/Hora</th>
                            <th>Operador</th>
                            <th>Tipo</th>
                            <th>Descripción</th>
                            <th>Ubicación</th>
                            <th>Prioridad</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $query = "SELECT i.*, 
                                 CONCAT(u.nombre, ' ', u.apellido) as reportador_nombre,
                                 CONCAT(op.nombre, ' ', op.apellido) as operador_nombre,
                                 et.name as tipo_emergencia, 
                                 et.priority as prioridad_defecto,
                                 l.id_operador
                                 FROM incidentes i
                                 LEFT JOIN usuarios u ON i.id_usuario_reporta = u.id_usuario
                                 LEFT JOIN EmergencyTypes et ON i.id_emergency_type = et.code
                                 LEFT JOIN llamadas l ON i.id_llamada = l.id_llamada
                                 LEFT JOIN usuarios op ON l.id_operador = op.id_usuario";
                        
                        $params = [];
                        $where = [];
                        
                        // Apply filters
                        if (!empty($_GET['date_from'])) {
                            $where[] = "i.fecha_incidente >= ?";
                            $params[] = $_GET['date_from'] . ' 00:00:00';
                        }
                        
                        if (!empty($_GET['date_to'])) {
                            $where[] = "i.fecha_incidente <= ?";
                            $params[] = $_GET['date_to'] . ' 23:59:59';
                        }
                        
                        if (!empty($_GET['hour_from'])) {
                            $where[] = "TIME(i.fecha_incidente) >= ?";
                            $params[] = $_GET['hour_from'];
                        }
                        
                        if (!empty($_GET['hour_to'])) {
                            $where[] = "TIME(i.fecha_incidente) <= ?";
                            $params[] = $_GET['hour_to'];
                        }
                        
                        if (!empty($_GET['operator'])) {
                            $where[] = "l.id_operador = ?";
                            $params[] = $_GET['operator'];
                        }
                        
                        if (!empty($_GET['priority'])) {
                            $where[] = "i.prioridad = ?";
                            $params[] = $_GET['priority'];
                        }
                        
                        if (!empty($where)) {
                            $query .= " WHERE " . implode(' AND ', $where);
                        }
                        
                        $query .= " ORDER BY i.fecha_incidente DESC LIMIT 100";
                        
                        $incidents = fetchData($pdo, $query, $params);
                        
                        foreach ($incidents as $incident) {
                            $priority = $incident['prioridad'] ?: $incident['prioridad_defecto'];
                            $priorityClass = match($priority) {
                                'Alta' => 'high',
                                'Media' => 'medium',
                                'Baja' => 'low',
                                default => 'secondary'
                            };
                            
                            echo "<tr>
                                <td>{$incident['folio_incidente']}</td>
                                <td>" . date('d/m/Y H:i', strtotime($incident['fecha_incidente'])) . "</td>
                                <td>{$incident['operador_nombre']}</td>
                                <td>{$incident['tipo_auxilio']}</td>
                                <td>" . substr($incident['quepaso'], 0, 50) . "...</td>
                                <td>{$incident['colonia']}</td>
                                <td><span class='badge badge-$priorityClass'>$priority</span></td>
                                <td>
                                    <a href='detalle_incidente.php?id={$incident['folio_incidente']}' class='btn btn-sm btn-outline-primary'>
        <i class='fas fa-eye'></i> Detalles
    </a>
</td>
                            </tr>";
                        }
                        
                        if (empty($incidents)) {
                            echo "<tr><td colspan='8' class='text-center'>No hay incidentes registrados</td></tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal for details -->
    <div class="modal fade" id="detailsModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Detalles</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="modalBody">
                    Cargando detalles...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewDetails(id, type) {
            const modal = new bootstrap.Modal(document.getElementById('detailsModal'));
            const modalTitle = document.getElementById('modalTitle');
            const modalBody = document.getElementById('modalBody');
            
            modalTitle.textContent = `Detalles de ${type === 'prank' ? 'Llamada Falsa' : 'Incidente'} #${id}`;
            modalBody.innerHTML = '<div class="text-center my-4"><div class="spinner-border" role="status"><span class="visually-hidden">Cargando...</span></div></div>';
            
            fetch(`get_details.php?id=${id}&type=${type}`)
                .then(response => response.text())
                .then(data => {
                    modalBody.innerHTML = data;
                })
                .catch(error => {
                    modalBody.innerHTML = `<div class="alert alert-danger">Error al cargar detalles: ${error.message}</div>`;
                });
            
            modal.show();
        }
    </script>
</body>
</html>