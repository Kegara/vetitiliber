import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetitiliber/componentes/menulateral.dart';

class ConfiperfilPage extends StatefulWidget {
  ConfiperfilPage({Key key, this.title}) : super(key: key);
  final String title;

  static String id = 'ConfiperfilPage';
  @override
  _ConfiperfilPageState createState() => _ConfiperfilPageState();
}

List<String> imgs = [
  "https://static.vecteezy.com/system/resources/previews/001/917/629/non_2x/person-reading-book-free-photo.jpg",
  "https://image1.masterfile.com/getImage/NjczLTA2MDI1NTAzZW4uMDAwMDAwMDA=AJal11/673-06025503en_Masterfile.jpg",
  "https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg",
  "https://previews.123rf.com/images/jojjik/jojjik1204/jojjik120400036/13014704-bald-man-in-suit-reads-a-bible-isolated-on-white.jpg",
  "https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHJlYWRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
  "https://qph.fs.quoracdn.net/main-qimg-dfc610007178ffb94a0ef143aeb56cfd-c",
];

class Usuario {
  final String nombre;
  final int fotoPerfilNum;
  final String correoElectronico;
  final bool vLibros;
  final bool vResenas;
  final bool vPerfil;

  Usuario({
    this.nombre,
    this.fotoPerfilNum,
    this.correoElectronico,
    this.vLibros,
    this.vResenas,
    this.vPerfil,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return new Usuario(
      nombre: json['nombre'],
      fotoPerfilNum: int.parse(json['fotoPerfilNum']),
      correoElectronico: json['correoElectronico'],
      vLibros: json['vLibros'] == '1',
      vResenas: json['vResenas'] == '1',
      vPerfil: json['vPerfil'] == '1',
    );
  }
}

Usuario usuario = new Usuario(
  nombre: 'Espere un momento',
  fotoPerfilNum: 0,
  correoElectronico: 'Espere un momento',
  vLibros: false,
  vResenas: false,
  vPerfil: false,
);

String idUs = '0';

Future<String> getUsuarioId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('idUsuario').toString();
}

Future<Usuario> getInfoUs() async {
  idUs = await getUsuarioId();
  final _url = "https://myreviewvl.000webhostapp.com/BD/Usuario/infoConfUs.php";
  Usuario _aux;
  try {
    final response = await post(
      Uri.parse(_url),
      body: {
        'id': idUs,
      },
    );
    final json = jsonDecode(response.body);
    _aux = new Usuario.fromJson(json);
    print("(getInfoUs) Aviso");
  } catch (err) {
    print("(getInfoUs) err: $err");
  }
  return _aux;
}

Future<Usuario> updateConf(String contenido, String tabla, String campo) async {
  final _url =
      "https://myreviewvl.000webhostapp.com/BD/Usuario/updateConfUs.php";
  Usuario _aux;
  try {
    await post(
      Uri.parse(_url),
      body: {
        'id': idUs,
        'contenido': contenido,
        'tabla': tabla,
        'campo': campo,
      },
    );
    _aux = await getInfoUs();
    // return true;
  } catch (err) {
    print("(updateConf) err: $err");
  }
  // return false;
  return _aux;
}

bool _aux = true;

int selectedOp = 0;

