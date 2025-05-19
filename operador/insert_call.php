<?php
header('Content-Type: application/json');

// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();

// Verify session
if (empty($_SESSION['id_usuario'])) {
    echo json_encode(['success' => false, 'error' => 'Unauthorized']);
    exit;
}

// Correct path to db.php one directory up
$dbPath = __DIR__ . '/../db.php';

// Verify db.php exists
if (!file_exists($dbPath)) {
    echo json_encode(['success' => false, 'error' => 'Database config not found at: ' . $dbPath]);
    exit;
}

require_once $dbPath;

// Verify database connection
if (!isset($pdo) || !($pdo instanceof PDO)) {
    echo json_encode(['success' => false, 'error' => 'Database connection failed']);
    exit;
}

try {
    // Verify CSRF token
    if (!isset($_POST['telefono']) || 
        !isset($_SERVER['HTTP_X_CSRF_TOKEN']) || 
        empty($_SESSION['csrf_token']) || 
        $_SERVER['HTTP_X_CSRF_TOKEN'] !== $_SESSION['csrf_token']) {
        throw new Exception('Invalid CSRF token');
    }

    // Validate and sanitize input
    $phone = filter_var($_POST['telefono'], FILTER_VALIDATE_INT);
    $duration = filter_var($_POST['duracion'], FILTER_VALIDATE_INT);
    $lat = filter_var($_POST['latitud'], FILTER_VALIDATE_FLOAT);
    $lng = filter_var($_POST['longitud'], FILTER_VALIDATE_FLOAT);
    
    if (!$phone || !$duration || $lat === false || $lng === false) {
        throw new Exception('Invalid input data');
    }

    $stmt = $pdo->prepare("INSERT INTO llamadas 
        (id_operador, telefono, duracion, latitud, longitud, estatus) 
        VALUES (?, ?, ?, ?, ?, ?)");
    
    $success = $stmt->execute([
        $_SESSION['id_usuario'],
        $phone,
        $duration,
        $lat,
        $lng,
        'Atender' // Default status
    ]);
    
    if (!$success) {
        throw new Exception('Failed to insert call');
    }
    
    echo json_encode([
        'success' => true,
        'id_llamada' => $pdo->lastInsertId()
    ]);
    
} catch (PDOException $e) {
    error_log("Database error: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'error' => 'Database error occurred: ' . $e->getMessage()
    ]);
} catch (Exception $e) {
    error_log("Application error: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
?>