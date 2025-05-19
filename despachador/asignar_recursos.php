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

$id_despachador = $_SESSION['id_usuario'];
$folio_incidente = isset($_GET['folio']) ? intval($_GET['folio']) : 0;

// Process unit assignment
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['asignar_unidad'])) {
    try {
        $id_unidad = intval($_POST['id_unidad']);
        $comentarios = $_POST['comentarios'] ?? '';

        // Begin transaction
        $pdo->beginTransaction();

        // Insert assignment
        $stmt = $pdo->prepare("INSERT INTO asignaciones_unidades (id_incidente, id_unidad, id_usuario_asignador, comentarios) 
                              VALUES (:folio, :unidad, :despachador, :comentarios)");
        $stmt->execute([
            ':folio' => $folio_incidente,
            ':unidad' => $id_unidad,
            ':despachador' => $id_despachador,
            ':comentarios' => $comentarios
        ]);

        // Update unit status
        $stmt = $pdo->prepare("UPDATE unidades SET estado = 'En_servicio' WHERE id_unidad = :unidad");
        $stmt->execute([':unidad' => $id_unidad]);

        $pdo->commit();
        $_SESSION['mensaje'] = "Unidad asignada correctamente";
    } catch (PDOException $e) {
        $pdo->rollBack();
        $_SESSION['error'] = "Error al asignar unidad: " . $e->getMessage();
    }
}

// Process unit release
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['liberar_unidad'])) {
    try {
        $id_asignacion = intval($_POST['id_asignacion']);
        $id_unidad = intval($_POST['id_unidad']);

        // Begin transaction
        $pdo->beginTransaction();

        // Delete assignment
        $stmt = $pdo->prepare("DELETE FROM asignaciones_unidades WHERE id_asignacion = :asignacion");
        $stmt->execute([':asignacion' => $id_asignacion]);

        // Update unit status
        $stmt = $pdo->prepare("UPDATE unidades SET estado = 'Disponible' WHERE id_unidad = :unidad");
        $stmt->execute([':unidad' => $id_unidad]);

        $pdo->commit();
        $_SESSION['mensaje'] = "Unidad liberada correctamente";
    } catch (PDOException $e) {
        $pdo->rollBack();
        $_SESSION['error'] = "Error al liberar unidad: " . $e->getMessage();
    }
}

// Get incident information
$incidente = [];
if ($folio_incidente > 0) {
    try {
        $stmt = $pdo->prepare("SELECT i.* FROM incidentes i WHERE i.folio_incidente = :folio");
        $stmt->execute([':folio' => $folio_incidente]);
        $incidente = $stmt->fetch(PDO::FETCH_ASSOC);
        
        // Add dispatcher info from session
        // Add dispatcher info from database
        if ($incidente) {
            try {
                $stmt = $pdo->prepare("SELECT nombre, apellido FROM usuarios WHERE id_usuario = ?");
                $stmt->execute([$id_despachador]);
                $despachador = $stmt->fetch(PDO::FETCH_ASSOC);
                
                if ($despachador) {
                    $incidente['nombre_despachador'] = $despachador['nombre'] . ' ' . $despachador['apellido'];
                } else {
                    $incidente['nombre_despachador'] = 'Desconocido';
                }
            } catch (PDOException $e) {
                $incidente['nombre_despachador'] = 'Error al obtener nombre';
                error_log("Error fetching dispatcher name: " . $e->getMessage());
            }
        }
    } catch (PDOException $e) {
        $_SESSION['error'] = "Error al obtener información del incidente: " . $e->getMessage();
    }
}

