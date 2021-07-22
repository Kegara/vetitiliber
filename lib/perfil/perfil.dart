import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'package:vetitiliber/libro/librore.dart';
import 'package:vetitiliber/libro/librofav.dart';
import 'package:vetitiliber/libro/librolei.dart';
import 'package:vetitiliber/libro/libroley.dart';
import 'package:vetitiliber/libro/libropen.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'PerfilPage';
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class InfoUsuario {
  final String fotoPerfil;
  final int nSeguidores;
  final int nReviews;
  final int nFavoritos;
  final int nLeidos;
  final int nLeyendo;
  final int nPendientes;

  InfoUsuario({
    this.fotoPerfil,
    this.nSeguidores,
    this.nReviews,
    this.nFavoritos,
    this.nLeidos,
    this.nLeyendo,
    this.nPendientes,
  });

  factory InfoUsuario.fromJson(Map<String, dynamic> json) {
    return new InfoUsuario(
      fotoPerfil: json['fotoPerfil'],
      nSeguidores: json['nSeguidores'],
      nReviews: json['nReviews'],
      nFavoritos: json['fotoPerfil'],
      nLeidos: json['nLeidos'],
      nLeyendo: json['fotoPerfil'],
      nPendientes: json['fotoPerfil'],
    );
  }
}

Future<String> getUsuarioId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('idUsuario').toString();
}

InfoUsuario _infoUsuario;

Future<InfoUsuario> getInfoUsuario() async {
  final _url =
      "https://myreviewvl.000webhostapp.com/BD/Usuario/infoUsuario.php";
  InfoUsuario _aux;
  bool _respuestaInvalida = true;
  try {
    do {
      final response = await post(
        Uri.parse(_url),
        body: {
          "id": await getUsuarioId(),
        },
      );
      print("(getInfoUsuario) response.body: ${response.body}");
      _respuestaInvalida = (response.body == "[]");
      final json = jsonDecode(response.body);
      _aux = new InfoUsuario.fromJson(json);
    } while (_respuestaInvalida);
  } catch (err) {
    print("(getInfoUsuario) err: $err");
  }
  return _aux;
}

class _PerfilPageState extends State<PerfilPage> {
  String fotoPerfil =
      'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg';
  int nSeguidores = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("MY REVIEW"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              "Mi Perfil", //Texto inicial de la sección para ver el perfil propio
              style: new TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
                color: Colors.blueAccent,
              ),
            ),
            Image.network(
              fotoPerfil, //Imagen del usuario
              fit: BoxFit.cover,
            ),
            new Text(
              "\nSeguidores: $nSeguidores\n", //Insertar cantidad de seguidores aquí
              style: new TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
                color: Colors.blueAccent,
              ),
            ),
            new Expanded(
              //Aquí empieza el listado de acciones
              child: ListView(
                children: <Widget>[
                  Divider(),
                  new ListTile(
                    title:
                        Text("Reviews"), //Agregar la cantidad de reviews aquí
                    onTap: () {
                      //Aquí ira la función que lleve a ver sus reviews
                      Navigator.of(context).pushNamed(ListadolibroPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: Text(
                        "Favoritos"), //Agregar la cantidad de favoritos aquí
                    onTap: () {
                      //Aquí ira la función que lleve a ver sus Favoritos
                      Navigator.of(context).pushNamed(ListadofavPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: Text("Leídos"), //Agregar la cantidad de leidos aquí
                    onTap: () {
                      //Aquí ira la función que lleve a ver sus Leídos
                      Navigator.of(context).pushNamed(ListadoleiPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title:
                        Text("Leyendo"), //Agregar la cantidad de leyendo aquí
                    onTap: () {
                      //Aquí ira la función que lleve a ver sus Leyendo
                      Navigator.of(context).pushNamed(ListadoleyPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: Text(
                        "Pendientes"), //Agregar la cantidad de pendiente aquí
                    onTap: () {
                      //Aquí ira la función que lleve a ver sus Pndientes
                      Navigator.of(context).pushNamed(ListadopenPage.id);
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
