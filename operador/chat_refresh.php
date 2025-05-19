<?php
require_once '../db.php';

header('Content-Type: application/json');

try {
    $chat_id = isset($_GET['chat_id']) ? intval($_GET['chat_id']) : 0;
    $last_message_id = isset($_GET['last_message_id']) ? intval($_GET['last_message_id']) : 0;
    
    if ($chat_id <= 0) {
        throw new Exception("ID de chat inválido");
    }
    
    $stmt = $pdo->prepare("SELECT m.*, u.nombre, u.apellido 
                          FROM messages m
                          JOIN usuarios u ON m.id_usuario = u.id_usuario
                          WHERE m.id_chat = :chat_id AND m.id_mensaje > :last_message_id
                          ORDER BY m.fecha_envio ASC");
    $stmt->execute([
        ':chat_id' => $chat_id,
        ':last_message_id' => $last_message_id
    ]);
    $messages = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'success' => true,
        'messages' => $messages,
        'last_message_id' => !empty($messages) ? end($messages)['id_mensaje'] : $last_message_id
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}