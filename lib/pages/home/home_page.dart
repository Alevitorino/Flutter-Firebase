import 'package:autonomo_app/components/card.dart';
import 'package:autonomo_app/components/categorias_view.dart';
import 'package:autonomo_app/components/destaques.dart';
import 'package:autonomo_app/components/pesquisar.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';

import 'package:autonomo_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:autonomo_app/components/temas/temas.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  final AuthService _auth = AuthService();
  final temas = new Temas();

  showAlertDialog1(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
        return;
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Logoff"),
      content: Text("Entre com a conta Google"),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
       appBar: AppBar(
        title:
            Text("Autônomo App", style: Theme.of(context).textTheme.headline6),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        leading: Icon(
          Icons.menu,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () async {
              await _auth.SignOut();
              await showAlertDialog1(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (route) => false);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Destaques(),
              CardHome(),
              CategoriasView(),
              Pesquisar(),
            ],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add_circle,
          size: 32,
          color: whiteColor,
        ),
        label: Text(
          "Anúncio",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          _auth.SignOut();
        },
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}
