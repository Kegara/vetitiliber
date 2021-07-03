<?php
    if($_POST){
        require "/conexion.php";


        $usuario = $_POST["nombre"];
        $contraseña = $_POST["contrasena"];
        $email = $_POST["email"];


        $sql = "INSERT INTO usuario (nombre, contrasena) VALUES ('$usuario','$contraseña')";
        
        $query = $mysqli->query($sql);
        
        
    }
?>