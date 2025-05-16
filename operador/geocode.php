<?php
header('Content-Type: application/json');

function reverseGeocode($lat, $lng) {
    $url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&accept-language=es";
    
    // Required by Nominatim's usage policy
    $options = [
        'http' => [
            'header' => "User-Agent: YourAppName/1.0 (your@email.com)\r\n"
        ]
    ];
    $context = stream_context_create($options);
    
    try {
        // Respect Nominatim's rate limit (1 request per second)
        sleep(1);
        
        $response = file_get_contents($url, false, $context);
        
        if ($response === false) {
            return ['error' => 'Error conectando al servicio de geocodificación'];
        }
        
        $data = json_decode($response, true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            return ['error' => 'Respuesta inválida del servicio'];
        }
        
        if (isset($data['error'])) {
            return ['error' => $data['error']];
        }
        
        return $data;
    } catch (Exception $e) {
        return ['error' => $e->getMessage()];
    }
}

if (isset($_GET['lat']) && isset($_GET['lon'])) {
    $lat = floatval($_GET['lat']);
    $lon = floatval($_GET['lon']);
    
    $result = reverseGeocode($lat, $lon);
    echo json_encode($result);
} else {
    echo json_encode(['error' => 'Coordenadas faltantes']);
}
?>