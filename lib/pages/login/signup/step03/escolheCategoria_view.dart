import 'dart:io';
import 'package:autonomo_app/pages/login/signup/step03/escolheCategoriaController.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/whapper.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/services/NomeCat_service.dart';
import 'package:autonomo_app/styles/loading.dart';


class EscolheCategoriaView extends StatefulWidget {
  final File fotoPerfil;
  final String nomeCompleto;
  final String email;
  final String senha;
  final DateTime datanasc;
  final String cpf;
  final Map endereco;
  final String telefone;
  final String bio;

  const EscolheCategoriaView(
      {Key key,
      this.fotoPerfil,
      this.nomeCompleto,
      this.email,
      this.senha,
      this.datanasc,
      this.cpf,
      this.endereco,
      this.telefone,
      this.bio})
      : super(key: key);

  @override
  _EscolheCategoriaViewState createState() => _EscolheCategoriaViewState();
}

final AuthService _auth = AuthService();
final Map<String, Map<String, bool>> mapa = {};
Map<String, List<dynamic>> _dadosFirebaseFinal = {};

class _EscolheCategoriaViewState extends State<EscolheCategoriaView> {
  @override
  void initState() {
    super.initState();
    _future = criarListas();
  }

//Criando um Map das categorias e dividindo as informações 
  Future<Map<String, Map<String, bool>>> _future;

  Future<Map<String, Map<String, bool>>> criarListas() async {
    Future<dynamic> result = NomeCatService().getFutureCat();
    await result.then((value) {
      value.data.forEach((nomeCat, nomeSubcat) => {
            mapa[nomeCat] = {},
            nomeSubcat.forEach((element) {
              mapa[nomeCat][element] = false;
            }),
          });
    });
    return mapa;
  }
//Criando um Map das categorias e dividindo as informações 

//Alerta ao não selecionar categoria
  alertUnselectedCategoria() {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Selecione suas categorias"),
      content:
          Text("Você precisa selecionar pelo menos uma categoria caralho."),
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
//Alerta ao não selecionar categoria

//Pegando as categorias selecionadas
  getItems() {
    Map<String, List<dynamic>> _dadosFirebase = {};
    mapa.forEach((cat, mapSubCat) {
      mapSubCat.forEach((String key, bool value) {
        if (value == true) {
          if (_dadosFirebase[cat] is! List<dynamic>) {
            _dadosFirebase[cat] = [];
            _dadosFirebase[cat].add(key.toString());
          } else {
            _dadosFirebase[cat].add(key.toString());
          }
        }
      });
    });
    print(_dadosFirebase);
    _dadosFirebaseFinal = _dadosFirebase;
  }
//Pegando as categorias selecionadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.arrow_forward),
          label: Text("Concluir"),
          onPressed: () async {

            //Concluindo cadastro
            if (_dadosFirebaseFinal.isNotEmpty) {
              dynamic user = await _auth.registerWithEmailAndPassword(
                  widget.email, widget.senha);

              await DatabaseService(uid: user.uid).updateUserData(
                  widget.nomeCompleto,
                  widget.email,
                  widget.datanasc.toString(),
                  widget.cpf,
                  widget.telefone,
                  widget.endereco,
                  "Insira aqui uma bio");
              await DatabaseService(uid: user.uid)
                  .categoriaUserData(_dadosFirebaseFinal);
              await DatabaseService(uid: user.uid)
                  .uploadFile(widget.fotoPerfil);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Whapper()),
                  ModalRoute.withName('/Whapper'));
            } else {
              return EscolheCategoriaController().alertUnselectedCategoria(context);
            }
            //Concluindo cadastro
          }),

      appBar: AppBar(
        backgroundColor: Color(0xff080626),
        leading: IconButton(
          icon: Icon(
            LineAwesomeIcons.arrow_left,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Selecione suas categorias",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.white, fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: mapa.keys.map((key) {
                      return ExpansionTile(
                        title: Text(
                          key.toUpperCase(),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                              ),
                        ),
                        initiallyExpanded: false,
                        subtitle: Text(
                          "Selecione seus serviços",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        backgroundColor: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.9),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          size: 32,
                          color: Color(0xff080626),
                        ),
                        children: [
                          new Container(
                            child: Column(
                              children: mapa[key].keys.map((nomeSubcat) {
                                return CheckboxListTile(
                                  activeColor: corBarraNavegacao,
                                  title: Text(nomeSubcat.toString()),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: mapa[key][nomeSubcat],
                                  onChanged: (value) {
                                    setState(() {
                                      mapa[key][nomeSubcat] = value;
                                      getItems();
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Loading(),
            );
          }
        },
      ),
    );
  }
}
