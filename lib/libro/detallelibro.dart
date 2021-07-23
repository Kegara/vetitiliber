import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'package:vetitiliber/libro/answer.dart';

String calf;

class DetalibroPage extends StatefulWidget {
  DetalibroPage({Key key, this.idUser, this.idLibro}) : super(key: key);

  final int idUser, idLibro;
  static String id = 'DetalibroPage';
  @override
  _DetalibroPageState createState() => _DetalibroPageState();
}

class Libro {
  final int id;
  final String titulo;
  final String sinopsis;
  final String portada;
  final int autorID;
  final String nombreAutor;
  final double calificacionP;
  final int resenas;

  Libro({
    this.id,
    this.titulo,
    this.sinopsis,
    this.portada,
    this.autorID,
    this.nombreAutor,
    this.calificacionP,
    this.resenas,
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    return new Libro(
      id: int.parse(json['id']),
      titulo: json['titulo'],
      sinopsis: json['sinopsis'],
      portada: json['portada'],
      autorID: json['autorID'],
      nombreAutor: json['nombreAutor'],
      calificacionP: double.parse(json['calificacionP']),
      resenas: int.parse(json['resenas']),
    );
  }
}

class Genero {
  final String nombre;

  Genero({
    this.nombre,
  });

  factory Genero.fromJson(Map<String, dynamic> json) {
    return new Genero(
      nombre: json['nombre'],
    );
  }
}

class GenerosList {
  final List<Genero> generos;

  GenerosList({
    this.generos,
  });

  factory GenerosList.fromJson(List<dynamic> json) {
    // ignore: deprecated_member_use
    List<Genero> generos = new List<Genero>();
    generos = json.map((e) => Genero.fromJson(e)).toList();
    return new GenerosList(
      generos: generos,
    );
  }
}

class LikedReview {
  final int id;

  LikedReview({
    this.id,
  });

  factory LikedReview.fromJson(Map<String, dynamic> json) {
    return new LikedReview(
      id: json['id'],
    );
  }
}

class Resena {
  final int id;
  final int calificacion;
  final String contenido;
  final int usuarioID;
  final String usuario;
  final int likes;
  final String fotoPerfil;

  Resena({
    this.id,
    this.calificacion,
    this.contenido,
    this.usuarioID,
    this.usuario,
    this.likes,
    this.fotoPerfil,
  });

  factory Resena.fromJson(Map<String, dynamic> json) {
    return new Resena(
      id: json['id'],
      calificacion: json['calificacion'],
      contenido: json['contenido'],
      usuarioID: json['usuarioID'],
      usuario: json['nombre'],
      likes: int.parse(json['likes']),
      fotoPerfil: json['fotoPerfil'],
    );
  }
}

class ResenasList {
  final List<Resena> resenas;

  ResenasList({
    this.resenas,
  });

  factory ResenasList.fromJson(List<dynamic> json) {
    // ignore: deprecated_member_use
    List<Resena> resenas = new List<Resena>();
    resenas = json.map((e) => Resena.fromJson(e)).toList();
    return new ResenasList(
      resenas: resenas,
    );
  }
}

class _DetalibroPageState extends State<DetalibroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: appBar1("Descripción del libro", context),
      body: MyCustomForm(widget.idLibro, widget.idUser),
    );
  }
}

// Crea un Widget Form
class MyCustomForm extends StatefulWidget {
  final int idLibro, idUser;

  MyCustomForm(this.idLibro, this.idUser);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// el formulario.
class MyCustomFormState extends State<MyCustomForm> {
  final urlInsertResena =
      "https://myreviewvl.000webhostapp.com/BD/Usuario/InsertarResena.php";
  int calificacionget;
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKeyResenas = GlobalKey<FormState>();
  //valor donde se fuardara la reseña escrita por el usuario
  final reviewController = TextEditingController();
  GenerosList _generos;

