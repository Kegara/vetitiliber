<?php

require "../conexion.php";

if (isset($_POST)) {

    $calificacion = $_POST["calificacion"];
    $contenido = $_POST["contenido"];
    $resena_id = $_POST["resena_id"];

    $sql = "UPDATE resena SET calification = $calificacion, contenido = $contenido WHERE id = $resena_id";
    
    mysqli_query($conexion,$sql);
    mysqli_close($conexion);
}
?>