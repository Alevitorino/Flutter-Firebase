import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';

final temas = new Temas();

class Pesquisar extends StatefulWidget {
  @override
  _PesquisarState createState() => _PesquisarState();
}

class _PesquisarState extends State<Pesquisar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, top: 0),
            child:
                Text("Pesquisar", style: Theme.of(context).textTheme.headline6),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite aqui',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
