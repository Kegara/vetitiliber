<?php

include "../conexion.php";

if (isset($_POST)){
    $id = $_POST['id'];
    $contenido = $_POST['contenido'];
    $tabla = $_POST['tabla'];
    $campo = $_POST['campo'];

    switch($tabla) {
        case 0:
            $tabla = 'usuario';
            switch($campo) {
                case 0:
                    $campo = 'nombre';
                    break;
                case 1:
                    $campo = 'contrasena';
                    break;
                case 2:
                    $campo = 'fotoPerfil';
                    switch($contenido) {
                        case 0:
                            $contenido = "https://static.vecteezy.com/system/resources/previews/001/917/629/non_2x/person-reading-book-free-photo.jpg";
                            break;
                        case 1:
                            $contenido = "https://image1.masterfile.com/getImage/NjczLTA2MDI1NTAzZW4uMDAwMDAwMDA=AJal11/673-06025503en_Masterfile.jpg";
                            break;
                        case 2:
                            $contenido =  "https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg";
                            break;
                        case 3:
                            $contenido =  "https://previews.123rf.com/images/jojjik/jojjik1204/jojjik120400036/13014704-bald-man-in-suit-reads-a-bible-isolated-on-white.jpg";
                            break;
                        case 4:
                            $contenido = "https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHJlYWRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80";
                            break;
                        case 5:
                            $contenido = "https://qph.fs.quoracdn.net/main-qimg-dfc610007178ffb94a0ef143aeb56cfd-c";
                            break;
                    }
                    break;
                case 3:
                    $campo = 'correoElectronico';
                    break;
            }
            break;
        case 1:
            $tabla = 'configuracion';
            switch($campo) {
                case 0:
                    $campo = 'vLibros';
                    break;
                case 1:
                    $campo = 'vResenas';
                    break;
                case 2:
                    $campo = 'vPerfil';
                    break;
            }
            break;
    }
    
    $sql = 
    "UPDATE
        $tabla
    SET
        $campo = '$contenido'
    WHERE
        id = $id;";
    
    mysqli_query($conexion,$sql);

}

    mysqli_close($conexion);
?>