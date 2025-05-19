<?php
session_start();
require_once '../db.php'; // Include your database connection file

// Verify user is logged in
if (!isset($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

// Function to fetch data safely with PDO
function fetchData($pdo, $query) {
    try {
        $stmt = $pdo->query($query);
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
    <title>Reportes del Sistema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .badge-incident {
            background-color: #4cc9f0;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <h1 class="mb-4">Reportes del Sistema</h1>
        
        <!-- Prank Calls Table -->
        <div class="table-container">
            <div class="table-header d-flex justify-content-between align-items-center">
                <h2>Llamadas Falsas (Prank Calls)</h2>
                <span class="badge bg-danger"><?php 
                    $count = $pdo->query("SELECT COUNT(*) FROM prank_calls")->fetchColumn();
                    echo $count;
                ?></span>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Fecha</th>
                            <th>Motivo</th>
                            <th>Tipo</th>
                            <th>Teléfono</th>
                            <th>Clasificación</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $prankCalls = fetchData($pdo, "
                            SELECT pc.*, l.id_operador, u.nombre as operador_nombre 
                            FROM prank_calls pc
                            LEFT JOIN llamadas l ON pc.id_llamada = l.id_llamada
                            LEFT JOIN usuarios u ON l.id_operador = u.id_usuario
                            ORDER BY pc.fecha_prank_call DESC
                            LIMIT 100
                        ");
                        
                        foreach ($prankCalls as $call) {
                            echo "<tr>
                                <td>{$call['folio_prank_call']}</td>
                                <td>" . date('d/m/Y H:i', strtotime($call['fecha_prank_call'])) . "</td>
                                <td>{$call['motivo']}</td>
                                <td>{$call['tipo_broma']}</td>
                                <td>{$call['telefono_origen']}</td>
                                <td><span class='badge badge-prank'>{$call['clasificacion']}</span></td>
                                <td>
                                    <button class='btn btn-sm btn-outline-primary' onclick='viewDetails({$call['folio_prank_call']}, \"prank\")'>
                                        <i class='fas fa-eye'></i> Detalles
                                    </button>
                                </td>
                            </tr>";
                        }
                        
                        if (empty($prankCalls)) {
                            echo "<tr><td colspan='7' class='text-center'>No hay llamadas falsas registradas</td></tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Incidents Table -->
        <div class="table-container">
            <div class="table-header d-flex justify-content-between align-items-center">
                <h2>Incidentes Reportados</h2>
                <span class="badge bg-primary"><?php 
                    $count = $pdo->query("SELECT COUNT(*) FROM incidentes")->fetchColumn();
                    echo $count;
                ?></span>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Folio</th>
                            <th>Fecha</th>
                            <th>Tipo</th>
                            <th>Descripción</th>
                            <th>Ubicación</th>
                            <th>Prioridad</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $incidents = fetchData($pdo, "
                            SELECT i.*, u.nombre as reportador_nombre, 
                                   et.name as tipo_emergencia, et.priority as prioridad_defecto
                            FROM incidentes i
                            LEFT JOIN usuarios u ON i.id_usuario_reporta = u.id_usuario
                            LEFT JOIN EmergencyTypes et ON i.id_emergency_type = et.code
                            ORDER BY i.fecha_incidente DESC
                            LIMIT 100
                        ");
                        
                        foreach ($incidents as $incident) {
                            $priority = $incident['prioridad'] ?: $incident['prioridad_defecto'];
                            $priorityClass = match($priority) {
                                'Alta' => 'danger',
                                'Media' => 'warning',
                                'Baja' => 'success',
                                default => 'secondary'
                            };
                            
                            echo "<tr>
                                <td>{$incident['folio_incidente']}</td>
                                <td>" . date('d/m/Y H:i', strtotime($incident['fecha_incidente'])) . "</td>
                                <td>{$incident['tipo_auxilio']}</td>
                                <td>" . substr($incident['quepaso'], 0, 50) . "...</td>
                                <td>{$incident['colonia']}</td>
                                <td><span class='badge bg-$priorityClass'>$priority</span></td>
                                <td><span class='badge bg-info'>{$incident['clasificacion']}</span></td>
                                <td>
                                    <button class='btn btn-sm btn-outline-primary' onclick='viewDetails({$incident['folio_incidente']}, \"incident\")'>
                                        <i class='fas fa-eye'></i> Detalles
                                    </button>
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
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script>
        function viewDetails(id, type) {
            const modal = new bootstrap.Modal(document.getElementById('detailsModal'));
            const modalTitle = document.getElementById('modalTitle');
            const modalBody = document.getElementById('modalBody');
            
            modalTitle.textContent = `Detalles de ${type === 'prank' ? 'Llamada Falsa' : 'Incidente'} #${id}`;
            modalBody.innerHTML = '<div class="text-center my-4"><div class="spinner-border" role="status"><span class="visually-hidden">Cargando...</span></div></div>';
            
            // Fetch details via AJAX
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