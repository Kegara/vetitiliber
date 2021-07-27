<?php

include "../conexion.php";

if (isset($_POST)){
    $id = $_POST['id'];
    $contenido = $_POST['contenido'];
    $tabla = $_POST['tabla'];
    $campo = $_POST['campo'];

    switch($tabla) {
        case 0:
            $tabla = 'usuario';
            switch($campo) {
                case 0:
                    $campo = 'nombre';
                    break;
                case 1:
                    $campo = 'contrasena';
                    break;
                case 2:
                    $campo = 'fotoPerfil';
                    break;
                case 3:
                    $campo = 'correoElectronico';
                    break;
            }
            break;
        case 1:
            $tabla = 'configuracion';
            switch($campo) {
                case 0:
                    $campo = 'vLibros';
                    break;
                case 1:
                    $campo = 'vResenas';
                    break;
                case 2:
                    $campo = 'vPerfil';
                    break;
            }
            break;
    }
    
    $sql = 
    "UPDATE
        $tabla
    SET
        $campo = '$contenido'
    WHERE
        id = $id;";
    
    mysqli_query($conexion,$sql);

}

    mysqli_close($conexion);
?>