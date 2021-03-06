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
      nSeguidores: int.parse(json['nSeguidores']),
      nReviews: int.parse(json['nReviews']),
      nFavoritos: int.parse(json['nFavoritos']),
      nLeidos: int.parse(json['nLeidos']),
      nLeyendo: int.parse(json['nLeyendo']),
      nPendientes: int.parse(json['nPendientes']),
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
  final idUs = await getUsuarioId();
  InfoUsuario _aux;
  try {
    final response = await post(
      Uri.parse(_url),
      body: {
        "id": idUs,
      },
    );
    final json = jsonDecode(response.body);
    _aux = new InfoUsuario.fromJson(json);
  } catch (err) {
    print("(getInfoUsuario) err: $err");
  }
  return _aux;
}

bool _auxBool = true;

class _PerfilPageState extends State<PerfilPage> {
  String fotoPerfil =
      'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg';
  int nSeguidores = 0;
  int nReviews = 0;
  int nFavoritos = 0;
  int nLeidos = 0;
  int nLeyendo = 0;
  int nPendientes = 0;

  @override
  Widget build(BuildContext context) {
    if (_auxBool) {
      getInfoUsuario().then((value) {
        setState(() {
          _infoUsuario = value;
          fotoPerfil = _infoUsuario.fotoPerfil;
          nSeguidores = _infoUsuario.nSeguidores;
          nReviews = _infoUsuario.nReviews;
          nFavoritos = _infoUsuario.nFavoritos;
          nLeidos = _infoUsuario.nLeidos;
          nLeyendo = _infoUsuario.nLeyendo;
          nPendientes = _infoUsuario.nPendientes;
          _auxBool = false;
          print("setState");
        });
      });
    }
    return Scaffold(
      drawer: MenuLateral(),
      appBar: appBar1("Mi perfil", context),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network(
              fotoPerfil, //Imagen del usuario
              fit: BoxFit.cover,
            ),
            new Text(
              "\nSeguidores: $nSeguidores\n", //Insertar cantidad de seguidores aqu??
              style: new TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
                color: Colors.blueAccent,
              ),
            ),
            new Expanded(
              //Aqu?? empieza el listado de acciones
              child: ListView(
                children: <Widget>[
                  Divider(),
                  new ListTile(
                    title: Text(
                      "Reviews ($nReviews)",
                    ), //Agregar la cantidad de reviews aqu??
                    onTap: () {
                      //Aqu?? ira la funci??n que lleve a ver sus reviews
                      _auxBool = true;
                      Navigator.of(context).pushNamed(ListadolibroPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: Text(
                      "Favoritos ($nFavoritos)",
                    ), //Agregar la cantidad de favoritos aqu??
                    onTap: () {
                      //Aqu?? ira la funci??n que lleve a ver sus Favoritos
                      _auxBool = true;
                      Navigator.of(context).pushNamed(ListadofavPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: Text(
                      "Le??dos ($nLeidos)",
                    ), //Agregar la cantidad de leidos aqu??
                    onTap: () {
                      //Aqu?? ira la funci??n que lleve a ver sus Le??dos
                      _auxBool = true;
                      Navigator.of(context).pushNamed(ListadoleiPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: Text(
                      "Leyendo ($nLeyendo)",
                    ), //Agregar la cantidad de leyendo aqu??
                    onTap: () {
                      //Aqu?? ira la funci??n que lleve a ver sus Leyendo
                      _auxBool = true;
                      Navigator.of(context).pushNamed(ListadoleyPage.id);
                    },
                  ),
                  Divider(),
                  new ListTile(
                    title: Text(
                      "Pendientes ($nPendientes)",
                    ), //Agregar la cantidad de pendiente aqu??
                    onTap: () {
                      //Aqu?? ira la funci??n que lleve a ver sus Pndientes
                      _auxBool = true;
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
