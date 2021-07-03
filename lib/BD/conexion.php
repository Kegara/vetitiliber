<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
    
    // Variables de la conexion a la DB
    $conexion = new mysqli("localhost","id17151113_myreviewus","D+Gi3+{[/+sg!>Kk","id17151113_myreview");
    
    // Comprobamos la conexion
    if($conexion->connect_errno) {
        die("Fallo la conexion");
    } else {
        //echo "Conexion exitosa";
    }
    
    
?>