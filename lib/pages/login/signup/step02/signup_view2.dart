import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/result_cep.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_view.dart';

class SignupPage2 extends StatefulWidget {
  // Passando informação de uma pagina para outra
  final File fotoPerfil;
  final String nomeCompleto;
  final String email;
  final String senha;
  final DateTime datanasc;
  final String cpf;
  final Map endereco;
  const SignupPage2({
    Key key,
    this.fotoPerfil,
    this.nomeCompleto,
    this.email,
    this.senha,
    this.datanasc,
    this.cpf,
    this.endereco,
  }) : super(key: key);
  // Passando informação de uma pagina para outra
  @override
  _SignupPage2State createState() => _SignupPage2State();
}

//Controladores do Texto
TextEditingController txtrua = new TextEditingController();
TextEditingController txtCep = new TextEditingController();
TextEditingController txtMunicipio = new TextEditingController();
TextEditingController txtEstado = new TextEditingController();
TextEditingController txtBairro = new TextEditingController();
TextEditingController txtNumCasa = new TextEditingController();
TextEditingController txtComplemento = new TextEditingController();
TextEditingController txtTelefone = new TextEditingController();
//Controladores do Texto

// Formato do Texto 
var formaterTelefone = new MaskTextInputFormatter(mask: '(##) # ####-####');
var formaterCep = new MaskTextInputFormatter(mask: '#####-###');
// Formato do Texto 

class _SignupPage2State extends State<SignupPage2> {

  final User user = User();
  final UserData userData = UserData();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String resultado;
  bool exibeCampos = false;
  Map resultCepMap = {};
  CepModel retorno;


// Função de buscar o cep 
  Future buscaCep(String cep) async {
    if (cep.length == 9) {
      var response = await http.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        retorno = CepModel.fromJson(response.body);
        String resposta = validaCep(retorno);

        return resposta;
      } else if (response.statusCode == 400) {
        print("valor inválido para cep");
        setState(() {
          exibeCampos = false;
        });
        return "false";
        // throw Exception('Requisição inválida!');
      }
    } else {
      setState(() {
        exibeCampos = false;
      });
      return "false";
    }
  }

// Função de buscar o cep 

//Validador do CEP 
  String validaCep(retorno) {
    if (retorno != null) {
      if (retorno.erro == null) {
        resultCepMap = retorno.toMap();
        resultCepMap.remove('unidade');
        resultCepMap.remove('ibge');
        resultCepMap.remove('gia');
        resultCepMap.remove('erro');

        txtrua.text = retorno.logradouro;
        txtMunicipio.text = retorno.localidade;
        txtBairro.text = retorno.bairro;
        txtEstado.text = retorno.uf;

        resultCepMap['complemento'] = txtComplemento.text;
        resultCepMap['numero'] = txtNumCasa.text;

        setState(() {});
        return null;
      } else if (retorno.erro == true) {
        resultCepMap = {};

        txtrua.text = "";
        txtMunicipio.text = "";
        txtBairro.text = "";
        txtEstado.text = "";
        txtComplemento.text = "";
        txtNumCasa.text = "";

        setState(() {});
        String texto = "CEP inválido";
        return texto;
      } else {
        return "CEP inválido";
      }
    } else {
      return "CEP vazio";
    }
  }
//Validador do CEP 
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        //brightness: Brightness.dark,
        // backgroundColor: azulMtEscuro,
        title: Text(
          "Complete seu cadastro",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.loose,
          overflow: Overflow.visible,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 5 / 100,
                left: 30,
                right: 30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Insira suas informações de contato e endereço.",
                      style: TextStyle(
                        fontSize: 26,
                        color: azulMtEscuro,
                      ),
                    ),
                    TextFormField(
                      controller: txtTelefone,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value.isEmpty ? 'Digite seu telefone' : null,
                      inputFormatters: [formaterTelefone],
                      decoration: InputDecoration(
                        labelText: "Telefone",
                      ),
                    ),
                    TextFormField(
                      controller: txtCep,
                      keyboardType: TextInputType.phone,                     
                      inputFormatters: [formaterCep],
                      decoration: InputDecoration(
                        labelText: "CEP",
                      ),                 
                      onChanged: (cep) {
                        buscaCep(cep);
                      },
                      validator: (value) => validaCep(retorno),
                    ),
                    Container(
                        child: Column(children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Endereco",
                        ),
                        controller: txtrua,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Número",
                        ),
                        controller: txtNumCasa,
                        onChanged: (value) {
                          resultCepMap['numero'] = value;
                          print(resultCepMap);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Complemento",
                        ),
                        controller: txtComplemento,
                        onChanged: (value) {
                          resultCepMap['complemento'] = value;
                          print(resultCepMap);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Bairro",
                        ),
                        controller: txtBairro,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Município",
                        ),
                        controller: txtMunicipio,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Estado",
                        ),
                        controller: txtEstado,
                      ),
                    ])),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 50),
                      child: RaisedButton(
                        visualDensity: VisualDensity.standard,
                        elevation: 6,
                        color: Color(0xff080626),
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(900.0),
                          side: BorderSide(
                            color: Color(0xff080626),
                            width: 4,
                          ),
                        ),
                        child: Container(
                          width: 150,
                          height: 48,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Avançar",
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  LineAwesomeIcons.arrow_right,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          //Passando informação de uma pagina para outra
                          if (_formKey.currentState.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => EscolheCategoriaView(
                                      nomeCompleto: widget.nomeCompleto,
                                      senha: widget.senha,
                                      email: widget.email,
                                      telefone: txtTelefone.text,
                                      endereco: resultCepMap,
                                      datanasc: widget.datanasc,
                                      cpf: widget.cpf,
                                      fotoPerfil: widget.fotoPerfil,
                                    )),
                              ),
                            );
                          }    
                          //Passando informação de uma pagina para outra                   
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