class _ConfiperfilPageState extends State<ConfiperfilPage> {
  void chekSelectedOp(int index) {
    setState(() {
      selectedOp = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_aux) {
      getInfoUs().then((value) {
        setState(() {
          usuario = value;
          selectedOp = value.fotoPerfilNum;
          isSwitched1 = value.vLibros;
          isSwitched2 = value.vResenas;
          isSwitched3 = value.vPerfil;
          _aux = false;
        });
      });
    }
    return Scaffold(
      drawer: MenuLateral(),
      appBar: appBar1("Configurac??n", context),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Text(
                    "Cuenta\n",
                    style: new TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      color: Colors.black,
                    ),
                  ),
                  MyCustomForm(),
                  FormContra(),
                  FormCorreo(),
                  Text(
                    "\nEliga su foto de perfil\n",
                    style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: <Widget>[
                        for (int i = 0; i < imgs.length; i++)
                          Opcion(
                            "Opcion ${i + 1}",
                            img: imgs[i],
                            onTap: () {
                              chekSelectedOp(i);
                            },
                            selected: i == selectedOp,
                          )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Su petici??n est?? siendo procesada"),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              updateConf(selectedOp.toString(), '0', '2')
                                  .then((value) {
                                setState(() {
                                  usuario = value;
                                  selectedOp = value.fotoPerfilNum;
                                });
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Su petici??n se ejecuto exitosamente"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              });
                            },
                            child: Text('Cambiar'),
                          ),
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Text(''),
                        flex: 7,
                      )
                    ],
                  ),
                  Divider(),
                  FormPrivacidad(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Opcion extends StatelessWidget {
  const Opcion(
    this.title, {
    Key key,
    this.img,
    this.onTap,
    this.selected,
  }) : super(key: key);

  final String title;
  final String img;
  final VoidCallback onTap;
  final bool selected;

  Widget build(BuildContext context) {
    return Ink.image(
      fit: BoxFit.cover,
      image: NetworkImage(img),
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(microseconds: 300),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ?? false ? Colors.blue : Colors.transparent,
                  width: selected ?? false ? 5 : 0,
                ),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected ?? false
                        ? Colors.blue.withOpacity(0.8)
                        : Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Crea un Widget Form de nombre
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Crea un Widget Form de contrase??a
class FormContra extends StatefulWidget {
  @override
  FormContraState createState() {
    return FormContraState();
  }
}

// Crea un Widget Form de correo
class FormCorreo extends StatefulWidget {
  @override
  FormCorreoState createState() {
    return FormCorreoState();
  }
}

// Crea un Widget Form de privacidad
class FormPrivacidad extends StatefulWidget {
  @override
  FormPrivacidadState createState() {
    return FormPrivacidadState();
  }
}

//-----------------------------------FORM DE NOMBRE---------------------------------------
// Crea una clase State correspondiente. Esta clase contendr?? los datos relacionados con
// el formulario.
class MyCustomFormState extends State<MyCustomForm> {
  // Crea una clave global que identificar?? de manera ??nica el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreController = TextEditingController();
    // Crea un widget Form usando el _formKey que creamos anteriormentes
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Cambiar nombre\n",
            style: new TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
              color: Colors.black,
            ),
          ),
          Text(
            "Nombre actual: ${usuario.nombre}", //Inicia el campo a cambiar
            style: new TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
              color: Colors.black,
            ),
          ),
          TextFormField(
            controller: nombreController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese texto';
              }
              return null;
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // devolver?? true si el formulario es v??lido, o falso si
                      // el formulario no es v??lido.
                      if (_formKey1.currentState.validate()) {
                        // Si el formulario es v??lido, queremos mostrar un Snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Su petici??n est?? siendo procesada"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        _formKey1.currentState.save();
                        updateConf(nombreController.text, '0', '0')
                            .then((value) {
                          setState(() {
                            usuario = value;
                            // print("funco? ${value ? 'yup' : 'nop'}");
                          });
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Su petici??n se ejecuto exitosamente"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        });
                      }
                    },
                    child: Text('Cambiar'),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Text(''),
                flex: 7,
              )
            ],
          ),
          //Campos de verdadero o falso
          Divider(),
          /* Text("\nNotificaciones\n",
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Su petici??n est?? siendo procesada"),
                          behavior: SnackBarBehavior.floating,
                        ));
                      });
                    },
                    activeTrackColor: Colors.cyan,
                    activeColor: Colors.blueAccent,
                  ),
                  flex: 2),
            ],
          ),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Su petici??n est?? siendo procesada"),
                          behavior: SnackBarBehavior.floating,
                        ));
                      });
                    },
                    activeTrackColor: Colors.cyan,
                    activeColor: Colors.blueAccent,
                  ),
                  flex: 2),
            ],
          ),*/
        ],
      ),
    );
  }
}

