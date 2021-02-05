import 'package:flutter/material.dart';

class EscolheCategoriaController {
  alertUnselectedCategoria(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Categoria"),
      content: Text("Você precisa selecionar pelo menos uma categoria."),
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
}