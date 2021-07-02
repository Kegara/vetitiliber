import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'GenreSPage';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final sController = TextEditingController();
  //lista de libros en el genero
  List _books = [] ;
  //lista de generos
  List _genres = [] ;
  //lista de generos populares
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSearch;
 
  var pwdWidgets = <Widget>[];

  @override
  Widget build(BuildContext context) { 
    creadorSecciones();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar1("MY REVIEW", context),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Busqueda por generos"),
              ),
              Container(
                child: new DropdownButton(
                  icon: const Icon(Icons.filter_list_alt),
                  value: _currentSearch,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              ),
              // Comments List will go here
        
               Column(
                  mainAxisSize: MainAxisSize.min,
                  children: pwdWidgets,
                ),
              
            ],
          )),
        ));
  }

  //llenamos la lista con los valores
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    _genres =llenadoGeneros() ;
    items.add(new DropdownMenuItem(
        value: _currentSearch,
        child: new Text(
          "5 generos pupulares",
        )));
    for (String genero in _genres) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: genero, child: new Text(genero)));
    }
    return items;
  }

  //funcion que llama a la funcion de llenado de lista y
  //pone el primer valor de la lista en la busqueda actual
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentSearch = _dropDownMenuItems[0].value;
    super.initState();
  }

  //funcion que se activa al cambiar el genero
  void changedDropDownItem(String selectedGenre) {
    print("Selected genre $selectedGenre, we are going to refresh the UI");
    setState(() {
      _currentSearch = selectedGenre;
      creadorSecciones();
    });
  }

  //contenedores
  Widget contenedoresLibros(int nContenedor) {
    return 
     Container(
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(
                          "https://th.bing.com/th/id/R.8d9ba5df9a59ec6f73f0a40630247440?rik=QnOZeZ%2btOaCbTw&riu=http%3a%2f%2froc21cdn-roc21.netdna-ssl.com%2fblog%2fwp-content%2fuploads%2f2016%2f10%2fportadas-libros-siencia-ficcion-cuatro.jpg&ehk=Dze1Ot%2fzw99kcOQoVtYx1tnfpIBiYCgSLG%2fo%2fxdwLn0%3d&risl=&pid=ImgRaw"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              boxShadow: [new BoxShadow(blurRadius: 0.0)]
           
              
              ),  child: InkWell(
      onTap: () {
        print("Container $nContenedor was tapped");
      },
              
    ));
  }

  //contenedor de seccion
  Widget newSection(String sectionName, int limit) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(children: [
          Text(sectionName),
          Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _genres.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(children: <Widget>[
                        contenedoresLibros(index),
                        new Expanded(
                            child: Text(
                          "El Libro con el Titulo mas Largo del Mundo   ",
                          overflow: TextOverflow.visible,
                        ))
                      ]),
                    );
                  })),
          TextButton(
            child: Text(
              'Ver mas',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {},
          ),
        ]));
  }
  List llenadoGeneros(){
    return ["g1 ", "g2", "g3", "g4"];
  }
  List llenadoLibros(String sectionName){
       return ["g1 ", "g2", "g3", "g4"];
  }
  void creadorSecciones() {
    pwdWidgets = <Widget>[];
         print(_currentSearch);
    if (_currentSearch == "5 generos pupulares" || _currentSearch==null) {
      for (String genero in _genres) {
        pwdWidgets.add(newSection(genero, 5));
      }
    } else
    {
       pwdWidgets.add(new   SizedBox(
      height:  (MediaQuery.of(context).size.height * 0.9), 
       child:detalleSeccion( _currentSearch,  5)));
    }

    setState(() {});
  }

  Widget detalleSeccion(String sectionName, int limit){
  _books=llenadoLibros(sectionName);
    setState(() {
     
    });
    return   GridView.count(
            childAspectRatio: ((MediaQuery.of(context).size.width/2-40) / (MediaQuery.of(context).size.height * 0.4)),
            crossAxisCount: 2 ,          
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisSpacing:10.0,
          mainAxisSpacing: 10.0,
            children: List.generate(limit,(index){
            return Padding(
              padding:const EdgeInsets.only(right:10.0,left: 10.0),
              child: Column(
              children: [
                contenedoresLibrosD(index),
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

;
  }
 Widget contenedoresLibrosD(int nContenedor) {
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

}
