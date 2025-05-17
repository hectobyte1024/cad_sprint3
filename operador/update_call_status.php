<?php
session_start();

// Verify session and CSRF token
if (empty($_SESSION['id_usuario']) || !isset($_POST['id_llamada']) || !isset($_POST['estatus']) || 
    empty($_SESSION['csrf_token']) || empty($_POST['csrf_token']) || 
    !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
    header('HTTP/1.1 403 Forbidden');
    echo json_encode(['success' => false, 'error' => 'Unauthorized']);
    exit();
}

require_once '../db.php';

header('Content-Type: application/json');

try {
    $callId = intval($_POST['id_llamada']);
    $newStatus = $_POST['estatus'];
    
    // Validate status
    $validStatuses = ['Atender', 'En curso', 'Finalizada', 'Clasificada'];
    if (!in_array($newStatus, $validStatuses)) {
        throw new Exception('Estado no válido');
    }
    
    // Update call status
    $stmt = $pdo->prepare("UPDATE llamadas SET estatus = ? WHERE id_llamada = ?");
    $stmt->execute([$newStatus, $callId]);
    
    // Check if any row was affected
    if ($stmt->rowCount() === 0) {
        throw new Exception('No se encontró la llamada o no se realizaron cambios');
    }
    
    echo json_encode(['success' => true]);
    
} catch (PDOException $e) {
    error_log("Database error: " . $e->getMessage());
    echo json_encode(['success' => false, 'error' => 'Error de base de datos']);
} catch (Exception $e) {
    error_log("Error: " . $e->getMessage());
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}