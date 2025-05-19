<?php
session_start();
require_once 'db.php'; // $pdo viene de aquí

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $correo = $_POST['email'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM usuarios WHERE correo = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$correo]);
    $usuario = $stmt->fetch();

    if ($usuario) {
        // Depuración: Verificar contraseña y hash
        echo "Contraseña ingresada: " . htmlspecialchars($password) . "<br>";
        echo "Hash almacenado: " . htmlspecialchars($usuario['password']) . "<br>";
        echo "Resultado de password_verify: " . (password_verify($password, $usuario['password']) ? 'true' : 'false') . "<br>";

        if (password_verify($password, $usuario['password'])) {
            $_SESSION['id_usuario'] = $usuario['id_usuario'];
            $_SESSION['nombre_usuario'] = $usuario['nombre'];
            $rol_id = $usuario['rol_id'];

            $stmtRol = $pdo->prepare("SELECT nombre_rol FROM roles WHERE id_rol = ?");
            $stmtRol->execute([$rol_id]);
            $rol = $stmtRol->fetch();

            if ($rol) {
                $_SESSION['rol'] = $rol['nombre_rol'];

                $base_url = '/';
                switch ($rol['nombre_rol']) {
                    case 'Operador':
                        header("Location: " . $base_url . "operador/incidente.php");
                        break;
                    case 'Despachador':
                        header("Location: " . $base_url . "despachador/menu.php");
                        break;
                    case 'Supervisor_Op':
                        header("Location: " . $base_url . "supervisorOp/supOp.php");
                        break;
                    case 'Administrador':
                        header("Location: " . $base_url . "gestion/gestion.html");
                        break;
                    default:
                        header("Location: " . $base_url . "consulta.php");
                        break;
                }
                exit();
            } else {
                echo "Error al obtener el rol del usuario. Rol ID: " . htmlspecialchars($rol_id);
            }
        } else {
            echo "Contraseña incorrecta.";
        }
    } else {
        echo "No se encontró el usuario con correo: " . htmlspecialchars($correo);
    }
}
?>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de sesión | CAD </title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: white; 
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        main {
            display: flex;
            width: 80%;
            max-width: 1200px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .seccionIzquierda {
            flex: 1;
            padding: 40px;
            background-color:#93D8E8;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #contenedorFormulario {
            width: 100%;
            max-width: 400px;
        }

        #contenedorFormulario h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        #contenedorFormulario img {
            display: block;
            margin: 0 auto 30px;
            max-width: 150px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }

        input[type="email"],
        input[type="password"] {
            padding: 12px 15px;
            margin-bottom: 20px;
            border: 2px solid #93D8E8; 
            border-radius: 5px;
            font-size: 16px;
            background-color: #f9f9f9;
            transition: all 0.3s;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #5ec4d6;
            background-color: white;
        }

        button {
            background-color: #93D8E8;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #7bc4d4;
        }

        .seccionDerecha {
            flex: 1;
            background-color: #f5f5f5;
        }

        #cajaImagen {
            width: 100%;
            height: 100%;
            background-image: url('inicio.png');
            background-size: cover;
            background-position: center;
        }

        @media (max-width: 768px) {
            main {
                flex-direction: column;
                width: 90%;
            }
            
            .seccionDerecha {
                display: none;
            }
        }
    </style>
</head>

<body>
    <main>
        <section class="seccionIzquierda">
            <div id="contenedorFormulario">
                <h2>Inicio de sesión</h2>
                <img src="../logo.png" alt="Logo">

                <form id="login" action="login.php" method="post">
                    <label for="email">Correo</label>
                    <input type="email" id="email" name="email" required>

                    <label for="password">Contraseña</label>
                    <input type="password" id="password" name="password" required>

                    <button type="submit">Iniciar Sesión</button>
                </form>
            </div>
        </section>
        <section class="seccionDerecha">
            <div id="cajaImagen">
            </div>
        </section>
    </main>
</body>

</html>
