import 'package:autonomo_app/botoes.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:flutter/services.dart';

final temas = new Temas();

showAlertDialog1(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Login"),
    content: Text("Faça login para usar o app"),
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

class BarraDeNavegacao extends StatefulWidget {
  @override
  _BarraDeNavegacaoState createState() => _BarraDeNavegacaoState();
}

class _BarraDeNavegacaoState extends State<BarraDeNavegacao>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 2;

  //Barra de navegação entre Home - Buscar - Profile
  List<Widget> _tabList = [
    HomePage(),
    BotoesView(),
    ProfileView(),
  ];
  //Barra de navegação entre Home - Buscar - Profile

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getCurrentStatusNavigationBarColor();
  }

  getCurrentStatusNavigationBarColor() {
    var temaDark = WidgetsBinding.instance.window.platformBrightness;

    if (temaDark.toString() == 'Brightness.dark') {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: corBarraNavegacaoDark,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: corBarraNavegacao,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
      
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabList[_currentIndex],
      bottomNavigationBar: Container(
        height: 65,
        child: BottomNavigationBar(
          onTap: (currentIndex) {
            setState(() {
              _currentIndex = currentIndex;
            });
            _tabController.animateTo(_currentIndex);
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Buscar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
            )
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}
