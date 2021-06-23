import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vetitiliber/login/bodyL.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'RegisterPage';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime _dateTime;

  final cController = TextEditingController();
  final ceController = TextEditingController();
  final fechan = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _color = Colors.blueAccent;
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
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 30.0, left: 20.0),
                    child: TextFormField(
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
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: ceController,
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
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 30.0, left: 20.0),
                    child: TextFormField(
                      controller: cController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                    padding: const EdgeInsets.only(top: 1.0, bottom: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 30.0, left: 20.0),
                                child:IntrinsicWidth(
                                  
                            child: TextFormField (
                                controller: fechan,
                                
                                readOnly: true,
                                style: new TextStyle(color: _color),
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (_dateTime == null || _dateTime.toString() == '') {
                                    value = "Ingresa una fecha";
                                    return 'Please enter select a date';
                                  } else {
                                    value = DateFormat('yyyy-MM-dd')
                                        .format(_dateTime)
                                        .toString();
                                  }

                                  return null;
                                },decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                        labelText: 'Fecha de nacimiento',
                      )
                      ))
                      ),
                        ElevatedButton(
                            child: Text(
                              'Selecciona una fecha de nacimiento',
                            ),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now())
                                  .then((date) {
                                setState(() {
                                  _dateTime = date;
                                  fechan.text = DateFormat('yyyy-MM-dd')
                                      .format(_dateTime)
                                      .toString();
                                });
                              });
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                      child: Text(
                        'Registrarse',
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.blueAccent),
                      ),
                      onPressed: () {
                        _registrarse(context, _formKey, _dateTime, _color);
                      },
                    ),
                  )
                ]),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                    child: Text(
                      '¿Ya tienes una cuenta?',
                      style: new TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.0,
                          color: _color),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginPage.id);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

void _registrarse(BuildContext context, GlobalKey<FormState> formKey,
    DateTime dt, Color _color) {
  if (formKey.currentState.validate()) {
    if (dt == null) {
      _color = Colors.red;
    } else {
      _color = Colors.red;
      formKey.currentState.save();
      print("regreso al login");
      Navigator.of(context).pushNamed(LoginPage.id);
    }
  }
}
