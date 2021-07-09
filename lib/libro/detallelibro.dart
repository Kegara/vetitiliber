import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class DetalibroPage extends StatefulWidget {
  DetalibroPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'ConfiperfilPage';
  @override
  _DetalibroPageState createState() => _DetalibroPageState();
}

class _DetalibroPageState extends State<DetalibroPage> {
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
    bool isSwitched = false;
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Nombre del libro", //Texto inicial de la sección debe ir el titulo del libro
                  style: new TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      color: Colors.black)),
              Text(
                  "☆☆☆☆☆(80)", //Texto inicial de la sección debe ir la clificación y pot cuantos
                  style: new TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      color: Colors.black)),
              new Expanded(
                //Aquí empieza el listado de acciones
                child: ListView(
                  children: <Widget>[
                    Text("\n",
                        style: new TextStyle(
                            fontSize: 5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    //Imagen del libro--------------------------------
                    Image.asset(
                      'assets/imagenes/login/LOGO2.png', //Imagen de portada
                      fit: BoxFit.cover,
                    ),
                    Text("Detalles\n",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    //Inicia el campo de sipnosis--------------------------------------------------
                    Row(children: <Widget>[
                      Expanded(
                          child: Text("Sipnosis\n",
                              style: new TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5.0,
                                  color: Colors.black)),
                          flex: 3),
                      Expanded(
                          child: Text("Sipnosis\n",
                              style: new TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                          flex: 7)
                    ]),
                    //Inicia el campo del autor--------------------------------------------------
                    Row(children: <Widget>[
                      Expanded(
                          child: Text("Autor\n",
                              style: new TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5.0,
                                  color: Colors.black)),
                          flex: 3),
                      Expanded(
                          child: Text("Nombre del autor\n",
                              style: new TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                          flex: 7)
                    ]),
                    //Inicia el campo de genero--------------------------------------------------
                    Row(children: <Widget>[
                      Expanded(
                          child: Text("Genero\n",
                              style: new TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5.0,
                                  color: Colors.black)),
                          flex: 3),
                      Expanded(
                          child: Text("Van los generos\n",
                              style: new TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                          flex: 7)
                    ]),
                    //Nuevo campo-------------------------------------------------------------------
                    Text("\nReseñas\n",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    Text("Escribe tu reseña", //Inicia el campo a cambiar
                        style: new TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // devolverá true si el formulario es válido, o falso si
                                // el formulario no es válido.
                                if (_formKey.currentState.validate()) {
                                  // Si el formulario es válido, queremos mostrar un Snackbar
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Procesing Data"),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                }
                              },
                              child: Text('Publicar'),
                            ),
                          ),
                          flex: 3),
                      Expanded(child: Text(''), flex: 7)
                    ]),
                    Divider(),
                    //Visualización de las reseñas-------------------------------------------------------------------
                    Row(children: <Widget>[
                      Expanded(
                          child: Image.asset(
                            'assets/imagenes/login/LOGO2.png', //Imagen de portada
                            fit: BoxFit.cover,
                          ),
                          flex: 3),
                      Expanded(
                          child: Text("Name del usuario\n☆☆☆☆☆",
                              style: new TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                          flex: 7)
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: Text("Va toda la reseña",
                              style: new TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                          flex: 9),
                      Expanded(
                          child: Text("",
                              style: new TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                          flex: 1)
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Icon(
                          Icons.audiotrack,
                          color: Colors.green,
                          size: 30.0,
                        ),
                        Icon(
                          Icons.beach_access,
                          color: Colors.blue,
                          size: 36.0,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]));
  }
}
