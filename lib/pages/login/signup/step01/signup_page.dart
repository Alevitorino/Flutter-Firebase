import 'dart:io';
import 'package:autonomo_app/controllers/image_controller.dart';
import 'package:autonomo_app/pages/login/signup/step01/signup_page_controller.dart';
import 'package:autonomo_app/pages/login/signup/step02/signup_view2.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:autonomo_app/components/testePlanodeFundo.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:page_transition/page_transition.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    Key key,
  }) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

// Controlador de texto
TextEditingController txtNomeCompleto = new TextEditingController();
TextEditingController txtEmail = new TextEditingController();
TextEditingController txtSenha = new TextEditingController();
TextEditingController txtDataNasc = new TextEditingController();
TextEditingController txtCpf = new TextEditingController();
// Controlador de texto

// Variavel de data de nascimento
DateTime txtNewDataNasc;
// Variavel de data de nascimento

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  //Animação variavel
  AnimationController _animationController;
  Animation _animation;
  //Animação variavel

  final User user = User();

  // Alterna o foco conforme digita
  final focusEmail = FocusNode();
  final focusSenha = FocusNode();
  final focusDataNasc = FocusNode();
  final focusCPF = FocusNode();
  // Alterna o foco conforme digita

  //Instancias
  final UserData userData = UserData();
  final GetImageController _imageGet = GetImageController();
  //Instancias

  // Form key
  final _formKey = GlobalKey<FormState>();
  // Form key

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    focusEmail.dispose();
  }

  // Mascarando texto
  var dataFormater = new MaskTextInputFormatter(mask: '##/##/####');
  var cpfFormater = new MaskTextInputFormatter(mask: '###.###.###-##');
  // Mascarando texto

  // Botão para ver a senha
  bool _verSenha = true;
  // Botão para ver a senha

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
          title: Text(
            "Dados pessoais",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Stack(fit: StackFit.loose, overflow: Overflow.visible, children: [
            Positioned(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  color: Color(0xff080626),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 2 / 100,
                          left: 30,
                          right: 30,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 0, right: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    _imageGet.getImageGallery();
                                  },
                                  child: Stack(
                                    children: [
                                      StreamBuilder(
                                      stream: _imageGet.output,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return CircleAvatar(
                                            radius: 110,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: CircleAvatar(
                                              onBackgroundImageError:
                                                  (exception, stackTrace) => {},
                                              radius: 100,
                                              backgroundImage: FileImage(
                                                  File(snapshot.data.path)),
                                            ),
                                          );
                                        } else {
                                          return CircleAvatar(
                                            radius: 110,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: CircleAvatar(
                                              onBackgroundImageError:
                                                  (exception, stackTrace) => {},
                                              radius: 100,
                                              backgroundImage: AssetImage(
                                                  'lib/images/icons/profile.png'),
                                            ),
                                          );
                                        }
                                      }),
                                       Positioned(
                                        bottom: -5,
                                        right: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            _imageGet
                                                .getImageCamera();
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: CircleAvatar(
                                              radius: 24,
                                              backgroundImage: AssetImage(
                                                  "lib/images/icons/fotoAvatar.png"),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                    
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: TextFormField(
                                    controller: txtNomeCompleto,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusEmail);
                                    },
                                    validator:
                                        SignupPageController().validarNome,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      labelText: "Nome completo",
                                      prefixIcon: Icon(LineAwesomeIcons.user),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: TextFormField(
                                    focusNode: focusEmail,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusSenha);
                                    },
                                    controller: txtEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon:
                                          Icon(LineAwesomeIcons.envelope_1),
                                    ),
                                    validator:
                                        SignupPageController().validarEmail,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  child: TextFormField(
                                    focusNode: focusSenha,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusDataNasc);
                                    },
                                    controller: txtSenha,
                                    keyboardType: TextInputType.text,
                                    obscureText: _verSenha,
                                    decoration: InputDecoration(
                                      labelText: "Senha",
                                      prefixIcon: Icon(LineAwesomeIcons.key),
                                      suffixIcon: IconButton(
                                        icon: _verSenha
                                            ? Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_eye_show_regular,
                                              )
                                            : Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_eye_hide_regular,
                                                color: Colors.red,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            _verSenha = !_verSenha;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) => value.length < 6
                                        ? 'A senha é muito curta'
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Container(
                                  child: TextFormField(
                                    validator: (value) => value.isEmpty
                                        ? 'Selecione sua data de nascimento'
                                        : null,
                                    focusNode: focusDataNasc,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusCPF);
                                    },
                                    controller: txtDataNasc,
                                    inputFormatters: [dataFormater],
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime(1995),
                                        firstDate: DateTime(1970),
                                        lastDate: DateTime(2021),
                                      ).then((value) {
                                        setState(() {
                                          txtDataNasc.text =
                                              DateFormat('dd/MM/y', 'pt_BR')
                                                  .format(value)
                                                  .toString();
                                        });
                                        txtNewDataNasc = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Data de nascimento",
                                      prefixIcon:
                                          Icon(LineAwesomeIcons.calendar),
                                      hintText: 'Data não selecionada',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  child: TextFormField(
                                    focusNode: focusCPF,
                                    controller: txtCpf,
                                    validator: (value) {
                                      if (CPFValidator.isValid(value)) {
                                        print(value + ' ok');
                                        return null;
                                      } else {
                                        return 'CPF inválido';
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [cpfFormater],
                                    decoration: InputDecoration(
                                      labelText: "CPF",
                                      prefixIcon: Icon(
                                        FluentSystemIcons
                                            .ic_fluent_patient_regular,
                                      ),
                                      fillColor: Colors.red,
                                      hoverColor: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 28.0, bottom: 30),
                                child: GestureDetector(
                                  child: Container(
                                    width: 180,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          offset: Offset(0, 4),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      border: Border.all(
                                        color:Color(0xff080626),
                                        width: 4.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(900.0)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [
                                          0.1,
                                          1,
                                        ],
                                        colors: [
                                          Color(0xff080626),
                                          Color(0xff080626)
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              LineAwesomeIcons.arrow_right,
                                              size: 28,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (_imageGet.iimage!= null) {
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                type: PageTransitionType.fade,
                                                child: SignupPage2(
                                              nomeCompleto:txtNomeCompleto.text,
                                              cpf: txtCpf.text,
                                              datanasc: txtNewDataNasc,
                                              email: txtEmail.text,
                                              fotoPerfil: _imageGet.iimage,
                                              senha: txtSenha.text,
                                                )));
                                      }
                                    } else {
                                      return SignupPageController()
                                          .alertUnselectedImage(context);
                                    }
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
              ],
            ),
          ]),
        ));
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Animation>('_animation', _animation));
  }
}
