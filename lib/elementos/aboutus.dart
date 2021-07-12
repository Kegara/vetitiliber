import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class AboutusPage extends StatefulWidget {
  AboutusPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'AboutusPage';
  @override
  _AboutusPage createState() => _AboutusPage();
}

class _AboutusPage extends State<AboutusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("MY REVIEW"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          )
        ],
      ),
      body: MyCustomForm(),
    );
  }
}

// Crea un Widget Form
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// el formulario.
class MyCustomFormState extends State<MyCustomForm> {
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                //Aquí empieza el listado de acciones
                child: ListView(
                  children: <Widget>[
                    Text("Desarrolladores",
                        style: new TextStyle(
                            fontSize: 30,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    Divider(),
                    //Visualización de las reseñas-------------------------------------------------------------------
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Image.asset(
                              'assets/imagenes/login/LOGO2.png', //Imagen de portada
                              fit: BoxFit.cover,
                            ),
                          ),
                          flex: 3),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text("Kevin García Ramírez\nDeveloper",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 7)
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Va toda la reseña",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 9),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 1)
                    ]),
                    Divider(),
                    Divider(),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Image.asset(
                              'assets/imagenes/login/LOGO2.png', //Imagen de portada
                              fit: BoxFit.cover,
                            ),
                          ),
                          flex: 3),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                                "Alexis Rafael Aparicio Hernández\nDeveloper",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 7)
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Va toda la reseña",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 9),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 1)
                    ]),
                    Divider(),
                    Divider(),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Image.asset(
                              'assets/imagenes/login/LOGO2.png', //Imagen de portada
                              fit: BoxFit.cover,
                            ),
                          ),
                          flex: 3),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                                "Alexis Rafael Aparicio Hernández\nDeveloper",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 7)
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Va toda la reseña",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 9),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 1)
                    ]),
                    Divider(),
                    Divider(),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Image.asset(
                              'assets/imagenes/login/LOGO2.png', //Imagen de portada
                              fit: BoxFit.cover,
                            ),
                          ),
                          flex: 3),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                                "Alexis Rafael Aparicio Hernández\nDeveloper",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 7)
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Va toda la reseña",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 9),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("",
                                style: new TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.0,
                                    color: Colors.black)),
                          ),
                          flex: 1)
                    ]),
                    Divider(),
                  ],
                ),
              )
            ]));
  }
}
