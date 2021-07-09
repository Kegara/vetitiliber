<?php

include "../conexion.php";

    $sql = 
    "SELECT
      *
    FROM
      genero
    ;
    ";
    // echo $sql;

    $query = $conexion->query($sql);
    
    while ($resultado = $query->fetch_assoc()) {
        echo json_encode($resultado);
    }

    mysqli_close($conexion);

?>