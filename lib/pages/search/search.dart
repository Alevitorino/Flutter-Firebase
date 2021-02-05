import 'package:autonomo_app/components/pesquisar.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pesquisar"),
          centerTitle: true,
          backgroundColor: Theme.of(context).accentColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Container(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.only(
            top: 10,
            left: 4,
            right: 4,
          ),
          child: Pesquisar(),
        ));
  }
}
