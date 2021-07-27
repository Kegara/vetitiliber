<?php

include "../conexion.php";

if (isset($_POST)){
    $id = $_POST['id'];
    $sql = 
    "SELECT
        nombre,
        contrasena,
        CASE
            WHEN fotoPerfil LIKE 'https://static.vecteezy.com/system/resources/previews/001/917/629/non_2x/person-reading-book-free-photo.jpg' THEN 0
            WHEN fotoPerfil LIKE 'https://image1.masterfile.com/getImage/NjczLTA2MDI1NTAzZW4uMDAwMDAwMDA=AJal11/673-06025503en_Masterfile.jpg' THEN 1
            WHEN fotoPerfil LIKE 'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg' THEN 2
            WHEN fotoPerfil LIKE 'https://previews.123rf.com/images/jojjik/jojjik1204/jojjik120400036/13014704-bald-man-in-suit-reads-a-bible-isolated-on-white.jpg' THEN 3
            WHEN fotoPerfil LIKE 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHJlYWRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80' THEN 4
            WHEN fotoPerfil LIKE 'https://qph.fs.quoracdn.net/main-qimg-dfc610007178ffb94a0ef143aeb56cfd-c' THEN 5
        END AS fotoPerfilNum,
        correoElectronico,
        vLibros,
        vResenas,
        vPerfil
    FROM
        usuario
        INNER JOIN configuracion ON configuracion.usuario_id = usuario.id
    WHERE usuario.id = $id;";
      
      $query = $conexion -> query($sql);
        
      while ($resultado = $query->fetch_assoc()) {
          echo json_encode($resultado);
      }
}

    mysqli_close($conexion);
?>