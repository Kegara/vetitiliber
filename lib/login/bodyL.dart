import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0,bottom: 20),
              child: Text('My Review',
                  style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      color: Colors.blueAccent)),
            ),
            Image.asset(
              'assets/imagenes/login/LOGO2.png',
              height: size.height * 0.25,
            ),

           Padding(
             padding: const EdgeInsets.only(top: 20.0),
             child: TextField(autofocus: true,decoration: InputDecoration(icon: Icon(Icons.person) ),),
           ),  Padding(
             padding: const EdgeInsets.only(top: 20.0),
             child: TextField(autofocus: true,obscureText: true,decoration: InputDecoration(icon: Icon(Icons.lock) ) ,),
           ),
          ],
        ),
      ),
    );
  }
}
