import 'package:flutter/material.dart';
import 'package:vetitiliber/login/bodyL.dart';
import 'package:vetitiliber/perfil/perfil.dart';
import 'package:vetitiliber/inicio/inicio.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilPage()),
              );
            },
          ),
          Divider(),
          new ListTile(
            title: Text("Configuración"),
            onTap: () {},
          ),
          Divider(),
          new ListTile(
            title: Text("Busqueda"),
          ),
          new ListTile(
            title: Text("Libro"),
            onTap: () {},
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
            onTap: () {},
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
            onTap: () {},
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
