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
  List _genres =["g1 ", "g2", "g3", "g4"];
  List _populargenres = ["Ciencia ficcion", "fantasia", "Terror", "Constanta"];
  List _genrescount = [15, 10, 20, 30];
  List _genresid = [1, 2, 3, 4];
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
                children: pwdWidgets,
              )
            ],
          )),
        ));
  }

  //llenamos la lista con los valores
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
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
    return InkWell(
      onTap: () {
        print("Container $nContenedor was tapped");
      },
      child: Container(
          height: 150,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: AssetImage('assets/imagenes/login/LOGO2.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              boxShadow: [new BoxShadow(blurRadius: 0.0)])),
    );
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
                          "El Libro con el Titulo mas Largo del Mundo",
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

  void creadorSecciones() {
    pwdWidgets = <Widget>[];
    
         print(_currentSearch);
    if (_currentSearch == "5 generos pupulares" || _currentSearch==null) {
      for (String genero in _genres) {
        pwdWidgets.add(newSection(genero, 5));
      }
    } else {
       pwdWidgets.add(DetalleSeccion( _currentSearch,  5));
    }

    setState(() {});
  }

  Widget DetalleSeccion(String sectionName, int limit){
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
                          "El Libro con el Titulo mas Largo del Mundo",
                          overflow: TextOverflow.visible,
                        ))
                      ]),
                    );
                  })),
       
        ]
        )
        )
        ;
  }


}
