<?php
session_start();

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// CSRF Protection
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

if (empty($_SESSION['id_usuario'])) {
    header("Location: ../login.php");
    exit();
}

require_once '../db.php'; // This should return a PDO connection

$mensaje_exito = '';
$mensaje_error = '';
$call_id = isset($_GET['call_id']) ? intval($_GET['call_id']) : null;
$incidente = null;

// Load call data if call_id is provided
// Load call data if call_id is provided
if ($call_id) {
    try {
        // Get basic call information
        $stmt = $pdo->prepare("SELECT * FROM llamadas WHERE id_llamada = ?");
        $stmt->execute([$call_id]);
        $llamada = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$llamada) {
            $mensaje_error = "No existe una llamada con ID $call_id";
        } else {
            // Create basic incident structure with default values
            $incidente = [
                'id_llamada' => $llamada['id_llamada'],
                'telefono' => $llamada['telefono'] ?? 'N/A',
                'quepaso' => $llamada['descripcion'] ?? 'Llamada de broma',
                'colonia' => null,
                'localidad' => null,
                'municipio' => null
            ];
            
            // Try to get additional info if available
            $stmt = $pdo->prepare("SELECT colonia, localidad, municipio 
                                 FROM incidentes 
                                 WHERE id_llamada = ?");
            $stmt->execute([$call_id]);
            if ($extra_data = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $incidente = array_merge($incidente, $extra_data);
            }
        }
    } catch (PDOException $e) {
        $mensaje_error = "Error al cargar los datos: " . $e->getMessage();
    }
}

