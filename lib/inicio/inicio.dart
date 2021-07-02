import 'package:flutter/material.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'StartPage';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar1("MY REVIEW",context),
        body: Container(
          child:Column(
               children: <Widget>[
                 Text("Top libros",
                    style: new TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                        color: Colors.blueAccent)
                        ),

               new Expanded(
            child :GridView.count(crossAxisCount: 2, children: [
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
          
            ]
          )
         
            )
            
            ]
          ),
       
        )
        );
  }
}
// contenedor que tendra la info del libro el cual tiene asociado un onTap que redirige a la informacion del libro
Widget contenedoresLibros(BuildContext context) {
  return InkWell(
  onTap: () { 
    print("Container was tapped"); 
    },
  child: Container(
    margin: EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width / 1.5,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: AssetImage('assets/imagenes/login/LOGO2.png'),
            fit: BoxFit.cover)
            ,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [new BoxShadow( blurRadius: 0.0)]
        )
 ),
);
}
