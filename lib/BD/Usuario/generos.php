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

    // $query = $conexion->query($sql);
    
    // while ($resultado = $query->fetch_all(PE)) {
    //     echo json_encode($resultado);
    // }
    // $resultado = $query->fetch_all(PE);
    
    // echo json_encode($resultado);
    
    $db_name = "id17151113_myreview";
    $db_server = "localhost";
    $db_user = "id17151113_myreviewus";
    $db_pass = "D+Gi3+{[/+sg!>Kk";

    $db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
    $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $stmt = $db->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($result);

    mysqli_close($conexion);
?>