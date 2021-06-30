import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

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
            Text("Mi Perfil",
                style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                    color: Colors.blueAccent)),
            Image.asset(
              'assets/imagenes/login/LOGO2.png',
              fit: BoxFit.cover,
            ),
            new Expanded(
                child: ListView(children: <Widget>[
              Divider(),
              new ListTile(
                title: Text("Reviews"),
                onTap: () {},
              ),
              Divider(),
              new ListTile(
                title: Text("Favoritos"),
                onTap: () {},
              ),
              Divider(),
              new ListTile(
                title: Text("Leidos"),
                onTap: () {},
              ),
              Divider(),
              new ListTile(
                title: Text("Leyendo"),
                onTap: () {},
              ),
              Divider(),
              new ListTile(
                title: Text("Pendiente"),
                onTap: () {},
              ),
              Divider(),
            ]))
          ],
        )));
  }
}
