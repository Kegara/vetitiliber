import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class AnswerPage extends StatefulWidget {
  AnswerPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'AnswerPage';
  @override
  _AnswerPage createState() => _AnswerPage();
}

class _AnswerPage extends State<AnswerPage> {
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          new Expanded(
            //Aquí empieza el listado de acciones
            child: ListView(
              children: <Widget>[
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
                        child: Text("Name del usuario\n☆☆☆☆☆",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const <Widget>[
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.lightBlue,
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                        flex: 3),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text("80",
                              style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                        ),
                        flex: 1),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Icon(
                            Icons.thumb_down_outlined,
                            color: Colors.red,
                            size: 30.0,
                          ),
                        ),
                        flex: 3),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text("",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.0,
                                  color: Colors.black)),
                        ),
                        flex: 3),
                  ],
                ),
                Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      maxLines: null,
                      maxLength: 200,
                      decoration: InputDecoration(
                        hintText: 'Comentar reseña.',
                      ),
                    ),
                  ),
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
                          child: Text('Comentar'),
                        ),
                      ),
                      flex: 3),
                  Expanded(child: Text(''), flex: 7)
                ]),
                Divider(),
                //Aquí van los comentarios de otros---------------------------------------------------------------------------------
                Expanded(),
              ],
            ),
          )
        ]));
  }
}
