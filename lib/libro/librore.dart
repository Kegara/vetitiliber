import 'package:flutter/material.dart';
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

class _ListadolibroPage extends State<ListadolibroPage> {
  //listado de libros
  List _listBooks = ["g1 ", "g2", "g3", "g4", "g4"];

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

  // contenedor que tendra la info del libro el cual tiene asociado un onTap que redirige a la informacion del libro
  /* Widget contenedoresLibros(int nContenedor) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.3),
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
              "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw"),
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
          Navigator.of(context).pushNamed(DetalibroPage.id);
        },
      ),
    );
  }*/

  Widget newSection(String sectionName) {
    //se obtienen los libros
    // _listBooks = obtenerListado();
    var longitud = _listBooks.length;
    String titulo =
        "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo";
    String fotoPerfil =
        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg';
    String nombreUs = "Nombre del usuario";
    int calificacion = 5;
    return GridView.count(
      childAspectRatio: ((MediaQuery.of(context).size.width / 2 - 40) /
          (MediaQuery.of(context).size.height * 0.4)),
      crossAxisCount: 2,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      //generacion de libros en base a el tamaño de _topBooks contenedor de los libros
      children: List.generate(
        longitud,
        (index) {
          //generacion de libros
          return Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: [
                new Expanded(
                  //generacion de titulo de libros
                  child: Text(
                    titulo,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                //generacion de portadas
                //contenedoresLibros(index),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Image.network(
                          fotoPerfil, //Imagen de portada
                          fit: BoxFit.cover,
                        ),
                      ),
                      flex: 3,
                    ),
                    new Expanded(
                      //generacion de titulo de libros
                      child: Text(
                        nombreUs,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      flex: 7,
                    ),
                  ],
                ),
                new Expanded(
                  //generacion de titulo de libros
                  child: Text(
                    (estrellas(calificacion)),
                    style: new TextStyle(
                      fontSize: 15,
                      letterSpacing: 2.0,
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

  Future<Resena> obtenerListado() async {
    // return ["g1 ", "g2", "g3", "g4", "g4"];
  }
}
