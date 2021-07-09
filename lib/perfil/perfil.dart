import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';
import 'package:vetitiliber/libro/librore.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'PerfilPage';
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(
          title: Text("MY REVIEW"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            )
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
                    color: Colors.blueAccent)),
            Image.asset(
              'assets/imagenes/login/LOGO2.png', //Imagen del usuario
              fit: BoxFit.cover,
            ),
            new Text("\nSeguidores:\n", //Insertar cantidad de seguidores aquí
                style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                    color: Colors.blueAccent)),
            new Expanded(
                //Aquí empieza el listado de acciones
                child: ListView(children: <Widget>[
              Divider(),
              new ListTile(
                title: Text("Reviews"), //Agregar la cantidad de reviews aquí
                onTap: () {
                  //Aquí ira la función que lleve a ver sus reviews
                  Navigator.of(context).pushNamed(ListadolibroPage.id);
                },
              ),
              Divider(),
              new ListTile(
                title:
                    Text("Favoritos"), //Agregar la cantidad de favoritos aquí
                onTap: () {
                  //Aquí ira la función que lleve a ver sus Favoritos
                },
              ),
              Divider(),
              new ListTile(
                title: Text("Leídos"), //Agregar la cantidad de leidos aquí
                onTap: () {
                  //Aquí ira la función que lleve a ver sus Leídos
                },
              ),
              Divider(),
              new ListTile(
                title: Text("Leyendo"), //Agregar la cantidad de leyendo aquí
                onTap: () {
                  //Aquí ira la función que lleve a ver sus Leyendo
                },
              ),
              Divider(),
              new ListTile(
                title:
                    Text("Pendientes"), //Agregar la cantidad de pendiente aquí
                onTap: () {
                  //Aquí ira la función que lleve a ver sus Pndientes
                },
              ),
              Divider(),
            ]))
          ],
        )));
  }
}
