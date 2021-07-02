import 'package:flutter/material.dart';
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
   List _genres =
  ["5 mas populares", "Ciencia ficcion", "fantasia", "Terror", "Constanta"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSearch;

  void initState() {
      _dropDownMenuItems = getDropDownMenuItems();
      _currentSearch = _dropDownMenuItems[0].value;
      super.initState();
    }
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
       drawer: MenuLateral(),
        appBar: AppBar1("MY REVIEW",context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Text(
                  "Busqueda por generos"
                ),
              ),
              Container(
                  child: new DropdownButton(  
                     icon: const Icon(Icons.filter_list_alt),
              value: _currentSearch,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            ),
                ),
            
            ],
          ),
        ),
      ),
    );
  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _genres) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  //funcion que cambia el genero 
 void changedDropDownItem(String selectedGenre) {
    print("Selected genre $selectedGenre, we are going to refresh the UI");
    setState(() {
      _currentSearch = selectedGenre;
    });
  }
}
