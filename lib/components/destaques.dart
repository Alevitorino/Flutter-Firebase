import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';

final temas = new Temas();

class Destaques extends StatefulWidget {
  @override
  _DestaquesState createState() => _DestaquesState();
}

class _DestaquesState extends State<Destaques> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(left: 10, top: 12),
            alignment: Alignment.centerLeft,
            child:
                Text("Destaques", style: Theme.of(context).textTheme.headline6),
          ),
        ],
      ),
    );
  }
}