// Process form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // CSRF validation
    if (!hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die('Token CSRF inválido');
    }

    try {
        $pdo->beginTransaction();
        
        // Obtener datos del formulario
        $motivo = trim($_POST['motivo'] ?? '');
        $tipo_broma = trim($_POST['tipo_broma'] ?? '');
        $clasificacion = trim($_POST['clasificacion'] ?? 'Inocente');
        $acciones_tomadas = trim($_POST['acciones_tomadas'] ?? '');
        $bloqueo_numero = isset($_POST['bloqueo_numero']) ? 1 : 0;
        $telefono_origen = trim($_POST['telefono_origen'] ?? '');
        $id_operador = $_SESSION['id_usuario']; // ID del operador actual

        // Insertar en prank_calls
        $stmt = $pdo->prepare("INSERT INTO prank_calls 
            (id_llamada, motivo, tipo_broma, clasificacion, acciones_tomadas, 
            bloqueo_numero, telefono_origen, hora_prank_call, fecha_prank_call, id_operador) 
            VALUES (:call_id, :motivo, :tipo_broma, :clasificacion, 
                    :acciones_tomadas, :bloqueo_numero, :telefono_origen, 
                    NOW(), NOW(), :id_operador)");
        
        $stmt->execute([
            ':call_id' => $call_id,
            ':motivo' => $motivo,
            ':tipo_broma' => $tipo_broma,
            ':clasificacion' => $clasificacion,
            ':acciones_tomadas' => $acciones_tomadas,
            ':bloqueo_numero' => $bloqueo_numero,
            ':telefono_origen' => $telefono_origen,
            ':id_operador' => $id_operador
        ]);
        
        // Actualizar estado de la llamada
        $update_stmt = $pdo->prepare("UPDATE llamadas SET estatus = 'Finalizada' WHERE id_llamada = :call_id");
        $update_stmt->execute([':call_id' => $call_id]);
        
        $pdo->commit();
        $_SESSION['mensaje_exito'] = "Llamada de broma registrada correctamente";
        header("Location: calls.php?success=1");
        exit();
        
    } catch (PDOException $e) {
        $pdo->rollBack();
        $mensaje_error = "Error al registrar la llamada: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Llamada de Broma</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            margin: 0;
            padding: 2rem;
            background-color: #f5f7fa;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        h1 {
            color: var(--dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: var(--border-radius);
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        input[type="text"],
        input[type="tel"],
        textarea,
        select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 1rem 0;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            gap: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-warning {
            background-color: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background-color: #e68a00;
        }

        .call-info {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            border: 1px solid #eee;
        }

        .call-info p {
            margin: 0.5rem 0;
        }

        .call-info strong {
            color: var(--primary);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-exclamation-triangle"></i> Registrar Llamada de Broma</h1>
        
        <?php if ($mensaje_exito): ?>
            <div class="alert alert-success"><?= htmlspecialchars($mensaje_exito) ?></div>
        <?php endif; ?>
        
        <?php if ($mensaje_error): ?>
            <div class="alert alert-danger"><?= htmlspecialchars($mensaje_error) ?></div>
        <?php endif; ?>

        <?php if ($incidente): ?>
            <div class="call-info">
                <p><strong>ID Llamada:</strong> <?= htmlspecialchars($incidente['id_llamada'] ?? 'N/A') ?></p>
                <p><strong>Descripción:</strong> <?= htmlspecialchars($incidente['quepaso'] ?? 'Llamada de broma') ?></p>
                <p><strong>Teléfono:</strong> <?= htmlspecialchars($incidente['telefono'] ?? 'N/A') ?></p>
                
                <?php
                // Build location information safely
                $ubicacion_parts = [];
                
                // Add text location components if they exist
                if (!empty($incidente['colonia'])) $ubicacion_parts[] = $incidente['colonia'];
                if (!empty($incidente['localidad'])) $ubicacion_parts[] = $incidente['localidad'];
                if (!empty($incidente['municipio'])) $ubicacion_parts[] = $incidente['municipio'];
                
                // Add coordinates if they exist
                $coordenadas = '';
                if (isset($incidente['latitud']) && isset($incidente['longitud'])) {
                    $coordenadas = sprintf(" (%.6f, %.6f)", 
                                        $incidente['latitud'], 
                                        $incidente['longitud']);
                }
                
                // Only show location if we have any data
                if (!empty($ubicacion_parts) || !empty($coordenadas)): ?>
                    <p><strong>Ubicación:</strong> 
                        <?= htmlspecialchars(implode(', ', $ubicacion_parts)) ?>
                        <?= htmlspecialchars($coordenadas) ?>
                    </p>
                <?php endif; ?>
            </div>
        <?php endif; ?>

        <form method="POST">
            <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?>">
            <?php if ($call_id): ?>
                <input type="hidden" name="call_id" value="<?= htmlspecialchars($call_id) ?>">
            <?php endif; ?>

            <div class="form-group">
                <label for="motivo"><i class="fas fa-comment"></i> Motivo de la llamada falsa</label>
                <input type="text" id="motivo" name="motivo" required 
                       value="<?= htmlspecialchars($incidente['quepaso'] ?? '') ?>">
            </div>

            <div class="form-group">
                <label for="tipo_broma"><i class="fas fa-tags"></i> Tipo de broma</label>
                <select id="tipo_broma" name="tipo_broma" required>
                    <option value="">Seleccione...</option>
                    <option value="Llamada de broma por menores">Llamada de broma por menores</option>
                    <option value="Llamada muda">Llamada muda</option>
                    <option value="Lenguaje obsceno">Lenguaje obsceno</option>
                    <option value="Simulación de emergencia">Simulación de emergencia</option>
                    <option value="Amenaza falsa">Amenaza falsa</option>
                    <option value="Acoso telefónico">Acoso telefónico</option>
                    <option value="Llamada de broma por adultos">Llamada de broma por adultos</option>
                    <option value="Otra">Otra</option>
                </select>
            </div>

            <div class="form-group">
                <label for="clasificacion"><i class="fas fa-balance-scale"></i> Clasificación</label>
                <select id="clasificacion" name="clasificacion" required>
                    <option value="Inocente" selected>Inocente</option>
                    <option value="Molesta">Molesta</option>
                    <option value="Peligrosa">Peligrosa</option>
                </select>
            </div>

            <div class="form-group">
                <label for="telefono_origen"><i class="fas fa-phone"></i> Teléfono de origen</label>
                <input type="tel" id="telefono_origen" name="telefono_origen" required 
                       value="<?= htmlspecialchars($incidente['telefono'] ?? '') ?>">
            </div>

            <div class="form-group">
                <label for="acciones_tomadas"><i class="fas fa-tasks"></i> Acciones tomadas</label>
                <textarea id="acciones_tomadas" name="acciones_tomadas">Se registró la llamada como falsa en el sistema</textarea>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="bloqueo_numero" name="bloqueo_numero">
                <label for="bloqueo_numero">Bloquear número telefónico</label>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Registrar Llamada Falsa
            </button>
            
            <a href="calls.php" class="btn btn-warning">
                <i class="fas fa-times"></i> Cancelar
            </a>
        </form>
    </div>

    <script>
        // Auto-select the incident description if it matches a prank call type
        document.addEventListener('DOMContentLoaded', function() {
            const incidentDesc = "<?= htmlspecialchars($incidente['quepaso'] ?? '') ?>";
            const tipoBromaSelect = document.getElementById('tipo_broma');
            
            if (incidentDesc.includes('broma') || incidentDesc.includes('Broma')) {
                tipoBromaSelect.value = 'Llamada de broma por adultos';
            } else if (incidentDesc.includes('muda') || incidentDesc.includes('silencio')) {
                tipoBromaSelect.value = 'Llamada muda';
            } else if (incidentDesc.includes('obsceno') || incidentDesc.includes('grosería')) {
                tipoBromaSelect.value = 'Lenguaje obsceno';
            }
            
            // Auto-set classification based on certain keywords
            const clasificacionSelect = document.getElementById('clasificacion');
            if (incidentDesc.includes('amenaza') || incidentDesc.includes('bomba')) {
                clasificacionSelect.value = 'Peligrosa';
            } else if (incidentDesc.includes('molest') || incidentDesc.includes('repetida')) {
                clasificacionSelect.value = 'Molesta';
            }
        });
    </script>
</body>
</html>