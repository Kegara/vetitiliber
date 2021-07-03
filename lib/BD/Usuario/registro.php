<?php
    if($_POST){
        require "../conexion.php";


        $usuario = $_POST["nombre"];
        $contraseña = $_POST["contrasena"];
        $email = $_POST["correoElectronico"];


        $sql = "INSERT INTO usuario (nombre, contrasena, correoElectronico) VALUES ('$usuario','$contraseña','$email')";
        
        mysqli_query($conexion,$sql);

        mysqli_close($conexion);

    }
?>