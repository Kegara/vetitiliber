<?php

include "../conexion.php";

if (isset($_POST)){
    $id = $_POST['id'];
    $sql = 
    "SELECT
        us.fotoPerfil,
        (
        SELECT
            COUNT(AsB.usuarioA_id)
        FROM
            usuario AS us
            INNER JOIN A_sigue_B AS AsB ON AsB.usuarioB_id = us.id
        WHERE
            us.id = $id
        ) AS nSeguidores,
        (
        SELECT
            COUNT(res.id)
        FROM
            usuario AS us
            INNER JOIN resena AS res ON res.usuario_id = us.id
        WHERE
            us.id = $id
        ) AS nReviews,
        (
        SELECT
            COUNT(uhc.libro_id)
        FROM
            usuario AS us
            INNER JOIN usuario_has_coleccion AS uhc ON uhc.usuario_id = us.id
        WHERE
            us.id = $id
            AND uhc.coleccion_id = 1
        ) AS nFavoritos,
        (
        SELECT
            COUNT(uhc.libro_id)
        FROM
            usuario AS us
            INNER JOIN usuario_has_coleccion AS uhc ON uhc.usuario_id = us.id
        WHERE
            us.id = $id
            AND uhc.coleccion_id = 2
        ) AS nLeidos,
        (
        SELECT
            COUNT(uhc.libro_id)
        FROM
            usuario AS us
            INNER JOIN usuario_has_coleccion AS uhc ON uhc.usuario_id = us.id
        WHERE
            us.id = $id
            AND uhc.coleccion_id = 3
        ) AS nLeyendo,
        (
        SELECT
            COUNT(uhc.libro_id)
        FROM
            usuario AS us
            INNER JOIN usuario_has_coleccion AS uhc ON uhc.usuario_id = us.id
        WHERE
            us.id = $id
            AND uhc.coleccion_id = 4
        ) AS nPendientes
    FROM
        usuario AS us
    WHERE
        us.id = $id;";
  
    $query = $conexion -> query($sql);
        
    while ($resultado = $query->fetch_assoc()) {
        echo json_encode($resultado);
    }

    mysqli_close($conexion);
}
?>