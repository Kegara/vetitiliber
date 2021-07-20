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
    
    $query = $conexion -> query($sql);

    echo json_encode($result);

    mysqli_close($conexion);

}
?>