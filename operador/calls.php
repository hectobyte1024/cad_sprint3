<?php
session_start();
if (empty($_SESSION['id_usuario']) || empty($_SESSION['nombre_usuario'])) {
    header("Location: ../login.php");
    exit();
}

require_once '../db.php';

// Get all calls ordered by date (newest first)
$stmt = $pdo->query("SELECT * FROM llamadas ORDER BY fecha DESC");
$calls = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Llamadas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --white: #ffffff;
            --radius: 8px;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: #f5f7fa;
        }

        nav {
            background: var(--primary);
            padding: 15px;
            display: flex;
            gap: 20px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            padding: 20px;
            max-width: 1400px;
            margin: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: var(--primary);
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .status-pending { color: var(--warning); }
        .status-in-progress { color: var(--info); }
        .status-completed { color: var(--success); }
        .status-classified { color: var(--secondary); }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            color: white;
            font-weight: bold;
        }

        .btn-attend {
            background-color: var(--info);
        }

        .btn-complete {
            background-color: var(--success);
        }

        .btn-classify {
            background-color: var(--secondary);
        }

        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .badge-pending { background-color: var(--warning); color: white; }
        .badge-in-progress { background-color: var(--info); color: white; }
        .badge-completed { background-color: var(--success); color: white; }
        .badge-classified { background-color: var(--secondary); color: white; }

        /* Map styles */
        #mapModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        #mapContainer {
            width: 80%;
            height: 80%;
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            position: relative;
        }

        #map {
            width: 100%;
            height: 100%;
            border-radius: var(--radius);
        }

        #closeMap {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--danger);
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<nav>
    <a href="calls.php" class="nav-link"><i class="fas fa-phone"></i> Llamadas</a>
    <a href="incidente.php">Incidentes</a>
    <a href="chat.php">Chat</a>
    <a href="dashboard.php">Dashboard</a>
</nav>

<div class="container">
    <h1>Lista de Llamadas</h1>
    
    <?php if (empty($calls)): ?>
        <p>No hay llamadas registradas</p>
    <?php else: ?>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Teléfono</th>
                    <th>Fecha</th>
                    <th>Duración</th>
                    <th>Estatus</th>
                    <th>Ubicación</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($calls as $call): ?>
                <tr>
                    <td><?= htmlspecialchars($call['id_llamada']) ?></td>
                    <td><?= !empty($call['telefono']) ? htmlspecialchars($call['telefono']) : 'N/A' ?></td>
                    <td><?= date('d/m/Y H:i', strtotime($call['fecha'])) ?></td>
                    <td><?= $call['duracion'] ?> seg</td>
                    <td>
                        <?php 
                        $statusClass = strtolower(str_replace(' ', '-', $call['estatus']));
                        echo "<span class='badge badge-$statusClass'>" . htmlspecialchars($call['estatus']) . "</span>";
                        ?>
                    </td>
                    <td>
                        <?php if (!empty($call['latitud']) && !empty($call['longitud'])): ?>
                            <button class="btn btn-attend" onclick="showMap(<?= $call['latitud'] ?>, <?= $call['longitud'] ?>)">
                                Ver Mapa
                            </button>
                        <?php else: ?>
                            Sin ubicación
                        <?php endif; ?>
                    </td>
                    <td>
                        <?php if ($call['estatus'] === 'Atender'): ?>
                            <button class="btn btn-attend" onclick="redirectToIncident(<?= $call['id_llamada'] ?>)">
                                Atender
                            </button>
                        <?php elseif ($call['estatus'] === 'En curso'): ?>
                            <button class="btn btn-complete" onclick="updateCallStatus(<?= $call['id_llamada'] ?>, 'Finalizada')">
                                Finalizar
                            </button>
                            <button class="btn btn-classify" onclick="redirectToIncident(<?= $call['id_llamada'] ?>)">
                                Crear Incidente
                            </button>
                        <?php endif; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</div>

<!-- Map Modal -->
<div id="mapModal">
    <div id="mapContainer">
        <button id="closeMap" onclick="closeMap()">×</button>
        <div id="map"></div>
    </div>
</div>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
let map;
let marker;

function showMap(lat, lng) {
    const modal = document.getElementById('mapModal');
    modal.style.display = 'flex';
    
    // Initialize map if not already done
    if (!map) {
        map = L.map('map').setView([lat, lng], 15);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
    } else {
        map.setView([lat, lng], 15);
    }
    
    // Remove existing marker if any
    if (marker) {
        map.removeLayer(marker);
    }
    
    // Add new marker
    marker = L.marker([lat, lng]).addTo(map)
        .bindPopup('Ubicación de la llamada')
        .openPopup();
}

function closeMap() {
    document.getElementById('mapModal').style.display = 'none';
}

function updateCallStatus(callId, newStatus) {
    fetch('update_call_status.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            id_llamada: callId,
            estatus: newStatus,
            csrf_token: '<?php echo $_SESSION['csrf_token']; ?>'
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            location.reload();
        } else {
            alert('Error: ' + (data.error || 'No se pudo actualizar el estado'));
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error de red: ' + error.message);
    });
}

function redirectToIncident(callId) {
    // First update the call status to "En curso"
    fetch('update_call_status.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            id_llamada: callId,
            estatus: 'En curso',
            csrf_token: '<?php echo $_SESSION['csrf_token']; ?>'
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            // Redirect to incident page after status is updated
            window.location.href = `incidente.php?call_id=${callId}`;
        } else {
            alert('Error: ' + (data.error || 'No se pudo actualizar el estado'));
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error de red: ' + error.message);
    });
}
</script>
</body>
</html>