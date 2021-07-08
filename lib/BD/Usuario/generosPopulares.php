<?php
include "../conexion.php";

$sql = 
"SELECT
    lbgn.genero_id,
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

$query = $conexion->query($sql);

while ($resultado = $query->fetch_assoc()) {
    echo json_encode($resultado);
}

mysqli_close($conexion)
    
?>