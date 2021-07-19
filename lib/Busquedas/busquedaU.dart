import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:vetitiliber/Busquedas/busquedaG.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class SearchPageU extends StatefulWidget {
  SearchPageU({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'UserSPage';
  @override
  _SearchPageUState createState() => _SearchPageUState();
}

class Usuario {
  final int id;
  final String nombre;
  final String fotoPerfil;

  Usuario({
    this.id,
    this.nombre,
    this.fotoPerfil,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return new Usuario(
      id: json['id'],
      nombre: json['nombre'],
      fotoPerfil: json['fotoPerfil'],
    );
  }
}

class UsuariosList {
  final List<Usuario> usuarios;

  UsuariosList({
    this.usuarios,
  });

  factory UsuariosList.fromJson(List<dynamic> parsedJson) {
    List<Usuario> usuarios = new List<Usuario>();
    usuarios = parsedJson.map((e) => Usuario.fromJson(e)).toList();
    return UsuariosList(
      usuarios: usuarios,
    );
  }
}

class _SearchPageUState extends State<SearchPageU> {
  //Creamos controlador de texto para el texto de busqueda
  final txtBusquedaController = TextEditingController();
  //Formkey sirve para revisar que todas las validaciones se cumplan
  final _formKeySU = GlobalKey<FormState>();
  //lista de libros en el genero
  String _currentSearch;
  //lista de generos
  UsuariosList _usuarios;
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
                    return 'Por favor introduzca el nombre del usuario que quiere buscar';
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
  Future<UsuariosList> llenadoarrayusuarios(termino) async {
    final _url =
        "https://myreviewvl.000webhostapp.com/BD/Usuario/busquedaUsuario.php";
    UsuariosList _aux;
    try {
      final response = await post(
        Uri.parse(_url),
        body: {
          "termino": termino,
        },
      );
      if (response.body == "[]") {
        // Este es el caso en el que no encuentra ningun usuario con ese nombre
        print("no se encontro ningun usuario con un nombre parecido");
      }
      final json = jsonDecode(response.body);
      _aux = new UsuariosList.fromJson(json);
    } catch (err) {
      print("(llenadoarrayusuarios) err: $err");
    }
    return _aux;
    // return ["kevin", "paulos", "isra", "alexis"];
  }

  void llenadolistaUsuarios(String termino) async {
    //llenamos el array de los usuarios
    _usuarios = await llenadoarrayusuarios(termino);
    setState(() {});
    listaUsuarios = ListView.builder(
      itemCount: _usuarios.usuarios.length,
      itemBuilder: (context, position) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                //funcion que se ejecuta en al interactuar con el cuadro
                print(
                    'Console Message Using Print ${_usuarios.usuarios[position].id}');
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
                            _usuarios.usuarios[position].fotoPerfil,
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
                        _usuarios.usuarios[position].nombre,
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
          llenadolistaUsuarios(_currentSearch);
        });
      }
    }
  }
}
