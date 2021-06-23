import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'RegisterPage';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime _dateTime;
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
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'Correo electronico',
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                padding: const EdgeInsets.only(top: 30.0, bottom: 5),
                child: Text('Fecha de nacimiento',
                    style: new TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                        color: Colors.blueAccent)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.0, bottom: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(_dateTime == null
                        ? ''
                        : DateFormat('yyyy-MM-dd').format(_dateTime).toString()),
                    RaisedButton(
                        child: Text('Selecciona una fecha'), onPressed: () {
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime(1900), lastDate:DateTime.now()).then((date) {
                            setState(() {
                              _dateTime=date;
                            });
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FlatButton(
                    child: Text(
                      'Registrarse',
                      style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5.0,
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
}
