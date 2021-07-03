import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class ConfiperfilPage extends StatefulWidget {
  ConfiperfilPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'ConfiperfilPage';
  @override
  _ConfiperfilPageState createState() => _ConfiperfilPageState();
}

class _ConfiperfilPageState extends State<ConfiperfilPage> {
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
              Text("Configuración", //Texto inicial de la sección configuración
                  style: new TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      color: Colors.blueAccent)),
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
                    Text("Cuenta\n",
                        style: new TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    //Nuevo Campo----------------------------------------------------------------------
                    Text("Cambiar nombre\n",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    Text("Nombre actual", //Inicia el campo a cambiar
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
                              child: Text('Cambiar'),
                            ),
                          ),
                          flex: 3),
                      Expanded(child: Text(''), flex: 7)
                    ]),
                    //Nuevo campo-------------------------------------------------------------------
                    Text("\nCambiar contraseña\n",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    Text("Contraseña actual", //Inicia el campo a cambiar
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
                              child: Text('Cambiar'),
                            ),
                          ),
                          flex: 3),
                      Expanded(child: Text(''), flex: 7)
                    ]),
                    //Nuevo campo-------------------------------------------------------------------
                    Text("\nCambiar correo\n",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    Text("Correo actual", //Inicia el campo a cambiar
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
                              child: Text('Cambiar'),
                            ),
                          ),
                          flex: 3),
                      Expanded(child: Text(''), flex: 7)
                    ]),
                    //Campos de verdadero o falso
                    Divider(),
                    Text("\nNotificaciones\n",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                            color: Colors.black)),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text('Recibir Notificaciones',
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5.0,
                                    color: Colors.grey)),
                            flex: 8),
                        Expanded(
                            child: Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Procesing Data"),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                });
                              },
                              activeTrackColor: Colors.cyan,
                              activeColor: Colors.blueAccent,
                            ),
                            flex: 2),
                      ],
                    )
                  ],
                ),
              )
            ]));
  }
}