  Future<GenerosList> getGenerosLibro(int id) async {
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/generosLibro.php";
    GenerosList _auxResenasList;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {"id": id.toString()},
      );
      final json = jsonDecode(response.body);
      _auxResenasList = new GenerosList.fromJson(json);
    } catch (err) {
      print("(getGenerosLibro) err: $err");
    }
    return _auxResenasList;
  }

  Future<Libro> getInfoLibro(int id) async {
    _generos = await getGenerosLibro(id);
    print("(getInfoLibro) id: $id");
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/detallesLibro.php";
    Libro _auxResenasList;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {
          "id": id.toString(),
        },
      );
      print("(getInfoLibro) response.body: ${response.body}");
      final json = jsonDecode(response.body);
      _auxResenasList = new Libro.fromJson(json);
    } catch (err) {
      print("(getInfoLibro) err: $err");
    }
    return _auxResenasList;
  }

  Libro _infoLibro;

  bool _auxResenasListBool = false;

  String _auxResenasListGeneros = "";

  @override
  Widget build(BuildContext context) {
    if (!_auxResenasListBool) {
      getInfoLibro(widget.idLibro).then((value) {
        setState(() {
          _auxResenasListGeneros = "";
          _infoLibro = value;
          _auxResenasListBool = true;
          for (Genero genero in _generos.generos) {
            print("genero.nombre: ${genero.nombre}");
            _auxResenasListGeneros += "${genero.nombre}\n";
          }
          print("(1) _auxResenasListGeneros: $_auxResenasListGeneros");
        });
      });
    }

    if (_auxResenasListBool) {
      print("(2) _auxResenasListGeneros: $_auxResenasListGeneros");
      return Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Texto inicial de la sección debe ir el titulo del libro

                new Expanded(
                  //Aquí empieza el listado de acciones
                  child: ListView(
                    children: <Widget>[
                      //titulo libro
                      txtconf(
                        _infoLibro.titulo,
                        30,
                        5,
                        FontWeight.bold,
                      ),
                      //calificacion y total de reviews
                      calificacion(
                        _infoLibro.calificacionP.round(),
                        _infoLibro.resenas,
                      ),
                      //espacio xddxdxd
                      txtconf("\n", 5, 5, FontWeight.bold),
                      //Imagen del libro--------------------------------
                      Image.network(
                        _infoLibro.portada, //Imagen de portada
                        fit: BoxFit.cover,
                      ),
                      //titulo detalles
                      txtconf("Detalles\n", 20, 5, FontWeight.bold),
                      //Inicia el campo de sipnosis--------------------------------------------------
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:
                                //titulo sinopsis
                                txtconf("Sipnosis\n", 15, 5, FontWeight.bold),
                            flex: 3,
                          ),
                          Expanded(
                            child:
                                //detalle sinopsis
                                txtconf(
                              "${_infoLibro.sinopsis}\n",
                              15,
                              2,
                              FontWeight.normal,
                            ),
                            flex: 7,
                          ),
                        ],
                      ),
                      //Inicia el campo del autor--------------------------------------------------
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: txtconf("Autor\n", 15, 5, FontWeight.bold),
                            flex: 3,
                          ),
                          Expanded(
                            child: txtconf("${_infoLibro.nombreAutor}\n", 15, 2,
                                FontWeight.normal),
                            flex: 7,
                          ),
                        ],
                      ),
                      //Inicia el campo de genero--------------------------------------------------
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: txtconf("Generos\n", 15, 5, FontWeight.bold),
                            flex: 3,
                          ),
                          Expanded(
                            child: txtconf(
                              "\n$_auxResenasListGeneros",
                              15,
                              2,
                              FontWeight.normal,
                            ),
                            flex: 7,
                          ),
                        ],
                      ),
                      //Nuevo campo-------------------------------------------------------------------

                      txtconf("\nReseñas\n", 20, 5, FontWeight.bold),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: MyStatefulWidget(),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text("Calificación"),
                            flex: 8,
                          ),
                        ],
                      ),
                      Form(
                        key: _formKeyResenas,
                        child: TextFormField(
                          controller: reviewController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor introduzca texto';
                            }
                            return null;
                          },
                          maxLines: null,
                          maxLength: 200,
                          decoration: InputDecoration(
                            hintText: 'Escriba su reseña, por favor.',
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  hacerreview();
                                },
                                child: Text('Publicar'),
                              ),
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            child: Text(''),
                            flex: 7,
                          )
                        ],
                      ),
                      Divider(),
                      //Visualización de las reseñas-------------------------------------------------------------------
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: generadorresenas(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Texto inicial de la sección debe ir el titulo del libro

                new Expanded(
                  //Aquí empieza el listado de acciones
                  child: ListView(
                    children: <Widget>[
                      //titulo libro
                      txtconf(
                        "Lo bueno de una cuenta oficial sin lo malo de una cuenta oficial. Administrada por el equipo de comunidad española.",
                        30,
                        5,
                        FontWeight.bold,
                      ),
                      //calificacion y total de reviews
                      calificacion(4, 50),
                      //espacio xddxdxd
                      txtconf("\n", 5, 5, FontWeight.bold),
                      //Imagen del libro--------------------------------
                      Image.asset(
                        'assets/imagenes/login/LOGO2.png', //Imagen de portada
                        fit: BoxFit.cover,
                      ),
                      //titulo detalles
                      txtconf("Detalles\n", 20, 5, FontWeight.bold),
                      //Inicia el campo de sipnosis--------------------------------------------------
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:
                                //titulo sinopsis
                                txtconf("Sipnosis\n", 15, 5, FontWeight.bold),
                            flex: 3,
                          ),
                          Expanded(
                            child:
                                //detalle sinopsis
                                txtconf("Sipnosis\n", 15, 2, FontWeight.normal),
                            flex: 7,
                          ),
                        ],
                      ),
                      //Inicia el campo del autor--------------------------------------------------
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: txtconf("Autor\n", 15, 5, FontWeight.bold),
                            flex: 3,
                          ),
                          Expanded(
                            child: txtconf(
                                "Nombre del autor\n", 15, 2, FontWeight.normal),
                            flex: 7,
                          ),
                        ],
                      ),
                      //Inicia el campo de genero--------------------------------------------------
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: txtconf("Genero", 15, 5, FontWeight.bold),
                            flex: 3,
                          ),
                          Expanded(
                            child: txtconf(
                              "Aqui van los generos \n",
                              15,
                              2,
                              FontWeight.normal,
                            ),
                            flex: 7,
                          ),
                        ],
                      ),
                      //Nuevo campo-------------------------------------------------------------------

                      txtconf("\nReseñas\n", 20, 5, FontWeight.bold),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: MyStatefulWidget(),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Text("Calificación"),
                            flex: 8,
                          ),
                        ],
                      ),
                      Form(
                        key: _formKeyResenas,
                        child: TextFormField(
                          controller: reviewController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor introduzca texto';
                            }
                            return null;
                          },
                          maxLines: null,
                          maxLength: 200,
                          decoration: InputDecoration(
                            hintText: 'Escriba su reseña, por favor.',
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  hacerreview();
                                },
                                child: Text('Publicar'),
                              ),
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            child: Text(''),
                            flex: 7,
                          )
                        ],
                      ),
                      Divider(),
                      //Visualización de las reseñas-------------------------------------------------------------------
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: generadorresenas(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  // funcion que genera la review
  void hacerreview() {
    String resena2 = reviewController.text;

    print(resena2);
    if (_formKeyResenas.currentState.validate()) {
      String resenaf = reviewController.text;
      postResena(
        widget.idUser.toString(),
        widget.idLibro.toString(),
        resenaf,
        getcalf(),
      );
      // Si el formulario es válido, queremos mostrar un Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Procesing Data"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      //se llama a la funcion que califica el libro
      calificarlibro(resena2);
    }
  }

  //widget que contiene la reseña
  Widget resenas(
    String usuario,
    int calificacion,
    int idresena,
    String resena,
    int likes,
    bool likeada,
    String fotoPerfil,
  ) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Image.network(
                  fotoPerfil, //Imagen de portada
                  fit: BoxFit.cover,
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Text(
                  (estrellas(usuario + "\n", calificacion)),
                  style: new TextStyle(
                    fontSize: 15,
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ),
              ),
              flex: 7,
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "$resena",
                  style: new TextStyle(
                    fontSize: 15,
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ),
              ),
              flex: 9,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: txtconf("", 15, 2, FontWeight.normal),
              ),
              flex: 1,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  like();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Icon(
                    likeada == true
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined,
                    color: Colors.lightBlue,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "$likes",
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  //Aqui va la funcion pa dislikes
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Icon(
                    Icons.thumb_down_outlined,
                    color: Colors.red,
                    size: 30.0,
                  ),
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: IconButton(
                  icon: const Icon(
                    Icons.insert_comment_outlined,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AnswerPage.id);
                  },
                ),
              ),
              flex: 3,
            ),
          ],
        )
      ],
    );
  }

  List<LikedReview> _likedReviews;

  Future<List<LikedReview>> getLiked() async {
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/likedReviews.php";
    List<LikedReview> _aux;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {
          'id': await getUsuarioId(),
        },
      );
      List<dynamic> json = jsonDecode(response.body);
      print("response.body: ${response.body}");
      _aux = json.map((e) => LikedReview.fromJson(e)).toList();
    } catch (err) {
      print("(getLiked) err: $err");
    }
    return _aux;
  }

  Future<String> getUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario').toString();
  }

  Future<ResenasList> getResenas() async {
    _likedReviews = await getLiked();
    for (LikedReview lr in _likedReviews) {
      print("lr: ${lr.id}");
    }
    // print("getUsuarioId(): ${await getUsuarioId()}");
    print("widget.idLibro: ${widget.idLibro}");
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/resenasLibro.php";
    ResenasList _auxResenasList;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {
          "id": widget.idLibro.toString(),
        },
      );
      print("(getResenas) response.body: ${response.body}");
      final json = jsonDecode(response.body);
      print("(getResenas) json: ${json}");
      _auxResenasList = new ResenasList.fromJson(json);
    } catch (err) {
      print("(getResenas) err: $err");
    }
    return _auxResenasList;
  }

  bool checkLiked(id) {
    for (LikedReview review in _likedReviews) {
      if (review.id == id) {
        return true;
      }
    }
    return false;
  }

  bool _auxBoolResenas = false;

  ResenasList _resenasList;

  //esta funcion genera una lista de reseñas y las regresa para mostrarlas en el container
  List<Widget> generadorresenas() {
    var pwdWidgets = <Widget>[];
    if (_auxBoolResenas) {
      for (Resena resena in _resenasList.resenas) {
        pwdWidgets.add(resenas(
          resena.usuario,
          resena.calificacion,
          resena.id,
          resena.contenido,
          resena.likes,
          checkLiked(resena.id),
          resena.fotoPerfil,
        ));
      }
    } else {
      getResenas().then((value) {
        setState(() {
          _resenasList = value;
          _auxBoolResenas = true;
        });
      });
      pwdWidgets.add(resenas(
        "Paulos",
        2,
        1,
        "zzz",
        80,
        true,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
      pwdWidgets.add(resenas(
        "Paulos  2",
        3,
        1,
        "zzz",
        80,
        false,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
      pwdWidgets.add(resenas(
        "Paulos",
        1,
        1,
        "zzz",
        80,
        true,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
      pwdWidgets.add(resenas(
        "Paulos  2",
        4,
        1,
        "zzz",
        80,
        false,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
      pwdWidgets.add(resenas(
        "Paulos",
        5,
        1,
        "zzz",
        80,
        true,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
      pwdWidgets.add(resenas(
        "Paulos  2",
        2,
        1,
        "zzz",
        80,
        false,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
      pwdWidgets.add(resenas(
        "Paulos",
        3,
        1,
        "zzz",
        80,
        true,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
      pwdWidgets.add(resenas(
        "Paulos  2",
        1,
        1,
        "zzz",
        80,
        false,
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      ));
    }
    return pwdWidgets;
  }

  void postResena(userID, libroID, resena, calificacion) async {
    try {
      await post(
        Uri.parse(urlInsertResena),
        body: {
          "calificacion": calificacion,
          "contenido": resena,
          "usuario_id": userID,
          "libro_id": libroID,
        },
      );
    } catch (err) {
      print("error en el post: $err");
    }
  }

  void postActualizarResena(resenaID, resena, calificacion) async {
    try {
      final response = await post(
        Uri.parse(urlInsertResena),
        body: {
          "calificacion": calificacion,
          "contenido": resena,
          "resena_id": resenaID,
        },
      );
    } catch (err) {
      print("error en el post: $err");
    }
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

//calificacion de los libros
Widget calificacion(int calificacion, int reviews) {
  String calS = " ";
  calS += estrellas(calS, calificacion);
  calS += " (" + reviews.toString() + ")";
  return Text(
    //Texto inicial de la sección debe ir la calificación y por cuantos
    calS,
    style: new TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      letterSpacing: 5.0,
      color: Colors.black,
    ),
  );
}

String estrellas(String string, int calificacion) {
  var calS = string;
  for (int cont = 1; cont <= calificacion; cont++) {
    calS += "★";
  }
  for (int cont = 1; cont <= (5 - calificacion); cont++) {
    calS += "☆";
  }
  return calS;
}

//formato para la creacion de textos
Widget txtconf(String texto, double fz, double ls, FontWeight fw) {
  return Text(
    texto,
    style: new TextStyle(
      fontSize: fz,
      fontWeight: fw,
      letterSpacing: ls,
      color: Colors.black,
    ),
  );
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = '0';
  @override
  Widget build(BuildContext context) {
    calf = dropdownValue;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.star_rounded),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          setcalf(newValue);
        });
      },
      items: <String>['0', '1', '2', '3', '4', '5']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//funcion para calificar libros
void calificarlibro(String resena) {
  //la reseña escrita por el usuario
  print(resena);
  //calf es la calificacion
}

void like() {}
//funcion para obtener la calificacion del combobox
String getcalf() {
  //regresa el valor de la calificacion
  return calf;
}

//funcion para poner la calificacion del combobox
void setcalf(String ncalf) {
  //calf es la calificacion
  calf = ncalf;
}
