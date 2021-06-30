import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'PerfilPage';
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
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
        body: Container(
          child: Column(children: <Widget>[
            Text("Top libros",
                style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                    color: Colors.blueAccent)),
            new Expanded(
                child: GridView.count(crossAxisCount: 2, children: [
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
              contenedoresLibros(context),
            ]))
          ]),
        ));
  }
}

Widget contenedoresLibros(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width / 1.5,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: AssetImage('assets/imagenes/login/LOGO2.png'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [new BoxShadow(blurRadius: 0.0)]),
  );
}
