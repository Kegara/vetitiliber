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
  List _topBooks = ["g1 ", "g2", "g3", "g4", "g4"];
   List<String> images = [  
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",  
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",  
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",  
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"  
  ];  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar1("MY REVIEW", context),
        body: SafeArea(
          child: Center(
            child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Top libros"),
              ),
            Expanded(  
            child: GridView.count(
            childAspectRatio: ((MediaQuery.of(context).size.width/2-40) / (MediaQuery.of(context).size.height * 0.4)),
            crossAxisCount: 2 ,
            crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
            children: List.generate(10,(index){
            return Padding(
              padding:const EdgeInsets.only(right:10.0,left: 10.0),
              child: Column(
              children: [

                contenedoresLibros(index),
               new Expanded(
                      child: Text(
                    "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo ",
                    overflow: TextOverflow.ellipsis
                    ,maxLines: 3,
                  )
                  ) ],
            )
               
            )
              ;
            }
  ),
)
),  
      
   
                
            ],
          )),
        ));
  }

  // contenedor que tendra la info del libro el cual tiene asociado un onTap que redirige a la informacion del libro
  Widget contenedoresLibros(int nContenedor) {
    return 
       Container(
         height: (MediaQuery.of(context).size.height * 0.4),
       padding: const EdgeInsets.only(bottom:10.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(
                          "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              boxShadow: [new BoxShadow(blurRadius: 0.0)]
              
              ),
                      child:InkWell(
      onTap: () {
        print("Container $nContenedor was tapped");
      }
              )
      )

      
    
       ;
  }

  Widget newSection(String sectionName, int limit) {
    _topBooks = obtenerTopBooks();

    return Expanded(
      child: Container(
                    height: 1550,
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: _topBooks.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 50.0),
            itemBuilder: (BuildContext context, int index) {
              return      SingleChildScrollView(    
               child: Column(
                children: [
                
                     Container(
                        child:contenedoresLibros(index)
                    ),
                  
              
                  new Expanded(
                      child: Text(
                    "El Libro con el Titulo mas Largo del Mundo El Libro con el Titulo mas Largo del Mundo  El Libro con el Titulo mas Largo del Mundo ",
                    overflow: TextOverflow.ellipsis,
                  )
                  )
                ],
              )
              );
            },
          )),
    );
  }

  List obtenerTopBooks() {
    return ["g1 ", "g2", "g3", "g4", "g4"];
  }
}

 