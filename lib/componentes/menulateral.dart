import 'package:flutter/material.dart';
import 'package:vetitiliber/login/bodyL.dart';
import 'package:vetitiliber/perfil/perfil.dart';
import 'package:vetitiliber/inicio/inicio.dart';
import 'package:vetitiliber/Busquedas/busquedaG.dart';
import 'package:vetitiliber/perfil/confiperfil.dart';
import 'package:vetitiliber/Busquedas/busquedaU.dart';
import 'package:vetitiliber/Busquedas/busquedaL.dart';
import 'package:vetitiliber/libro/detallelibro.dart';
import 'package:vetitiliber/elementos/aboutus.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("MyReview"),
            accountEmail: Text("quantumspeed@gmail.com"),
          ),
          Ink(
            child: new ListTile(
              title: Text("Inicio"),
              onTap: () {
                Navigator.of(context).pushNamed(StartPage.id);
              },
            ),
          ),
          Divider(),
          new ListTile(
            title: Text("PDF VIEWER"),
            onTap: () {},
          ),
          Divider(),
          new ListTile(
            title: Text("Perfil"),
            onTap: () {
              Navigator.of(context).pushNamed(PerfilPage.id);
            },
          ),
          Divider(),
          new ListTile(
            title: Text("Configuración"),
            onTap: () {
              Navigator.of(context).pushNamed(ConfiperfilPage.id);
            },
          ),
          Divider(),
          new ListTile(
            title: Text("Busqueda"),
          ),
          new ListTile(
            title: Text("Genero"),
            onTap: () {
              Navigator.of(context).pushNamed(SearchPage.id);
            },
            leading: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.center,
              ),
            ),
          ),
          new ListTile(
            title: Text("Libro"),
            onTap: () {
              Navigator.of(context).pushNamed(SearchPageL.id);
            },
            leading: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.center,
              ),
            ),
          ),
          new ListTile(
            title: Text("Usuario"),
            enableFeedback: true,
            onTap: () {
              Navigator.of(context).pushNamed(SearchPageU.id);
            },
            leading: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.center,
              ),
            ),
          ),
          Divider(),
          new ListTile(
            title: Text("Ayuda"),
            onTap: () {},
          ),
          Divider(),
          new ListTile(
            title: Text("About us"),
            onTap: () {
              Navigator.of(context).pushNamed(AboutusPage.id);
            },
          ),
          Divider(),
          new ListTile(
            title: Text("Cerrrar sesión"),
            onTap: () {
              Navigator.of(context).pushNamed(LoginPage.id);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

appBar1(String x, BuildContext context) {
  return new AppBar(
    title: Text(x),
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
  );
}
