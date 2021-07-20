<?php

include "../conexion.php";

    $sql = 
    "SELECT
        libro.id,
        libro.titulo,
        libro.portada
    FROM
        resena
        INNER JOIN libro ON resena.libro_id = libro.id
    GROUP BY
        libro_id
    ORDER BY
        AVG(calificacion) DESC
    LIMIT
        5;";
 
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