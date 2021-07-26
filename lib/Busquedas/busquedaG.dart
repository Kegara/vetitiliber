import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
// ignore: unused_import
import 'dart:math';

import 'package:vetitiliber/libro/detallelibro.dart';
import 'package:vetitiliber/perfil/perfil.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'GenreSPage';
  @override
  _SearchPageState createState() => _SearchPageState();
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

class Genero {
  final int id;
  final String nombre;

  Genero({
    this.id,
    this.nombre,
  });

  factory Genero.fromJson(Map<String, dynamic> json) {
    print("Genero.fromJson json: $json");
    return new Genero(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
}

class GenerosList {
  final List<Genero> generos;

  GenerosList({
    this.generos,
  });

  factory GenerosList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Genero> generos = new List<Genero>();
    generos = parsedJson.map((e) => Genero.fromJson(e)).toList();
    print("generos[1].id: ${generos[1].id}");
    print("generos[1].nombre: ${generos[1].nombre}");
    return new GenerosList(
      generos: generos,
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  final sController = TextEditingController();
  //lista de libros en el Genero

  //lista de generos
  GenerosList _genres;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSearch;
  //array que contrendra todos los widgets
  var pwdWidgets = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //llamada al menu lateral y appbar
      drawer: MenuLateral(),
      appBar: appBar1("Busqueda por Genero", context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Texto de titulo
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text("Busqueda por generos"),
            ),
            //Contenedor con el dropdownmenu
            Container(
              child: new DropdownButton(
                icon: const Icon(Icons.filter_list_alt),
                value: _currentSearch,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
            ),
            // Columna que contiene los widgets
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: pwdWidgets,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //llenamos la lista con los valores de los generos existentes
  Future<List<DropdownMenuItem<String>>> getDropDownMenuItems() async {
    List<DropdownMenuItem<String>> items = [];
    //se llena la lista de los generos
    _genres = await llenadoGeneros();
    //llenamos la lista con los valores de los generos existentes
    //agregamos un item defaul de los 5 generos populares
    items.add(
      new DropdownMenuItem(
        value: _currentSearch,
        child: new Text(
          "Los 5 Generos mas Populares",
        ),
      ),
    );
    //se itera el array y por cada item se agrega un Genero
    for (Genero gen in _genres.generos) {
      items.add(
        new DropdownMenuItem(
          value: (gen.id).toString(),
          child: new Text(gen.nombre),
        ),
      );
    }
    return items;
  }

  //funcion que llama a la funcion de llenado de lista y
  //pone el primer valor de la lista en la busqueda actual
  void initState() {
    // _dropDownMenuItems = getDropDownMenuItems();
    getDropDownMenuItems().then((value) {
      setState(() {
        _dropDownMenuItems = value;
        _currentSearch = _dropDownMenuItems[0].value;
        creadorSecciones();
        print("yataaa");
      });
    });
    super.initState();
  }

  //funcion que se activa al cambiar el Genero
  void changedDropDownItem(String selectedGenre) {
    //actualiza el estado y pone en la variable _currentSearch el Genero seleccionado
    print("Selected genre $selectedGenre, we are going to refresh the UI");
    setState(() {
      _currentSearch = selectedGenre;
      creadorSecciones();
    });
  }

  //formato del libro para generos populares
  Widget contenedoresLibros(int idLibro, String portada) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            portada,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [new BoxShadow(blurRadius: 0.0)],
      ),
      child: InkWell(
        onTap: () {
          int idUs2 = 0;
          getUsuarioId().then((value) {
            setState(() {
              idUs2 = int.parse(value);
            });
          });
          print("Container $idLibro was tapped $idUs2");
            var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
            new DetalibroPage(idUser: idUs2, idLibro: idLibro),
          );
          Navigator.of(context).push(route);          
          print("Container $idLibro was tapped");
        },
      ),
    );
  }

