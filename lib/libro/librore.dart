import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
// ignore: unused_import
import 'package:vetitiliber/libro/detallelibro.dart';

class ListadolibroPage extends StatefulWidget {
  ListadolibroPage({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'ListadolibroPage';
  @override
  _ListadolibroPage createState() => _ListadolibroPage();
}

class Review {
  final String titulo;
  final String fotoPerfil;
  final String nombre;
  final int calificacion;
  final String contenido;

  Review({
    this.titulo,
    this.fotoPerfil,
    this.nombre,
    this.calificacion,
    this.contenido,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return new Review(
      titulo: json['titulo'],
      fotoPerfil: json['fotoPerfil'],
      nombre: json['nombre'],
      calificacion: json['calificacion'],
      contenido: json['contenido'],
    );
  }
}

class _ListadolibroPage extends State<ListadolibroPage> {
  //listado de libros
  List<Review> _listBooks = [
    new Review(
      titulo:
          "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo",
      fotoPerfil:
          'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg',
      nombre: "Nombre del usuario",
      calificacion: 5,
      contenido: "Algo deberia ir aqui",
    ),
  ];

  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: appBar1("MY REVIEW", context),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              //titulo de seccion
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Mis Reviews",
                  style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                    color: Colors.black,
                  ),
                ),
              ),
              //seccion donde se mostraran los 10 libros
              Expanded(
                child: newSection("Mis Reviews"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  bool _auxBool = true;

  Widget newSection(String sectionName) {
    //se obtienen los libros
    // _listBooks = obtenerListado();
    if (_auxBool) {
      obtenerListado().then((value) {
        setState(() {
          _listBooks = value;
          _auxBool = false;
        });
      });
    }
    for (Review review in _listBooks) {
      print("review.calificacion: ${review.calificacion}");
      print("review.contenido: ${review.contenido}");
      print("review.fotoPerfil: ${review.fotoPerfil}");
      print("review.nombre: ${review.nombre}");
      print("review.titulo: ${review.titulo}");
    }
    return GridView.count(
      childAspectRatio: ((MediaQuery.of(context).size.width / 2 - 40) /
          (MediaQuery.of(context).size.height * 0.2)),
      crossAxisCount: 2,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      //generacion de libros en base a el tamaño de _topBooks contenedor de los libros
      children: List.generate(
        _listBooks.length,
        (index) {
          //generacion de libros
          return Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: [
                  Divider(thickness: 10,color: Colors.blue),
                new Padding(
                   padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  //generacion de titulo de libros
                  child: Text(
                    _listBooks[index].titulo,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                //generacion de portadas
                // contenedoresLibros(index),
                 Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 0),
                        child: Image.network(
                          _listBooks[index].fotoPerfil, //Imagen de portada
                          fit: BoxFit.cover,
                        ),
                      ),
                      flex: 3,
                    ),
                    new Expanded(
                      //generacion de titulo de libros
                      child: Padding(
                   padding: const EdgeInsets.only(top: 20.0, left: 10.0) ,
                   child:Text(
                        _listBooks[index].nombre,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      )),
                      flex: 7,
                    ),
                  ],
                ),
               
               new Expanded(
               child: Text(_listBooks[index].contenido,
    textAlign: TextAlign.start,),
               ),
                new    Padding(
                   padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
                  //generacion de titulo de libros
                  child: Text(
                    (estrellas(_listBooks[index].calificacion)),
                    style: new TextStyle(
                      fontSize: 15,
                      letterSpacing: 1.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String estrellas(int calificacion) {
    var calS = "";
    for (int cont = 1; cont <= calificacion; cont++) {
      calS += "★";
    }
    for (int cont = 1; cont <= (5 - calificacion); cont++) {
      calS += "☆";
    }
    return calS;
  }

  Future<String> getUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario').toString();
  }

  Future<List<Review>> obtenerListado() async {
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/usuarioReviews.php";
    final usID = await getUsuarioId();
    List<Review> _aux;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {
          "id": usID,
        },
      );
      List<dynamic> json = jsonDecode(response.body);
      print("(obtenerListado) response.body: ${response.body}");
      _aux = json.map((e) => Review.fromJson(e)).toList();
    } catch (err) {
      print("(obtenerListado) err: $err");
    }
    return _aux;
    // return ["g1 ", "g2", "g3", "g4", "g4"];
  }
}
