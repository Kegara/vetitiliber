<?php

        require "/conexion.php";

        $sql = "SELECT 'nombre','contrasena' FROM usuario";
        $query = $mysqli->query($sql);
        
        
        while($resultado = $query->fetch_assoc()) {
            echo json_encode($resultado);
        }
    
?>