  //contenedor de seccion de generos populares
  Future<Widget> newSection(String sectionName, int limit, int idGen) async {
    //se genera una lista con los libros de la seccion
    LibrosList _books2 = await llenadoLibros(idGen, limit);
    print("_books2: $_books2");
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Column(
        children: [
          //titulo de seccion
          Text(sectionName),
          //contenedor de libros de seccion
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              //se cuenta cuanos items se tienen en la seccion
              itemCount: _books2.libros.length,
              itemBuilder: (BuildContext context, int index) {
                //contenedor con imagen de libro
                return Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    children: <Widget>[
                      //se crea el objeto portada libro
                      contenedoresLibros(
                        _books2.libros[index].id,
                        _books2.libros[index].portada,
                      ),
                      new Expanded(
                        //titulo del libro
                        child: Text(
                          _books2.libros[index].titulo,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          //Boton para ver mas titulos en el Genero
          TextButton(
            child: Text(
              'Ver mas',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              //se cambia la seccion actual
              changedDropDownItem(idGen.toString());
            },
          ),
        ],
      ),
    );
  }

  //funcion que llenara la lista de los generos disponibles
  Future<GenerosList> llenadoGeneros() async {
    final _urlGen =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/generos.php";
    GenerosList genList;
    try {
      print("llenadoGeneros()");
      final response = await get(Uri.parse(_urlGen));
      if (response.body.contains("Fallo la conexion")) {
        print('Conexion fallida.');
        // showAlertDialog(context, 'Conexion fallida.');
      } else {
        print("response.body: ${response.body}");
        final json = jsonDecode(response.body);
        print("json.runtimeType: ${json.runtimeType}");
        print("json: $json");
        genList = new GenerosList.fromJson(json);
        print("genList.generos: ${genList.generos}");
        for (var gen in genList.generos) {
          print("for in gen.id: ${gen.id}");
          print("for in gen.nombre: ${gen.nombre}");
        }
        print("genList.generos[0].id: ${genList.generos[0].id}");
        print("genList.generos[0].nombre: ${genList.generos[0].nombre}");
      }
    } catch (err) {
      print("err: $err");
    }
    return genList;
    // return [
    //   {
    //     "id": 1,
    //     "nombre": "Romance",
    //   },
    //   {
    //     "id": 2,
    //     "nombre": "Comedia",
    //   },
    //   {
    //     "id": 3,
    //     "nombre": "Terror",
    //   },
    //   {
    //     "id": 4,
    //     "nombre": "Historia",
    //   },
    //   {
    //     "id": 5,
    //     "nombre": "Suspenso",
    //   },
    // ];
  }

  //funcion que llenara la lista de los libros en un Genero
  Future<LibrosList> llenadoLibros(idGen, limit) async {
    final _urlLibros =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/librosGenero.php";
    LibrosList _auxLibro;
    try {
      print("(llenadoLibros) entra al try");
      final response = await post(
        Uri.parse(_urlLibros),
        body: {
          "idGenero": idGen.toString(),
          "limite": limit.toString(),
        },
      );
      print("(llenadoLibros) response.body: ${response.body}");
      final json = jsonDecode(response.body);
      print("json: $json");
      _auxLibro = new LibrosList.fromJson(json);
      print("(1)_auxLibro: $_auxLibro");
    } catch (err) {
      print("(llenadoLibros) err: $err");
    }
    print("(2)_auxLibro: $_auxLibro");
    return _auxLibro;
    // var random = new Random();
    // switch (random.nextInt(3)) {
    //   case 1:
    //     return [
    //       "El Libro con el Titulo mas Largo del Mundo ",
    //       "g2",
    //       "g3",
    //       "g4",
    //       "g1 ",
    //       "g2",
    //       "g3",
    //       "g4",
    //       "g1 ",
    //       "g2",
    //       "g3",
    //       "g4"
    //     ];
    //     break;
    //   case 2:
    //     return [
    //       "El Libro con el Titulo mas Largo del Mundo ",
    //       "g6",
    //       "g7",
    //       "g8",
    //       "g5 ",
    //       "g6",
    //       "g7",
    //       "g8"
    //     ];
    //     break;
    //   case 3:
    //     return [
    //       "El Libro con el Titulo mas Largo del Mundo ",
    //       "g10",
    //       "g11",
    //       "g12",
    //       "g5 ",
    //       "g6",
    //       "g7",
    //       "g8"
    //     ];
    //     break;
    //   case 4:
    //     return [
    //       "El Libro con el Titulo mas Largo del Mundo ",
    //       "g14",
    //       "g15",
    //       "g16",
    //       "g13 ",
    //       "g14",
    //       "g15",
    //       "g16"
    //     ];
    //     break;
    //   case 5:
    //     return [
    //       "El Libro con el Titulo mas Largo del Mundo ",
    //       "g18",
    //       "g19",
    //       "g20",
    //       "g17 ",
    //       "g18",
    //       "g19",
    //       "g20"
    //     ];
    //     break;
    //   case 6:
    //     return [
    //       "El Libro con el Titulo mas Largo del Mundo ",
    //       "g22",
    //       "g23",
    //       "g24",
    //       "g21 ",
    //       "g22",
    //       "g23",
    //       "g24"
    //     ];
    //     break;
    //   default:
    //     return [
    //       "El Libro con el Titulo mas Largo del Mundo ",
    //       "g26",
    //       "g27",
    //       "g28",
    //       "g25 ",
    //       "g26",
    //       "g27",
    //       "g28"
    //     ];
    //     break;
    // }
  }

  Future<GenerosList> getPopularGenres() async {
    final _urlPopGens =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/generosPopulares.php";
    GenerosList _genList;
    try {
      print("getPopularGenres()");
      final response = await get(Uri.parse(_urlPopGens));
      print("response.body: ${response.body}");
      final json = jsonDecode(response.body);
      print("json: $json");
      _genList = new GenerosList.fromJson(json);
    } catch (err) {
      print("getPopularGenres() err: $err");
    }
    return _genList;
  }

  //funcion que actualiza la busqueda actual de generos
  void creadorSecciones() async {
    //inicializamos el array de widgets
    GenerosList _popularGenres = await getPopularGenres();
    pwdWidgets = <Widget>[];
    print("(creadorSecciones) _currentSearch: $_currentSearch");

    //si la opciones "5 generos pupulares" o es null
    //pone el formato generos populares sino pone el otro formato de un solo Genero
    if (_currentSearch == "Los 5 Generos mas Populares" ||
        _currentSearch == null) {
      print("(1)_popularGenres.generos: ${_popularGenres.generos}");
      int _counter = 1;
      for (Genero gen in _popularGenres.generos) {
        //se itera cada Genero en la lista de genros se le pasa
        //se pasa por parametro el Genero que se pondra y el limite de libros
        pwdWidgets.add(
          await newSection(gen.nombre, 5, gen.id),
        );
        if (_counter != 5) {
          _counter++;
        } else {
          break;
        }
      }
    } else {
      pwdWidgets.add(
        new SizedBox(
          height: (MediaQuery.of(context).size.height * 0.8),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: await detalleSeccion(_currentSearch, 0),
          ),
        ),
      );
    }
    pwdWidgets.add(
      new Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[600],
        width: 48.0,
        height: 48.0,
      ),
    );
    setState(() {});
  }

  Future<Widget> detalleSeccion(String sectionName, int limit) async {
    //se llenan los libros de la seccion
    LibrosList _books = await llenadoLibros(sectionName, limit);
    setState(() {});
    return GridView.count(
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
                //se genera un contenedor
                contenedoresLibrosD(
                    _books.libros[index].id, _books.libros[index].portada),
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
          Navigator.of(context).push(route);        },
      ),
    );
  }
}
