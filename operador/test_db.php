<?php
require_once '../db.php';

// Test connection
try {
    $pdo->query("SELECT 1");
    echo "Database connection successful!<br>";
    
    // Test llamadas table
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM llamadas");
    $result = $stmt->fetch();
    echo "Number of calls in database: " . $result['count'] . "<br>";
    
    if ($result['count'] > 0) {
        $stmt = $pdo->query("SELECT * FROM llamadas LIMIT 1");
        $call = $stmt->fetch();
        echo "<pre>" . print_r($call, true) . "</pre>";
    }
} catch (PDOException $e) {
    die("Database error: " . $e->getMessage());
}
?>