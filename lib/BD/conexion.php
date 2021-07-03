<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
    
    // Variables de la conexion a la DB
    $conexion = new mysqli("myreviewvl.000webhostapp.com","myReviewUs","D+Gi3+{[/+sg!>Kk","myReview");
    
    // Comprobamos la conexion
    if($conexion->connect_errno) {
        die("Fallo la conexion");
    } else {
        //echo "Conexion exitosa";
        return $conexion;
    }
    
    
?>