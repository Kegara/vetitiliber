<?php
    
    // Variables de la conexion a la DB
    $mysqli = new mysqli("myreviewvl.000webhostapp.com","myReviewUs","D+Gi3+{[/+sg!>Kk","myReview");
    
    // Comprobamos la conexion
    if($mysqli->connect_errno) {
        die("Fallo la conexion");
    } else {
        //echo "Conexion exitosa";
    }
    
?>