import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'package:vetitiliber/libro/detallelibro.dart';

class StartPage extends StatefulWidget {
  //Variable en donde guardaremos la id del usuario
  // ignore: non_constant_identifier_names
  final int IdUser;

  // ignore: non_constant_identifier_names
  StartPage({Key key, this.IdUser}) : super(key: key);
  static String id = 'StartPage';
  @override
  _StartPageState createState() => _StartPageState();
}

class Libro {
  final int id;
  final String titulo;
  final String portada;

  Libro({
    this.id,
    this.titulo,
    this.portada,
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    return new Libro(
      id: json['id'],
      titulo: json['titulo'],
      portada: json['portada'],
    );
  }
}

class LibrosList {
  final List<Libro> libros;

  LibrosList({
    this.libros,
  });

  factory LibrosList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Libro> libros = new List<Libro>();
    libros = parsedJson.map((e) => Libro.fromJson(e)).toList();
    return LibrosList(
      libros: libros,
    );
  }
}

class _StartPageState extends State<StartPage> {
  //listado de libros
  LibrosList _topBooks;

  bool _aux = false;

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
                child: Text("Top libros"),
              ),
              //seccion donde se mostraran los 5 libros
              Expanded(
                child: newSection("Top libros"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // contenedor que tendra la info del libro el cual tiene asociado un onTap que redirige a la informacion del libro
  Widget contenedoresLibros(int nContenedor, String portada) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.4),
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            portada,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          new BoxShadow(blurRadius: 0.0),
        ],
      ),
      child: InkWell(
        onTap: () {
          int id = widget.IdUser;
          print("Container $nContenedor was tapped");
          print("Id del usuario a continuacion:$id");
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new DetalibroPage(idUser: 2, idLibro: nContenedor),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
  }

  Widget newSection(String sectionName) {
    //se obtienen los libros
    // _topBooks = obtenerTopBooks().then((value) => null);
    if (!_aux) {
      obtenerTopBooks().then((value) {
        setState(() {
          _topBooks = value;
          _aux = true;
          print("avr .v");
        });
      });
    }
    // printUsuarioId();
    // getUsuarioId().then((value) {
    //   print("id de usuario: $value");
    // });

    if (_aux) {
      return GridView.count(
        childAspectRatio: ((MediaQuery.of(context).size.width / 2 - 40) /
            (MediaQuery.of(context).size.height * 0.4)),
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        //generacion de libros en base a el tamaño de _topBooks contenedor de los libros
        children: List.generate(
          _topBooks.libros.length,
          (index) {
            //generacion de libros
            return Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                children: [
                  //generacion de portadas
                  contenedoresLibros(
                    _topBooks.libros[index].id,
                    _topBooks.libros[index].portada,
                  ),
                  new Expanded(
                    //generacion de titulo de libros
                    child: Text(
                      _topBooks.libros[index].titulo,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return GridView.count(
        childAspectRatio: ((MediaQuery.of(context).size.width / 2 - 40) /
            (MediaQuery.of(context).size.height * 0.4)),
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        //generacion de libros en base a el tamaño de _topBooks contenedor de los libros
        children: List.generate(
          5,
          (index) {
            //generacion de libros
            return Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                children: [
                  //generacion de portadas
                  contenedoresLibros(index,
                      "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw"),
                  new Expanded(
                    //generacion de titulo de libros
                    child: Text(
                      "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo ",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  Future<LibrosList> obtenerTopBooks() async {
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/topLibros.php";
    LibrosList _aux;
    try {
      final response = await get(Uri.parse(_url));
      final json = jsonDecode(response.body);
      _aux = new LibrosList.fromJson(json);
    } catch (err) {
      print("(obtenerTopBooks) err: $err");
    }
    return _aux;
    // return ["g1 ", "g2", "g3", "g4", "g4"];
  }

  void printUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    print("(Print) idUsuario: " + prefs.getInt('idUsuario').toString());
  }

  Future<String> getUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario').toString();
  }
}
