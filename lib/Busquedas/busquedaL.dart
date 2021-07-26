import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'package:vetitiliber/libro/detallelibro.dart';
import 'package:vetitiliber/perfil/perfil.dart';

class SearchPageL extends StatefulWidget {
  SearchPageL({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'BookSPage';
  @override
  _SearchPageLState createState() => _SearchPageLState();
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

class _SearchPageLState extends State<SearchPageL> {
  //Creamos controlador de texto para el texto de busqueda
  final txtBusquedaController = TextEditingController();
  //Formkey sirve para revisar que todas las validaciones se cumplan
  final _formKeySU = GlobalKey<FormState>();
  //busqueda actual
  String _currentSearch;
  //lista de libros
  Widget listaLibros;
  //array que contrendra todos los widgets
  var pwdWidgets = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //llamada al menu lateral y appbar
      drawer: MenuLateral(),
      appBar: appBar1("Busqueda de libros", context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Texto de titulo
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text("Busqueda de libros"),
            ),
            //Form con busqueda
            Form(
              key: _formKeySU,
              child: TextFormField(
                controller: txtBusquedaController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor introduzca el nombre del libro que quiere buscar';
                  }
                  return null;
                },
                autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => {busqueda()},
                      ),
                    ],
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Libro a buscar',
                ),
              ),
            ),
            // Columna que contiene los widgets
            Expanded(
              child: new SizedBox(
                height: (MediaQuery.of(context).size.height * 0.8),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: listaLibros,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    //ponemos en el widget lista usuarios el texto de inicio
    listaLibros = Text("Busca a un libro por su nombre!");
    super.initState();
  }

  //llenamos erray que llenara la lista de los usuarios
  Future<LibrosList> llenadoLibros(String txtabuscar) async {
    final _urlLibros =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/buquedaLibro.php";
    LibrosList _auxLibro;
    try {
      final response = await post(
        Uri.parse(_urlLibros),
        body: {
          "termino": txtabuscar,
        },
      );
      print("response.body: ${response.body}");
      if (response.body == "[]") {
        // Este es el caso en el que no encuentra ningun libro con ese titulo
        print("no se encontro ningun libro con un titulo parecido");
      }
      final json = jsonDecode(response.body);
      _auxLibro = new LibrosList.fromJson(json);
    } catch (err) {
      print("(llenadoLibros) err: $err");
    }
    return _auxLibro;
  }

  void gridlibros(String busquedaS) async {
    //se llenan los libros de la seccion
    LibrosList _books = await llenadoLibros(busquedaS);
    setState(() {});
    //grid que contendra la busqueda de los libros
    listaLibros = GridView.count(
      childAspectRatio: ((MediaQuery.of(context).size.width / 2 - 40) /
          (MediaQuery.of(context).size.height * 0.4)),
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: List.generate(
        _books.libros.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                ),
                //se genera un contenedor
                contenedoresLibrosD(
                  _books.libros[index].id,
                  _books.libros[index].portada,
                ),
                new Expanded(
                  //titulo del libro
                  child: Container(
                    child: Text(
                      _books.libros[index].titulo,
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget contenedoresLibrosD(int nContenedor, String portada) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.4),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          //Ruta de la imagen
          image: NetworkImage(
            portada,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [new BoxShadow(blurRadius: 0.0)],
      ),
      //widget que genera el evento de onTap
      child: InkWell(
        onTap: () {
          int idUs2 = 0;
          getUsuarioId().then((value) {
            setState(() {
              idUs2 = int.parse(value);
            });
          });
          print("Container $nContenedor was tapped $idUs2");
            var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
            new DetalibroPage(idUser: idUs2, idLibro: nContenedor),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
  }
 Future<String> getUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario').toString();
  }
  void busqueda() {
    //validamos el cuadro de texto
    if (_formKeySU.currentState.validate()) {
      //si la busqueda es diferente a la busqueda actual se actualiza y se llena la lista de usuarios de acuerdo a la busqueda
      if (txtBusquedaController.text != _currentSearch) {
        setState(() {
          _currentSearch = txtBusquedaController.text;
          gridlibros(_currentSearch);
        });
      }
    }
  }
}
