<?php
session_start();
if (empty($_SESSION['id_usuario']) || empty($_SESSION['nombre_usuario'])) {
    header("Location: ../login.php");
    exit();
}

// Generate CSRF token if not exists
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Visual Call Queues</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        .queues {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .queue {
            flex: 1;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 20px;
        }

        .queue h2 {
            text-align: center;
            margin-bottom: 10px;
            color: var(--primary);
        }

        .queue-stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 0.9rem;
            color: var(--gray);
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
            min-height: 200px;
        }

        li {
            padding: 10px;
            margin-bottom: 5px;
            background-color: var(--light);
            border-radius: var(--radius);
            transition: all 0.3s;
            display: flex;
            justify-content: space-between;
        }

        .call-info {
            flex: 1;
        }

        .call-priority {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            align-self: center;
        }

        .priority-high { background-color: var(--danger); }
        .priority-medium { background-color: var(--warning); }
        .priority-low { background-color: var(--success); }

        .log {
            background: var(--white);
            padding: 20px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            height: 150px;
            overflow-y: auto;
            font-size: 0.9rem;
            color: var(--dark);
        }

        .controls {
            margin-top: 20px;
            text-align: center;
        }

        .controls button {
            margin: 0 10px;
            padding: 10px 20px;
            font-size: 1rem;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            color: var(--white);
        }

        .pause-btn {
            background-color: var(--danger);
        }

        .resume-btn {
            background-color: var(--success);
        }

        .fade-in {
            animation: fadeIn 0.5s;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
    <div class="queues">
        <div class="queue" id="queue1">
            <h2>Fila de llamadas 1</h2>
            <div class="queue-stats" id="stats1">
                <span>En espera: <span class="count">0</span></span>
                <span>Atendidas: <span class="processed">0</span></span>
            </div>
            <ul id="list1"></ul>
        </div>
        <div class="queue" id="queue2">
            <h2>Fila de llamadas 2</h2>
            <div class="queue-stats" id="stats2">
                <span>En espera: <span class="count">0</span></span>
                <span>Atendidas: <span class="processed">0</span></span>
            </div>
            <ul id="list2"></ul>
        </div>
        <div class="queue" id="queue3">
            <h2>Fila de llamadas 3</h2>
            <div class="queue-stats" id="stats3">
                <span>En espera: <span class="count">0</span></span>
                <span>Atendidas: <span class="processed">0</span></span>
            </div>
            <ul id="list3"></ul>
        </div>
    </div>

    <div class="log" id="log">
        <strong>Logs:</strong><br>
    </div>

    <div class="controls">
        <button class="pause-btn" id="pauseBtn">Pause</button>
        <button class="resume-btn" id="resumeBtn" disabled>Resume</button>
    </div>
</div>

<script>
// Configuration
const config = {
    callInterval: 1500, // ms between calls
    minProcessingTime: 3, // seconds
    maxProcessingTime: 7, // seconds
    callPriorities: ['Alta', 'Media', 'Baja'],
    statuses: ['Atender', 'En curso', 'Finalizada', 'Clasificada']
};

// State tracking
let running = true;
let inputInterval;
let processingIntervals = [];
const queueStats = {
    1: { pending: 0, processed: 0 },
    2: { pending: 0, processed: 0 },
    3: { pending: 0, processed: 0 }
};

// DOM Elements
const logBox = document.getElementById('log');
const pauseBtn = document.getElementById('pauseBtn');
const resumeBtn = document.getElementById('resumeBtn');

// Helper functions
function generateRandomPhoneNumber() {
    const prefix = Math.random() < 0.5 ? '55' : '56';
    const suffix = Math.floor(10000000 + Math.random() * 90000000);
    return parseInt(prefix + suffix); // Matches INT type in DB
}

function generateRandomCoords() {
    return {
        lat: parseFloat((19.4 + Math.random() * 0.1).toFixed(6)), // Mexico City area
        lng: parseFloat((-99.1 + Math.random() * 0.1).toFixed(6))
    };
}

function getRandomPriority() {
    return config.callPriorities[Math.floor(Math.random() * config.callPriorities.length)];
}

function getRandomStatus() {
    return config.statuses[Math.floor(Math.random() * config.statuses.length)];
}

function updateQueueStats(queueId) {
    const stats = queueStats[queueId];
    const statElement = document.getElementById(`stats${queueId}`);
    statElement.querySelector('.count').textContent = stats.pending;
    statElement.querySelector('.processed').textContent = stats.processed;
}

function addLog(message, isError = false) {
    const timestamp = new Date().toLocaleTimeString();
    const logEntry = document.createElement('div');
    logEntry.className = 'fade-in';
    logEntry.innerHTML = `[${timestamp}] ${message}`;
    if (isError) logEntry.style.color = 'var(--danger)';
    logBox.prepend(logEntry);
    
    // Auto-scroll to top
    logBox.scrollTop = 0;
}

// Call generation and processing
function generateCall(queueId) {
    if (!running) return;

    const processingTime = Math.floor(
        Math.random() * (config.maxProcessingTime - config.minProcessingTime + 1) + config.minProcessingTime
    );
    const phoneNumber = generateRandomPhoneNumber();
    const priority = getRandomPriority();
    const { lat, lng } = generateRandomCoords();
    const callId = Date.now(); // Temporary ID for UI tracking

    // Create call element
    const li = document.createElement('li');
    li.className = 'fade-in';
    li.dataset.callId = callId;
    
    li.innerHTML = `
        <div class="call-info">
            ${phoneNumber} (${processingTime}s)
        </div>
        <div class="call-priority priority-${priority.toLowerCase()}"></div>
    `;

    const list = document.getElementById(`list${queueId}`);
    list.prepend(li);
    queueStats[queueId].pending++;
    updateQueueStats(queueId);

    // Send to server
    // Replace your current fetch code with this:
    // In your generateCall function, update the fetch call:
    fetch('insert_call.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-CSRF-Token': '<?php echo $_SESSION['csrf_token']; ?>'
        },
        body: new URLSearchParams({
            telefono: phoneNumber,
            duracion: processingTime,
            latitud: lat,
            longitud: lng
        })
    })
    .then(async response => {
        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Server error: ${response.status} - ${errorText}`);
        }
        return response.json();
    })
    .then(data => {
        if (!data.success) {
            throw new Error(data.error || 'Unknown error occurred');
        }
        li.dataset.dbId = data.id_llamada;
        addLog(`📞 Llamada recibida: ${phoneNumber} (Fila ${queueId})`);
    })
    .catch(error => {
        addLog(`❌ Error al registrar llamada: ${error.message}`, true);
        console.error('Error details:', error);
    });

    // Schedule processing
    const processTimeout = setTimeout(() => {
        if (li.parentElement) {
            li.style.opacity = '0';
            setTimeout(() => {
                li.remove();
                queueStats[queueId].pending--;
                queueStats[queueId].processed++;
                updateQueueStats(queueId);
                addLog(`✅ Llamada ${phoneNumber} procesada`);
            }, 500);
        }
    }, processingTime * 1000);

    processingIntervals.push(processTimeout);
}

// Simulation control
function startSimulation() {
    running = true;
    inputInterval = setInterval(() => {
        const randomQueue = Math.floor(Math.random() * 3) + 1;
        generateCall(randomQueue);
    }, config.callInterval);
    
    pauseBtn.disabled = false;
    resumeBtn.disabled = true;
    addLog("▶️ Simulación iniciada");
}

function pauseSimulation() {
    running = false;
    clearInterval(inputInterval);
    processingIntervals.forEach(clearTimeout);
    processingIntervals = [];
    
    pauseBtn.disabled = true;
    resumeBtn.disabled = false;
    addLog("⏸️ Simulación pausada");
}

function resumeSimulation() {
    startSimulation();
    addLog("↩️ Simulación reanudada");
}

// Event listeners
pauseBtn.addEventListener('click', pauseSimulation);
resumeBtn.addEventListener('click', resumeSimulation);

// Initialize
startSimulation();
</script>
</body>
</html>
