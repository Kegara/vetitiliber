import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'dart:math';

class SearchPageL extends StatefulWidget {
  SearchPageL({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'BookSPage';
  @override
  _SearchPageLState createState() => _SearchPageLState();
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
  List llenadoLibros(String txtabuscar) {
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

  void gridlibros(String busquedaS) {
    //se llenan los libros de la seccion
    List _books = llenadoLibros(busquedaS);
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
        _books.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                ),
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
