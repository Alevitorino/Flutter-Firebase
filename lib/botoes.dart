import 'package:flutter/material.dart';

class BotoesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Botões'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    onPressed: () => {},
                    color: Colors.green[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                        side: BorderSide(color: Colors.green[600])),
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            "Editar Perfil",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    color: Colors.white,
                    textColor: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {},
                    child: Text(
                      "Add to Cart".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xff080626), width: 0),
                    ),
                    onPressed: () {},
                    color: Colors.red[700],
                    textColor: Colors.white,
                    child: Text("Sair".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text("Sair"),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Sair",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Sair",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Sair"),
                    ),
                  ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    onPressed: () {},
                    child: Text(
                      "Sair",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
