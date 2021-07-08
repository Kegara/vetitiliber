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

    $query = $conexion->query($sql);
    
    while ($resultado = $query->fetch_assoc()) {
        echo json_encode($resultado);
    }

    mysqli_close($conexion);

}
?>