import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetitiliber/libro/pdf_api.dart';
import 'package:vetitiliber/libro/readPDF.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

// ignore: camel_case_types
class LeerPDF extends StatefulWidget {
  static String id = 'leerPDF';
  final String title;
  LeerPDF({Key key, this.title}) : super(key: key);
  _leerPDF createState() => _leerPDF();
}

// ignore: camel_case_types
class _leerPDF extends State<LeerPDF> {
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: appBar1("Busqueda de libros", context),
      body: Center(
        child: TextButton(
          child: Text('Selecciona un PDF'),
          onPressed: () {
            _seleccionarPDF();
          },
        ),
      ),
    );
  }

  void _seleccionarPDF() async {
    final file = await PDFApi.pickFile();
    if (file == null) return;
    openPDF(context, file);
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}
