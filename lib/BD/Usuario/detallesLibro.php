<?php
include('../conexion.php');
if (isset($_POST)){
    $id = $_POST['id'];
    $sql = 
    "SELECT
        libro.*,
        autor.nombre AS nombreAutor,
        COALESCE(AVG(resena.calificacion), 0) AS calificacionP,
        COUNT(resena.id) AS resenas
    FROM
        resena
        LEFT JOIN libro ON resena.libro_id = libro.id
        INNER JOIN autor ON libro.autor_id = autor.id
    WHERE
        libro.id = $id;";
    
    $query = $conexion -> query($sql);
    
    while ($resultado = $query->fetch_assoc()) {
        echo json_encode($resultado);
    }

    mysqli_close($conexion);

}
?>