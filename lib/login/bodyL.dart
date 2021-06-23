import 'package:flutter/material.dart';
import 'package:vetitiliber/login/bodyR.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 30.0, left: 20.0),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 30.0, left: 20.0),
                child: TextField(
                  autofocus: true,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.lock),
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
                      Navigator.of(context).pushNamed(RegisterPage.id);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
