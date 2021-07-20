<?php

require "../conexion.php";

if (isset($_POST)) {

    $calificacion = $_POST["calificacion"];
    $contenido = $_POST["contenido"];
    $usuario_id = $_POST["usuario_id"];
    $libro_id = $_POST["libro_id"];

    $sql = "INSERT INTO resena (calificacion, contenido, usuario_id, libro_id) VALUES ('$calificacion','$contenido', '$usuario_id', '$libro_id')";
    
    mysqli_query($conexion,$sql);
    mysqli_close($conexion);
}
?>