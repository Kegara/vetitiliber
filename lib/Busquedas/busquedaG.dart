import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'dart:math';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'GenreSPage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final sController = TextEditingController();
  //lista de libros en el genero

  //lista de generos
  List _genres = [];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSearch;
  //array que contrendra todos los widgets
  var pwdWidgets = <Widget>[];

  @override
  Widget build(BuildContext context) {
    creadorSecciones();
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
              ))),
            ],
          ),
        ));
  }

  //llenamos la lista con los valores de los generos existentes
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    //se llena la lista de los generos
    _genres = llenadoGeneros();
    //llenamos la lista con los valores de los generos existentes
    //agregamos un item defaul de los 5 generos populares
    items.add(new DropdownMenuItem(
        value: _currentSearch,
        child: new Text(
          "5 generos pupulares",
        )));
    //se itera el array y por cada item se agrega un genero
    for (String genero in _genres) {
      items.add(new DropdownMenuItem(value: genero, child: new Text(genero)));
    }
    return items;
  }

  //funcion que llama a la funcion de llenado de lista y
  //pone el primer valor de la lista en la busqueda actual
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentSearch = _dropDownMenuItems[0].value;
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
                    "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [new BoxShadow(blurRadius: 0.0)]),
        child: InkWell(
          onTap: () {
            print("Container $nContenedor was tapped");
          },
        ));
  }

  //contenedor de seccion de generos populares
  Widget newSection(String sectionName, int limit) {
    //se genera una lista con los libros de la seccion
    List _books2 = llenadoLibros(sectionName, 5);
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(children: [
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
                  itemBuilder: (BuildContext context, int index) {
                    //contenedor con imagen de libro
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(children: <Widget>[
                        //se crea el objeto portada libro
                        contenedoresLibros(index),
                        new Expanded(
                            //titulo del libro
                            child: Text(
                          _books2[index],
                          overflow: TextOverflow.visible,
                        ))
                      ]),
                    );
                  })),
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
        ]));
  }

  //funcion que llenara la lista de los generos disponibles
  List llenadoGeneros() {
    return ["Romance ", "Comedia", "Terror", "Historia"];
  }

  //funcion que llenara la lista de los libros en un genero
  List llenadoLibros(String sectionName, limit) {
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
        return ["El Libro con el Titulo mas Largo del Mundo ", "g6", "g7", "g8", "g5 ", "g6", "g7", "g8"];
        break;
      case 3:
        return ["El Libro con el Titulo mas Largo del Mundo ", "g10", "g11", "g12", "g5 ", "g6", "g7", "g8"];
        break;
      case 4:
        return ["El Libro con el Titulo mas Largo del Mundo ", "g14", "g15", "g16", "g13 ", "g14", "g15", "g16"];
        break;
      case 5:
        return ["El Libro con el Titulo mas Largo del Mundo ", "g18", "g19", "g20", "g17 ", "g18", "g19", "g20"];
        break;
      case 6:
        return ["El Libro con el Titulo mas Largo del Mundo ", "g22", "g23", "g24", "g21 ", "g22", "g23", "g24"];
        break;
      default:
        return ["El Libro con el Titulo mas Largo del Mundo ", "g26", "g27", "g28", "g25 ", "g26", "g27", "g28"];
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
    if (_currentSearch == "5 generos pupulares" || _currentSearch == null) {
      for (String genero in _genres) {
        //se itera cada genero en la lista de genros se le pasa
        //se pasa por parametro el genero que se pondra y el limite de libros
        pwdWidgets.add(newSection(genero, 5));
      }
    } else {
      pwdWidgets.add(new SizedBox(
          height: (MediaQuery.of(context).size.height * 0.8),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: detalleSeccion(_currentSearch, 5))));
    }
    pwdWidgets.add(new Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.amber[600],
      width: 48.0,
      height: 48.0,
    ));
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
      children: List.generate(_books.length, (index) {
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
                )))
              ],
            ));
      }),
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
                    "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [new BoxShadow(blurRadius: 0.0)]),
        //widget que genera el evento de onTap
        child: InkWell(onTap: () {
          print("Container $nContenedor was tapped");
        }));
  }
}
