import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:vetitiliber/login/bodyR.dart';
import 'package:vetitiliber/inicio/inicio.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {  

  //Creamos 2 controladores de texto para usuario y contraseña
  final usuarioController = TextEditingController();
  final passController = TextEditingController();

  //Formkey sirve para revisar que todas las validaciones se cumplan
  final _formKey = GlobalKey<FormState>();

  //Creamos una variable en donde guardaremos la dirección url en donde se encuentra nuestra consulta PHP
  final url = "https://myreviewvl.000webhostapp.com/BD/Usuario/usuarios.php";

  //Metodo para enviar el usuario y contraseña al servidor
  void postUserPass(user, pass) async{
    try{
      final response = await post(Uri.parse(url), body: {
        "nombre": user,
        "contrasena": pass
      });
      print(response.body);
    }catch(err){}
  }

  //Metodo para obtener usuario y contraseña de la bd
  void getUserPass() async{
    try{
      final respuesta = await get(Uri.parse(url));
      if(respuesta.body != null){
        print("Login correcto");
        Navigator.of(context).pushNamed(StartPage.id);
      }else{
        print("Usuario/contraseña incorrecto");
      }
    }catch(err){}
  }
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                child: Text('My Review',
                    style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                        color: Colors.blueAccent)),
              ),
              Image.asset(
                'assets/imagenes/login/LOGO2.png',
                height: size.height * 0.25,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 30.0, left: 20.0),
                        child: TextFormField(
                          //Agregamos al textFormField el TextEditingController que nos servira para obtener el valor escrito
                          controller: usuarioController,
                          autofocus: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: 'Usuario',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 30.0, left: 20.0),
                        child: TextFormField(
                          controller: passController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          autofocus: true,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(_obscureText == true
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: _toggle,
                                ),
                                Padding
                                (
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                  (Icons.lock),
                                 )
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Contraseña',
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextButton(
                            child: Text(
                              'Ingresar',
                              style: new TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5.0,
                                  color: Colors.blueAccent),
                            ),
                            onPressed: () {
                              print("ingreso a la app");
                              _ingreso(context, _formKey);
                            },
                          )),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextButton(
                    child: Text(
                      '¿Nuevo en MyReview?',
                      style: new TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.0,
                          color: Colors.blueAccent),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterPage.id);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  //funcion que se ejecuta en el boton de ingreso que pide como parametro el usuario y la contraseña
  void _ingreso(BuildContext context, GlobalKey<FormState> formKey) {

    String user = usuarioController.text;
    String pass = passController.text;
    
    //valida el formkey y le pone el estado de valido y redirige al login
    if (formKey.currentState.validate()) {
        
      print("regreso al login" + user + pass);

      formKey.currentState.save();

      //Envia el usuario y contraseña capturados al servidor
      postUserPass(user, pass);
      //Revisa si la consulta encontro coincidencias y si es asi accede
      getUserPass();



      //Navigator.of(context).pushNamed(StartPage.id);

    }
  }

}
