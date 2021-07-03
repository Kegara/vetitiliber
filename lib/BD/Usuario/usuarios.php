<?php

require "../conexion.php";

if (isset($_POST)) {

    $usuario = $_POST["nombre"];
    $contraseña = $_POST["contrasena"];

    $sql = "SELECT id, nombre, contrasena FROM usuario WHERE nombre='$usuario' AND contrasena='$contraseña'";
    $query = $mysqli->query($sql);


    while ($resultado = $query->fetch_assoc()) {
        echo json_encode($resultado);
    }

    mysqli_close($mysqli);
}
?>