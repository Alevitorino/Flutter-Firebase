import 'package:autonomo_app/components/bottomNavigationBar.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';

class Whapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return LoginPage();
    } else {
      return BarraDeNavegacao();
    }
  }
}
