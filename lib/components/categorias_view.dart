import 'package:autonomo_app/models/nomeCat_Model.dart';
import 'package:autonomo_app/services/NomeCat_service.dart';
import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';

final temas = new Temas();

class CategoriasView extends StatefulWidget {
  @override
  _CategoriasViewState createState() => _CategoriasViewState();
}

class _CategoriasViewState extends State<CategoriasView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            
            Container(
              margin: EdgeInsets.only(left: 10, top: 0),
              alignment: Alignment.centerLeft,
              child: Text("Categorias",
                  style: Theme.of(context).textTheme.headline6),
            ),

            SizedBox(
              height: 200,
              child: StreamBuilder(
                  stream: NomeCatService().getCategorias,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      NomeCatModel result = snapshot.data;
                      print(result.campos);
                      List<String> newList = new List<String>();
                      String novaKey;
                      String outraKey;
                      result.campos.forEach((String key, valueKey) => {
                            if (key.length >= 7)
                              {
                                novaKey = key.substring(0, 6),
                                outraKey = novaKey + '.',
                                // print(novaKey),
                                newList.add(outraKey),
                              }
                            else
                              {
                                newList.add(key),
                              }
                       
                          });
                     
                      return GridView.count(
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: 2,
                        
                        children: List.generate(newList.length, (index) {
                          return Container(
                          
                            child: Column(
                              children: <Widget>[
                                Card(
                                  color: Theme.of(context).buttonColor,
                                  elevation: 0,
                                  child: InkWell(
                                    splashColor: Colors.blue[900],
                                    onTap: () {},
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Container(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Positioned(
                                                  top: 10,
                                                  //left: 0,
                                                  child: Icon(
                                                    Icons.apps,
                                                    color: Colors.white,
                                                    size: 38,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 52,
                                                  child: FittedBox(
                                                    child: Text(
                                                      newList[index]
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    } else {
                      return Container(
                        child: Text('data'),
                      );
                    }
                  }),
            ),
            // vieew
          ]),
    );
  }
}