//-----------------------------------FORM DE CONTRASE??A---------------------------------------
// Crea una clase State correspondiente. Esta clase contendr?? los datos relacionados con
// el formulario.
class FormContraState extends State<FormContra> {
  // Crea una clave global que identificar?? de manera ??nica el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController passController = TextEditingController();
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Nuevo campo-------------------------------------------------------------------
          Text(
            "\nCambiar contrase??a\n",
            style: new TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
              color: Colors.black,
            ),
          ),
          // Text(
          //   "Contrase??a nueva", //Inicia el campo a cambiar
          //   style: new TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.bold,
          //     letterSpacing: 5.0,
          //     color: Colors.black,
          //   ),
          // ),
          TextFormField(
            controller: passController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese texto';
              }
              return null;
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // devolver?? true si el formulario es v??lido, o falso si
                        // el formulario no es v??lido.
                        if (_formKey2.currentState.validate()) {
                          // Si el formulario es v??lido, queremos mostrar un Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Su petici??n est?? siendo procesada"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          _formKey2.currentState.save();
                          updateConf(passController.text, '0', '1')
                              .then((value) {
                            setState(() {
                              usuario = value;
                            });
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Su petici??n se ejecuto exitosamente"),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          });
                        }
                      },
                      child: Text('Cambiar'),
                    ),
                  ),
                  flex: 3),
              Expanded(
                child: Text(''),
                flex: 7,
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

//-----------------------------------FORM DE CORREO---------------------------------------
// Crea una clase State correspondiente. Esta clase contendr?? los datos relacionados con
// el formulario.
class FormCorreoState extends State<FormCorreo> {
  // Crea una clave global que identificar?? de manera ??nica el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController mailController = TextEditingController();
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
      key: _formKey3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Nuevo campo-------------------------------------------------------------------
          Text(
            "\nCambiar correo\n",
            style: new TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
              color: Colors.black,
            ),
          ),
          Text(
            "Correo actual: ${usuario.correoElectronico}", //Inicia el campo a cambiar
            style: new TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
              color: Colors.black,
            ),
          ),
          TextFormField(
            controller: mailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese texto';
              }
              return null;
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // devolver?? true si el formulario es v??lido, o falso si
                      // el formulario no es v??lido.
                      if (_formKey3.currentState.validate()) {
                        // Si el formulario es v??lido, queremos mostrar un Snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Su petici??n est?? siendo procesada"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        _formKey3.currentState.save();
                        updateConf(mailController.text, '0', '3').then((value) {
                          setState(() {
                            usuario = value;
                          });
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Su petici??n se ejecuto exitosamente"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        });
                      }
                    },
                    child: Text('Cambiar'),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Text(''),
                flex: 7,
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

bool isSwitched1 = false;
bool isSwitched2 = false;
bool isSwitched3 = false;

//-----------------------------------FORM DE PRIVACIDAD---------------------------------------
// Crea una clase State correspondiente. Esta clase contendr?? los datos relacionados con
// el formulario.
class FormPrivacidadState extends State<FormPrivacidad> {
  // Crea una clave global que identificar?? de manera ??nica el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey4 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
      key: _formKey4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Nuevo campo-------------------------------------------------------------------
          Text(
            "\nPrivacidad\n",
            style: new TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
              color: Colors.black,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                    'Otros usuarios pueden ver los libros que has le??do o no',
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      color: Colors.grey,
                    ),
                  ),
                  flex: 8),
              Expanded(
                child: Switch(
                  value: isSwitched1,
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Su petici??n est?? siendo procesada"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    updateConf(value ? '1' : '0', '1', '0').then((value) {
                      setState(() {
                        usuario = value;
                        isSwitched1 = value.vLibros;
                      });
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Su petici??n se ejecuto exitosamente"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    });
                  },
                  activeTrackColor: Colors.cyan,
                  activeColor: Colors.blueAccent,
                ),
                flex: 2,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Otros usuarios pueden ver tus rese??as',
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                    color: Colors.grey,
                  ),
                ),
                flex: 8,
              ),
              Expanded(
                child: Switch(
                  value: isSwitched2,
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Su petici??n est?? siendo procesada"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    updateConf(value ? '1' : '0', '1', '1').then((value) {
                      setState(() {
                        usuario = value;
                        isSwitched2 = value.vResenas;
                      });
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Su petici??n se ejecuto exitosamente"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    });
                  },
                  activeTrackColor: Colors.cyan,
                  activeColor: Colors.blueAccent,
                ),
                flex: 2,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Establecer su perfil como privado',
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                    color: Colors.grey,
                  ),
                ),
                flex: 8,
              ),
              Expanded(
                child: Switch(
                  value: isSwitched3,
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Su petici??n est?? siendo procesada"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    updateConf(value ? '1' : '0', '1', '2').then((value) {
                      setState(() {
                        usuario = value;
                        isSwitched3 = value.vPerfil;
                      });
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Su petici??n se ejecuto exitosamente"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    });
                  },
                  activeTrackColor: Colors.cyan,
                  activeColor: Colors.blueAccent,
                ),
                flex: 2,
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
