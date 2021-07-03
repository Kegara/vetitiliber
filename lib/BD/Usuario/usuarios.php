<?php
<<<<<<< HEAD
    if($_POST){
        require "/conexion.php";
=======

        require "../conexion.php";
>>>>>>> 6e349b3bd870a053b3f4a23fcb8bef31476f0e35

        $usuario = $_POST["nombre"];
        $contraseña = $_POST["contrasena"];

<<<<<<< HEAD
        $sql = "SELECT id,nombre,contrasena FROM usuario WHERE nombre='$usuario' AND contrasena='$contraseña'";
=======
        $sql = "SELECT id, nombre, contrasena FROM usuario WHERE nombre='$usuario' AND contrasena='$contraseña'";
>>>>>>> 6e349b3bd870a053b3f4a23fcb8bef31476f0e35
        $query = $mysqli->query($sql);
        
        
        while($resultado = $query->fetch_assoc()) {
            echo json_encode($resultado);
        }
    }
?>