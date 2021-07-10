import 'package:flutter/material.dart';
import 'package:vetitiliber/login/bodyL.dart';
import 'package:vetitiliber/login/bodyR.dart';
import 'package:vetitiliber/inicio/inicio.dart';
import 'package:vetitiliber/perfil/perfil.dart';
import 'package:vetitiliber/Busquedas/busquedaG.dart';
import 'package:vetitiliber/Busquedas/busquedaU.dart';
import 'package:vetitiliber/Busquedas/busquedaL.dart';
import 'package:vetitiliber/perfil/confiperfil.dart';
import 'package:vetitiliber/libro/detallelibro.dart';
import 'package:vetitiliber/libro/leerPdf.dart';
import 'package:vetitiliber/libro/librore.dart';
import 'package:vetitiliber/libro/librofav.dart';
import 'package:vetitiliber/libro/librolei.dart';
import 'package:vetitiliber/libro/libroley.dart';
import 'package:vetitiliber/libro/libropen.dart';
import 'package:vetitiliber/libro/answer.dart';

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
      initialRoute: StartPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        StartPage.id: (context) => StartPage(),
        PerfilPage.id: (context) => PerfilPage(),
        SearchPage.id: (context) => SearchPage(),
        SearchPageL.id: (context) => SearchPageL(),
        SearchPageU.id: (context) => SearchPageU(),
        ConfiperfilPage.id: (context) => ConfiperfilPage(),
        DetalibroPage.id: (context) => DetalibroPage(),
        LeerPDF.id: (context) => LeerPDF(),
        ListadolibroPage.id: (context) => ListadolibroPage(),
        ListadofavPage.id: (context) => ListadofavPage(),
        ListadoleiPage.id: (context) => ListadoleiPage(),
        ListadoleyPage.id: (context) => ListadoleyPage(),
        ListadopenPage.id: (context) => ListadopenPage(),
        AnswerPage.id: (context) => AnswerPage(),
      },
    );
  }
}
