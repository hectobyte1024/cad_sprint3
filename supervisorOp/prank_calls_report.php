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
    <title>Reporte de Llamadas Falsas</title>
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
        .badge-prank {
            background-color: #f72585;
        }
        .filter-section {
            background-color: #f8f9fa;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Reporte de Llamadas Falsas</h1>
            <a href="incidents_report.php" class="btn btn-primary">
                <i class="fas fa-ambulance"></i> Ver Incidentes
            </a>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <form method="get" class="row g-3">
                <div class="col-md-3">
                    <label for="date_from" class="form-label">Desde:</label>
                    <input type="date" class="form-control" id="date_from" name="date_from" 
                           value="<?= $_GET['date_from'] ?? '' ?>">
                </div>
                <div class="col-md-3">
                    <label for="date_to" class="form-label">Hasta:</label>
                    <input type="date" class="form-control" id="date_to" name="date_to" 
                           value="<?= $_GET['date_to'] ?? '' ?>">
                </div>
                <div class="col-md-3">
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
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fas fa-filter"></i> Filtrar
                    </button>
                    <a href="prank_calls_report.php" class="btn btn-outline-secondary">
                        <i class="fas fa-sync-alt"></i> Limpiar
                    </a>
                </div>
            </form>
        </div>
        
        <!-- Prank Calls Table -->
        <div class="table-container">
            <div class="table-header d-flex justify-content-between align-items-center">
                <h2>Llamadas Falsas Registradas</h2>
                <span class="badge bg-danger">
                    <?php 
                    $countQuery = "SELECT COUNT(*) FROM prank_calls pc";
                    $countParams = [];
                    
                    // Apply filters if set
                    if (!empty($_GET['date_from']) || !empty($_GET['date_to']) || !empty($_GET['operator'])) {
                        $countQuery .= " LEFT JOIN llamadas l ON pc.id_llamada = l.id_llamada WHERE 1=1";
                        
                        if (!empty($_GET['date_from'])) {
                            $countQuery .= " AND pc.fecha_prank_call >= ?";
                            $countParams[] = $_GET['date_from'] . ' 00:00:00';
                        }
                        
                        if (!empty($_GET['date_to'])) {
                            $countQuery .= " AND pc.fecha_prank_call <= ?";
                            $countParams[] = $_GET['date_to'] . ' 23:59:59';
                        }
                        
                        if (!empty($_GET['operator'])) {
                            $countQuery .= " AND l.id_operador = ?";
                            $countParams[] = $_GET['operator'];
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
                            <th>ID</th>
                            <th>Fecha/Hora</th>
                            <th>Operador</th>
                            <th>Motivo</th>
                            <th>Tipo</th>
                            <th>Teléfono</th>
                            <th>Clasificación</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $query = "SELECT pc.*, l.id_operador, 
                                 CONCAT(u.nombre, ' ', u.apellido) as operador_nombre 
                                 FROM prank_calls pc
                                 LEFT JOIN llamadas l ON pc.id_llamada = l.id_llamada
                                 LEFT JOIN usuarios u ON l.id_operador = u.id_usuario";
                        
                        $params = [];
                        $where = [];
                        
                        // Apply filters
                        if (!empty($_GET['date_from'])) {
                            $where[] = "pc.fecha_prank_call >= ?";
                            $params[] = $_GET['date_from'] . ' 00:00:00';
                        }
                        
                        if (!empty($_GET['date_to'])) {
                            $where[] = "pc.fecha_prank_call <= ?";
                            $params[] = $_GET['date_to'] . ' 23:59:59';
                        }
                        
                        if (!empty($_GET['operator'])) {
                            $where[] = "l.id_operador = ?";
                            $params[] = $_GET['operator'];
                        }
                        
                        if (!empty($where)) {
                            $query .= " WHERE " . implode(' AND ', $where);
                        }
                        
                        $query .= " ORDER BY pc.fecha_prank_call DESC LIMIT 100";
                        
                        $prankCalls = fetchData($pdo, $query, $params);
                        
                        foreach ($prankCalls as $call) {
                            echo "<tr>
                                <td>{$call['folio_prank_call']}</td>
                                <td>" . date('d/m/Y H:i', strtotime($call['fecha_prank_call'])) . "</td>
                                <td>{$call['operador_nombre']}</td>
                                <td>{$call['motivo']}</td>
                                <td>{$call['tipo_broma']}</td>
                                <td>{$call['telefono_origen']}</td>
                                <td><span class='badge badge-prank'>{$call['clasificacion']}</span></td>
                                <td><a href='detalle_incidente.php?id={$incident['folio_incidente']}' class='btn btn-sm btn-outline-primary'>
                                        <i class='fas fa-eye'></i> Detalles
                                    </a>
                                </td>
                            </tr>";
                        }
                        
                        if (empty($prankCalls)) {
                            echo "<tr><td colspan='8' class='text-center'>No hay llamadas falsas registradas</td></tr>";
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