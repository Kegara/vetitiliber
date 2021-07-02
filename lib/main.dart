import 'package:flutter/material.dart';
import 'package:vetitiliber/login/bodyL.dart';
import 'package:vetitiliber/login/bodyR.dart';
import 'package:vetitiliber/inicio/inicio.dart';
import 'package:vetitiliber/perfil/perfil.dart';
import 'package:vetitiliber/Busquedas/busquedaG.dart';
import 'package:vetitiliber/perfil/confiperfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vetitiliber',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        StartPage.id: (context) => StartPage(),
        PerfilPage.id: (context) => PerfilPage(),
        SearchPage.id: (context) => SearchPage(),
        ConfiperfilPage.id: (context) => ConfiperfilPage(),
      },
    );
  }
}
