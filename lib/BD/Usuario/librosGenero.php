<?php

include "../conexion.php";

if (isset($_POST)) {
    $idGenero = $_POST['idGenero'];
    $limite = $_POST['limite'];
    ($limite == 0)? $limite = "": $limite = "LIMIT $limite";
    $sql = 
    "SELECT
      lb.*,
      lbgn.genero_id
    FROM
      libro AS lb
      INNER JOIN libro_has_genero AS lbgn ON lbgn.libro_id = lb.id
    WHERE lbgn.genero_id = $idGenero
    $limite
    ;
    ";
    // echo $sql;

    // $query = $conexion->query($sql);
    
    // while ($resultado = $query->fetch_assoc()) {
    //     echo json_encode($resultado);
    // }

    // mysqli_close($conexion);

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

}
?>