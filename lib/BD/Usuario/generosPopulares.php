<?php
include "../conexion.php";

$sql = 
"SELECT
    lbgn.genero_id AS id,
    gn.nombre,
    COUNT(lbgn.genero_id) AS NumLibros
FROM
    libro AS lb
    INNER JOIN libro_has_genero AS lbgn ON lbgn.libro_id = lb.id
    INNER JOIN genero AS gn ON lbgn.genero_id = gn.id
    INNER JOIN usuario_has_coleccion AS uscl ON uscl.libro_id = lb.id
WHERE
    uscl.coleccion_id = 2
GROUP BY
    lbgn.genero_id
LIMIT 5;";

// $query = $conexion->query($sql);

// while ($resultado = $query->fetch_assoc()) {
//     echo json_encode($resultado);
// }
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