// Get available units
$unidades_disponibles = [];
try {
    $stmt = $pdo->query("
        SELECT u.*, tu.nombre_tipo 
        FROM unidades u
        JOIN tipos_unidad tu ON u.id_tipo_unidad = tu.id_tipo
        WHERE u.estado = 'Disponible'
    ");
    $unidades_disponibles = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $_SESSION['error'] = "Error al obtener unidades disponibles: " . $e->getMessage();
}

// Get assigned units
$unidades_asignadas = [];
if ($folio_incidente > 0) {
    try {
        $stmt = $pdo->prepare("
            SELECT au.*, u.nombre_unidad, u.id_tipo_unidad, tu.nombre_tipo, 
                   CONCAT(us.nombre, ' ', us.apellido) as nombre_asignador
            FROM asignaciones_unidades au
            JOIN unidades u ON au.id_unidad = u.id_unidad
            JOIN tipos_unidad tu ON u.id_tipo_unidad = tu.id_tipo
            LEFT JOIN usuarios us ON au.id_usuario_asignador = us.id_usuario
            WHERE au.id_incidente = :folio
        ");
        $stmt->execute([':folio' => $folio_incidente]);
        $unidades_asignadas = $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        $_SESSION['error'] = "Error al obtener unidades asignadas: " . $e->getMessage();
    }
}

// Show session messages
$mensaje = $_SESSION['mensaje'] ?? null;
$error = $_SESSION['error'] ?? null;
unset($_SESSION['mensaje'], $_SESSION['error']);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignar Recursos - Sistema CAD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header { background-color: #93D8E8; color: white; }
        .unidad-card { transition: all 0.3s; }
        .unidad-card:hover { box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15); }
        .badge-tipo { font-size: 0.8em; }
        .map-container { height: 300px; background: #f8f9fa; border-radius: 8px; overflow: hidden; }
    </style>
</head>
<body>
    <header class="header py-3 mb-4">
        <div class="container d-flex justify-content-between align-items-center">
            <h1>ASIGNACIÓN DE RECURSOS</h1>
            <img src="../logo.png" alt="Logo" style="height: 50px;">
        </div>
    </header>

    <div class="container">
        <?php if ($mensaje): ?>
            <div class="alert alert-success alert-dismissible fade show">
                <?= htmlspecialchars($mensaje) ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>
        <?php if ($error): ?>
            <div class="alert alert-danger alert-dismissible fade show">
                <?= htmlspecialchars($error) ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <!-- Incident Information -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h2 class="mb-0">INCIDENTE #<?= htmlspecialchars($folio_incidente) ?></h2>
                <div>
                    <a href="menu.php?folio=<?= $folio_incidente ?>" class="btn btn-light btn-sm">
                        <i class="bi bi-house-door"></i> Menú
                    </a>
                    <a href="mapa.php?folio=<?= $folio_incidente ?>" class="btn btn-light btn-sm ms-2">
                        <i class="bi bi-map"></i> Mapa
                    </a>
                </div>
            </div>
            <div class="card-body">
                <?php if ($incidente): ?>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Tipo:</strong> <?= htmlspecialchars($incidente['tipo_auxilio']) ?></p>
                            <p><strong>Prioridad:</strong> 
                                <span class="badge bg-<?= 
                                    $incidente['prioridad'] == 'Alta' ? 'danger' : 
                                    ($incidente['prioridad'] == 'Media' ? 'warning' : 'success') 
                                ?>">
                                    <?= htmlspecialchars($incidente['prioridad']) ?>
                                </span>
                            </p>
                            <p><strong>Personas afectadas:</strong> <?= htmlspecialchars($incidente['num_personas']) ?></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Ubicación:</strong> 
                                <?= isset($incidente['latitud']) ? 
                                    htmlspecialchars($incidente['latitud'] . ', ' . $incidente['longitud']) : 'N/A' ?>
                            </p>
                            <p><strong>Teléfono:</strong> <?= htmlspecialchars($incidente['telefono']) ?></p>
                            <p><strong>Despachador:</strong> <?= htmlspecialchars($incidente['nombre_despachador'] ?? 'No asignado') ?></p>
                        </div>
                    </div>
                    <div class="mt-3">
                        <p><strong>Descripción:</strong></p>
                        <div class="border p-2 rounded"><?= htmlspecialchars($incidente['quepaso']) ?></div>
                    </div>
                <?php else: ?>
                    <div class="alert alert-warning">No se encontró información para este incidente</div>
                <?php endif; ?>
            </div>
        </div>

        <div class="row">
            <!-- Assigned Units -->
            <div class="col-md-6 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-info text-white">
                        <h3 class="mb-0">UNIDADES ASIGNADAS</h3>
                    </div>
                    <div class="card-body">
                        <?php if (empty($unidades_asignadas)): ?>
                            <div class="alert alert-info">No hay unidades asignadas a este incidente</div>
                        <?php else: ?>
                            <div class="row g-3">
                                <?php foreach ($unidades_asignadas as $unidad): ?>
                                    <div class="col-12">
                                        <div class="unidad-card card">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h5 class="card-title mb-1">
                                                            <?= htmlspecialchars($unidad['nombre_unidad']) ?>
                                                            <span class="badge bg-secondary badge-tipo"><?= htmlspecialchars($unidad['nombre_tipo']) ?></span>
                                                        </h5>
                                                        <p class="card-text mb-1">
                                                            <small class="text-muted">
                                                                Asignada por: <?= htmlspecialchars($unidad['nombre_asignador']) ?>
                                                            </small>
                                                        </p>
                                                        <p class="card-text mb-1">
                                                            <small class="text-muted">
                                                                Fecha: <?= date('d/m/Y H:i', strtotime($unidad['fecha_asignacion'])) ?>
                                                            </small>
                                                        </p>
                                                    </div>
                                                    <span class="badge bg-warning text-dark">Asignada</span>
                                                </div>
                                                <?php if (!empty($unidad['comentarios'])): ?>
                                                    <div class="mt-2 p-2 bg-light rounded">
                                                        <small><?= htmlspecialchars($unidad['comentarios']) ?></small>
                                                    </div>
                                                <?php endif; ?>
                                                
                                                <form method="POST" class="mt-3">
                                                    <input type="hidden" name="id_asignacion" value="<?= $unidad['id_asignacion'] ?>">
                                                    <input type="hidden" name="id_unidad" value="<?= $unidad['id_unidad'] ?>">
                                                    <button type="submit" name="liberar_unidad" class="btn btn-sm btn-danger w-100">
                                                        <i class="bi bi-x-circle"></i> Liberar Unidad
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>

            <!-- Available Units -->
            <div class="col-md-6 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-success text-white">
                        <h3 class="mb-0">UNIDADES DISPONIBLES</h3>
                    </div>
                    <div class="card-body">
                        <?php if (empty($unidades_disponibles)): ?>
                            <div class="alert alert-warning">No hay unidades disponibles</div>
                        <?php else: ?>
                            <div class="row g-3">
                                <?php foreach ($unidades_disponibles as $unidad): ?>
                                    <div class="col-12">
                                        <div class="unidad-card card">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h5 class="card-title mb-1">
                                                            <?= htmlspecialchars($unidad['nombre_unidad']) ?>
                                                            <span class="badge bg-secondary badge-tipo"><?= htmlspecialchars($unidad['nombre_tipo']) ?></span>
                                                        </h5>
                                                    </div>
                                                    <span class="badge bg-success">Disponible</span>
                                                </div>
                                                
                                                <form method="POST" class="mt-3">
                                                    <input type="hidden" name="id_unidad" value="<?= $unidad['id_unidad'] ?>">
                                                    <div class="mb-3">
                                                        <label for="comentarios_<?= $unidad['id_unidad'] ?>" class="form-label">Comentarios (opcional):</label>
                                                        <textarea class="form-control" id="comentarios_<?= $unidad['id_unidad'] ?>" 
                                                                  name="comentarios" rows="2"></textarea>
                                                    </div>
                                                    <button type="submit" name="asignar_unidad" class="btn btn-sm btn-success w-100">
                                                        <i class="bi bi-check-circle"></i> Asignar Unidad
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>