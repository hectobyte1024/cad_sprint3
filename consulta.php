<?php
include('db.php');

// Set content type to HTML with UTF-8
header('Content-Type: text/html; charset=UTF-8');

// Error handling for database connection
if (!isset($conn)) {
    die("<div class='error-container'><h1>Database Connection Error</h1><p>Failed to connect to the database.</p></div>");
}

// Execute query
$sql = "SELECT * FROM usuarios";
$result = $conn->query($sql);

// Start HTML output with embedded CSS
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management System</title>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --text-color: #333;
            --light-bg: #f9f9f9;
            --border-color: #ddd;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--light-bg);
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: white;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        
        h1, h2 {
            color: var(--primary-color);
            margin-top: 0;
        }
        
        .status-message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-weight: bold;
        }
        
        .success {
            background-color: rgba(46, 204, 113, 0.2);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }
        
        .error-container {
            background-color: rgba(231, 76, 60, 0.2);
            color: var(--error-color);
            padding: 20px;
            border-radius: 4px;
            border-left: 4px solid var(--error-color);
            max-width: 600px;
            margin: 50px auto;
        }
        
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        }
        
        .user-table thead tr {
            background-color: var(--primary-color);
            color: white;
            text-align: left;
        }
        
        .user-table th,
        .user-table td {
            padding: 12px 15px;
        }
        
        .user-table tbody tr {
            border-bottom: 1px solid var(--border-color);
        }
        
        .user-table tbody tr:nth-of-type(even) {
            background-color: rgba(0, 0, 0, 0.02);
        }
        
        .user-table tbody tr:last-of-type {
            border-bottom: 2px solid var(--primary-color);
        }
        
        .user-table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        .no-users {
            padding: 20px;
            text-align: center;
            background-color: rgba(0, 0, 0, 0.03);
            border-radius: 4px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Management System</h1>
        
        <?php
        if ($result === false) {
            echo "<div class='error-container'>
                    <h2>Query Error</h2>
                    <p>" . htmlspecialchars($conn->error) . "</p>
                  </div>";
        } else {
            echo "<div class='status-message success'>
                    Query successful. Found " . $result->num_rows . " user(s).
                  </div>";
            
            if ($result->num_rows > 0) {
                echo "<table class='user-table'>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Email</th>
                                <th>Role ID</th>
                            </tr>
                        </thead>
                        <tbody>";
                
                while ($row = $result->fetch_assoc()) {
                    echo "<tr>
                            <td>" . htmlspecialchars($row['id_usuario']) . "</td>
                            <td>" . htmlspecialchars($row['nombre']) . "</td>
                            <td>" . htmlspecialchars($row['apellido']) . "</td>
                            <td>" . htmlspecialchars($row['correo']) . "</td>
                            <td>" . htmlspecialchars($row['rol_id']) . "</td>
                          </tr>";
                }
                
                echo "</tbody></table>";
            } else {
                echo "<div class='no-users'>
                        <p>No registered users found.</p>
                      </div>";
            }
        }
        
        $conn->close();
        ?>
    </div>
</body>
</html>