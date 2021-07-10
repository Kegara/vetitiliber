
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


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
      body: Center(
        child: TextButton(
          child:Text('Selecciona un PDF'),
          onPressed: (){
            
          } ,
          ),
      ),
    );
  }
  
}