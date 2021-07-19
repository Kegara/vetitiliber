import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class SearchPageU extends StatefulWidget {
  SearchPageU({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'UserSPage';
  @override
  _SearchPageUState createState() => _SearchPageUState();
}

class _SearchPageUState extends State<SearchPageU> {
  //Creamos controlador de texto para el texto de busqueda
  final txtBusquedaController = TextEditingController();
  //Formkey sirve para revisar que todas las validaciones se cumplan
  final _formKeySU = GlobalKey<FormState>();
  //lista de libros en el genero
  String _currentSearch;
  //lista de generos
  List _usuarios = [];
  Widget listaUsuarios;
  //array que contrendra todos los widgets
  var pwdWidgets = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //llamada al menu lateral y appbar
      drawer: MenuLateral(),
      appBar: appBar1("Busqueda de usuarios", context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Texto de titulo
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text("Busqueda por usuarios"),
            ),
            Form(
              key: _formKeySU,
              child: TextFormField(
                controller: txtBusquedaController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
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
                  labelText: 'Usuario a buscar',
                ),
              ),
            ),
            // Columna que contiene los widgets
            Expanded(
              child: listaUsuarios,
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    //ponemos en el widget lista usuarios el texto de inicio
    listaUsuarios = Text("Busca a un usuario por su nombre!");
    super.initState();
  }

  //llenamos erray que llenara la lista de los usuarios
  List llenadoarrayusuarios() {
    return ["kevin", "paulos", "isra", "alexis"];
  }

  void llenadolistaUsuarios() {
    //llenamos el array de los usuarios
    _usuarios = llenadoarrayusuarios();
    listaUsuarios = ListView.builder(
      itemCount: _usuarios.length,
      itemBuilder: (context, position) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                //funcion que se ejecuta en al interactuar con el cuadro
                print('Console Message Using Print $position');
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(
                            //url de la imagen de perfil
                            "https://www.svgrepo.com/show/46001/user.svg",
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        boxShadow: [new BoxShadow(blurRadius: 0.0)],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        //nombre del usuario
                        _usuarios[position],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void busqueda() {
    //validamos el cuadro de texto
    if (_formKeySU.currentState.validate()) {
      //si la busqueda es diferente a la busqueda actual se actualiza y se llena la lista de usuarios de acuerdo a la busqueda
      if (txtBusquedaController.text != _currentSearch) {
        setState(() {
          _currentSearch = txtBusquedaController.text;
          llenadolistaUsuarios();
        });
      }
    }
  }
}
