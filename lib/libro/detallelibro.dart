import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'package:vetitiliber/libro/answer.dart';

class DetalibroPage extends StatefulWidget {
  DetalibroPage({Key key, this.idUser, this.idLibro}) : super(key: key);

  final int idUser, idLibro;
  static String id = 'DetalibroPage';
  @override
  _DetalibroPageState createState() => _DetalibroPageState();
}

final int _idLibro = 6;

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
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  Future<Libro> getInfoLibro(int id) async {
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/detallesLibro.php";
    Libro _aux;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {"id": id.toString()},
      );
      final json = jsonDecode(response.body);
      _aux = new Libro.fromJson(json);
    } catch (err) {
      print("err: $err");
    }
    return _aux;
  }

  Libro _infoLibro;

  bool _auxBool = false;

  @override
  Widget build(BuildContext context) {
    print(widget.idUser);
    print(widget.idLibro);
    getInfoLibro(widget.idLibro).then((value) {
      setState(() {
        _infoLibro = value;
        _auxBool = true;
      });
    });
    return Column(
      children: [
        //Texto inicial de la sección debe ir el titulo del libro
        titulo("El libro mas grande del mundo"),
        calificacion(3, 50),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                //Aquí empieza el listado de acciones
                child: ListView(
                  children: <Widget>[
                    Text(
                      "\n",
                      style: new TextStyle(
                        fontSize: 5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                        color: Colors.black,
                      ),
                    ),
                    //Imagen del libro--------------------------------
                    Image.asset(
                      'assets/imagenes/login/LOGO2.png', //Imagen de portada
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Detalles\n",
                      style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                        color: Colors.black,
                      ),
                    ),
                    //Inicia el campo de sipnosis--------------------------------------------------
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Sipnosis\n",
                            style: new TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5.0,
                              color: Colors.black,
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Text(
                            "Sipnosis\n",
                            style: new TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.0,
                              color: Colors.black,
                            ),
                          ),
                          flex: 7,
                        ),
                      ],
                    ),
                    //Inicia el campo del autor--------------------------------------------------
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Autor\n",
                            style: new TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5.0,
                              color: Colors.black,
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Text(
                            "Nombre del autor\n",
                            style: new TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.0,
                              color: Colors.black,
                            ),
                          ),
                          flex: 7,
                        ),
                      ],
                    ),
                    //Inicia el campo de genero--------------------------------------------------
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Genero\n",
                            style: new TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5.0,
                              color: Colors.black,
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Text(
                            "Van los generos\n",
                            style: new TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.0,
                              color: Colors.black,
                            ),
                          ),
                          flex: 7,
                        ),
                      ],
                    ),
                    //Nuevo campo-------------------------------------------------------------------
                    Text(
                      "\nReseñas\n",
                      style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: MyStatefulWidget(),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(''),
                          flex: 8,
                        ),
                      ],
                    ),
                    TextFormField(
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // devolverá true si el formulario es válido, o falso si
                                // el formulario no es válido.
                                if (_formKey.currentState.validate()) {
                                  // Si el formulario es válido, queremos mostrar un Snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Procesing Data"),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Image.asset(
                              'assets/imagenes/login/LOGO2.png', //Imagen de portada
                              fit: BoxFit.cover,
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                              "Name del usuario\n☆☆☆☆☆",
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
                              "Va toda la reseña",
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
                            child: Text(
                              "",
                              style: new TextStyle(
                                fontSize: 15,
                                letterSpacing: 2.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Icon(
                              Icons.thumb_up_alt_outlined,
                              color: Colors.lightBlue,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "80",
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Icon(
                              Icons.thumb_down_outlined,
                              color: Colors.red,
                              size: 30.0,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

Widget titulo(String titulo) {
  return Text(
    //Texto inicial de la sección debe ir el titulo del libro
    "Titulo va aqui",
    style: new TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      letterSpacing: 5.0,
      color: Colors.black,
    ),
  );
}

Widget calificacion(double calificacion, int reviews) {
  String calS = " ";
  for (int cont = 1; cont <= calificacion; cont++) {
    calS += "★";
  }
  for (int cont = 1; cont <= (5 - calificacion); cont++) {
    calS += "☆";
  }
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

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = '0';

  @override
  Widget build(BuildContext context) {
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
