
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User{
  final String name, contrasena;

  User(this.name, this.contrasena);
}

class DataFromAPI extends StatefulWidget{
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
  
}

class _DataFromAPIState extends State<DataFromAPI>{

  getUserData() async{
    var response = await http.get(Uri.https('myreviewvl.000webhostapp.com', 'BD/Usuario/usuarios.php'));

    var jsonData = jsonDecode(response.body);

    List<User> users = [];

    for(var u in jsonData){
      User user = User(u["name"],u["contrasena"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}