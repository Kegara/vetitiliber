import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'dart:math';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'GenreSPage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class genero {
  final String id;
  final String nombre;

  genero({
    this.id,
    this.nombre,
  });

  factory genero.fromJson(Map<String, dynamic> json) {
    print("genero.fromJson json: $json");
    return new genero(
      id: (json['id']).toString(),
      nombre: json['nombre'],
    );
  }
}

class generosList {
  final List<genero> generos;

  generosList({
    this.generos,
  });

  factory generosList.fromJson(List<dynamic> parsedJson) {
    List<genero> generos = new List<genero>();
    generos = parsedJson.map((e) => genero.fromJson(e)).toList();
    print("generos[1].id: ${generos[1].id}");
    print("generos[1].nombre: ${generos[1].nombre}");
    return new generosList(
      generos: generos,
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  final sController = TextEditingController();
  //lista de libros en el genero

  //lista de generos
  generosList _genres;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSearch;
  //array que contrendra todos los widgets
  var pwdWidgets = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //llamada al menu lateral y appbar
      drawer: MenuLateral(),
      appBar: AppBar1("MY REVIEW", context),
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
    //se itera el array y por cada item se agrega un genero
    for (genero gen in _genres.generos) {
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

  //funcion que se activa al cambiar el genero
  void changedDropDownItem(String selectedGenre) {
    //actualiza el estado y pone en la variable _currentSearch el genero seleccionado
    print("Selected genre $selectedGenre, we are going to refresh the UI");
    setState(() {
      _currentSearch = selectedGenre;
      creadorSecciones();
    });
  }

  //formato del libro para generos populares
  Widget contenedoresLibros(int nContenedor) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [new BoxShadow(blurRadius: 0.0)],
      ),
      child: InkWell(
        onTap: () {
          print("Container $nContenedor was tapped");
        },
      ),
    );
  }

  //contenedor de seccion de generos populares
  Widget newSection(String sectionName, int limit, int idGen) {
    //se genera una lista con los libros de la seccion
    List _books2 = llenadoLibros(idGen, limit);
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
              itemCount: _books2.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                //contenedor con imagen de libro
                return Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    children: <Widget>[
                      //se crea el objeto portada libro
                      contenedoresLibros(index),
                      new Expanded(
                        //titulo del libro
                        child: Text(
                          _books2[index],
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          //Boton para ver mas titulos en el genero
          TextButton(
            child: Text(
              'Ver mas',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              //se cambia la seccion actual
              changedDropDownItem(sectionName);
            },
          ),
        ],
      ),
    );
  }

  //funcion que llenara la lista de los generos disponibles
  Future<generosList> llenadoGeneros() async {
    final _urlGen =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/generos.php";
    generosList genList;
    try {
      print("print: llenadoGeneros()");
      final response = await get(Uri.parse(_urlGen));
      if (response.body.contains("Fallo la conexion")) {
        print('Conexion fallida.');
        // showAlertDialog(context, 'Conexion fallida.');
      } else {
        print("response.body: ${response.body}");
        final json = jsonDecode(response.body);
        print("json.runtimeType: ${json.runtimeType}");
        print("json: $json");
        genList = new generosList.fromJson(json);
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

  //funcion que llenara la lista de los libros en un genero
  List llenadoLibros(idGen, limit) {
    var random = new Random();
    switch (random.nextInt(3)) {
      case 1:
        return [
          "El Libro con el Titulo mas Largo del Mundo ",
          "g2",
          "g3",
          "g4",
          "g1 ",
          "g2",
          "g3",
          "g4",
          "g1 ",
          "g2",
          "g3",
          "g4"
        ];
        break;
      case 2:
        return [
          "El Libro con el Titulo mas Largo del Mundo ",
          "g6",
          "g7",
          "g8",
          "g5 ",
          "g6",
          "g7",
          "g8"
        ];
        break;
      case 3:
        return [
          "El Libro con el Titulo mas Largo del Mundo ",
          "g10",
          "g11",
          "g12",
          "g5 ",
          "g6",
          "g7",
          "g8"
        ];
        break;
      case 4:
        return [
          "El Libro con el Titulo mas Largo del Mundo ",
          "g14",
          "g15",
          "g16",
          "g13 ",
          "g14",
          "g15",
          "g16"
        ];
        break;
      case 5:
        return [
          "El Libro con el Titulo mas Largo del Mundo ",
          "g18",
          "g19",
          "g20",
          "g17 ",
          "g18",
          "g19",
          "g20"
        ];
        break;
      case 6:
        return [
          "El Libro con el Titulo mas Largo del Mundo ",
          "g22",
          "g23",
          "g24",
          "g21 ",
          "g22",
          "g23",
          "g24"
        ];
        break;
      default:
        return [
          "El Libro con el Titulo mas Largo del Mundo ",
          "g26",
          "g27",
          "g28",
          "g25 ",
          "g26",
          "g27",
          "g28"
        ];
        break;
    }
  }

  //funcion que actualiza la busqueda actual de generos
  void creadorSecciones() {
    //inicializamos el array de widgets
    pwdWidgets = <Widget>[];
    print(_currentSearch);

    //si la opciones "5 generos pupulares" o es null
    //pone el formato generos populares sino pone el otro formato de un solo genero
    if (_currentSearch == "Los 5 Generos mas Populares" ||
        _currentSearch == null) {
      print("(1)_genres.generos: $_genres.generos");
      int _counter = 1;
      for (genero gen in _genres.generos) {
        //se itera cada genero en la lista de genros se le pasa
        //se pasa por parametro el genero que se pondra y el limite de libros
        pwdWidgets.add(
          newSection(gen.nombre, 5, int.parse(gen.id)),
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
            child: detalleSeccion(_currentSearch, 5),
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

  Widget detalleSeccion(String sectionName, int limit) {
    //se llenan los libros de la seccion
    List _books = llenadoLibros(sectionName, limit);
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
        _books.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: [
                //se genera un contenedor
                contenedoresLibrosD(index),
                new Expanded(
                  //titulo del libro
                  child: Container(
                    child: Text(
                      _books[index],
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

  Widget contenedoresLibrosD(int nContenedor) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.4),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          //Ruta de la imagen
          image: NetworkImage(
            "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw",
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
          print("Container $nContenedor was tapped");
        },
      ),
    );
  }
}
