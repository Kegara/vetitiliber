<?php
include('../conexion.php');
if (isset($_POST)){
    $id = $_POST['id'];
    $sql = 
    "SELECT
        libro.*,
        autor.nombre AS nombreAutor,
        AVG(resena.calificacion) AS calificacionP,
        COUNT(resena.id) AS resenas
    FROM
        resena
        INNER JOIN libro ON resena.libro_id = libro.id
        INNER JOIN autor ON libro.autor_id = autor.id
    WHERE
        libro.id = $id
    GROUP BY
        resena.libro_id;";

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