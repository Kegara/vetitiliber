import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'package:vetitiliber/libro/detallelibro.dart';

class ListadopenPage extends StatefulWidget {
  ListadopenPage({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'ListadopenPage';
  @override
  _ListadopenPage createState() => _ListadopenPage();
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

class _ListadopenPage extends State<ListadopenPage> {
  //listado de libros
  List<Libro> _listBooks = [
    new Libro(
      id: 1,
      titulo:
          "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo",
      portada:
          "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
    ),
    new Libro(
      id: 1,
      titulo:
          "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo",
      portada:
          "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
    ),
    new Libro(
      id: 1,
      titulo:
          "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo",
      portada:
          "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
    ),
    new Libro(
      id: 1,
      titulo:
          "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo",
      portada:
          "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
    ),
    new Libro(
      id: 1,
      titulo:
          "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo",
      portada:
          "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
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
                  "Pendientes",
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
                child: newSection("Pendientes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // contenedor que tendra la info del libro el cual tiene asociado un onTap que redirige a la informacion del libro
  Widget contenedoresLibros(int nContenedor, String portada, int id) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.4),
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            portada,
            // "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
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
          print("Container $nContenedor was tapped");
          _auxBool = true;
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new DetalibroPage(idUser: id, idLibro: nContenedor),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
  }

  bool _auxBool = true;
  int idUs = 1;

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

    return GridView.count(
      childAspectRatio: ((MediaQuery.of(context).size.width / 2 - 40) /
          (MediaQuery.of(context).size.height * 0.4)),
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
                //generacion de portadas
                contenedoresLibros(
                  _listBooks[index].id,
                  _listBooks[index].portada,
                  idUs,
                ),
                new Expanded(
                  //generacion de titulo de libros
                  child: Text(
                    _listBooks[index].titulo,
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

  Future<String> getUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario').toString();
  }

  Future<List<Libro>> obtenerListado() async {
    idUs = int.parse(await getUsuarioId());
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/librosUsuarioColeccion.php";
    List<Libro> _aux;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {
          "idu": idUs.toString(),
          "idc": '4',
        },
      );
      final List<dynamic> json = jsonDecode(response.body);
      _aux = json.map((e) => Libro.fromJson(e)).toList();
    } catch (err) {
      print("(obtenerListado) err: $err");
    }
    return _aux;
    // return ["g1 ", "g2", "g3", "g4", "g4"];
  }
}
