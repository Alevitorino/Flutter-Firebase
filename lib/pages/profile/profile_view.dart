
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/styles/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as prefix0;

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final _formkey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  TextEditingController txtEndereco = new TextEditingController();

  dynamic fotoNova;


  brilhoApp() {
    String temaApp = Theme.of(context).brightness.toString();
    if (temaApp == "Brightness.dark") {
      return true;
    } else {
      return false;
    }
  }

//Pegando dados do usuario
  getAllDados() {
    final user = Provider.of<User>(context);
    dynamic dados = DatabaseService(uid: user.uid).userData;
    return dados;
  }
//Pegando dados do usuario

  corApp() => brilhoApp() ? Colors.grey[700] : Colors.red;

  @override
  void initState() {
    super.initState();
    getFotoPerfil();
  }

//Pegando foto do usuario 
  getFotoPerfil() async {
    final user = Provider.of<User>(context);
    final fotoPerfil = DatabaseService(uid: user.uid).getUserProfileImages();
    await fotoPerfil.then((value) {
      fotoNova = value;
    });
    return fotoNova;
  }
//Pegando foto do usuario 

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    return StreamBuilder(
      stream: getAllDados(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          String cep = userData.endereco.keys.join();
          String txtTelefone = userData.telefone;
          String txtBio = userData.bio;
          return Scaffold(            
            body: Container(            
              child: Stack(              
                children: [
                  BackdropFilter(
                    filter: prefix0.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                  Positioned(                  
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Container(                       
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                              0.155,
                              0.564,
                              1
                            ],
                                colors: [                             
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withAlpha(150),
                              Theme.of(context).scaffoldBackgroundColor,
                              Theme.of(context).scaffoldBackgroundColor,
                            ])),
                      ),
                    ),
                  ),
                  Container(                 
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 10,
                              left: 10,
                              right: 10,
                              //  bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 8),
                                  child: FutureBuilder<Object>(
                                      future: getFotoPerfil(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                          width: 120.0,
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF000000),
                                            image: new DecorationImage(
                                              image:NetworkImage(fotoNova),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(150.0)),
                                            border: Border.all(
                                              color: Color(0xff080626),
                                              width: 5.0,
                                            ),
                                          ),
                                        );
                                        } else {
                                          return Center(
                                            child: Loading(),
                                          );
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              userData.nome.split(" ")[0] +
                                                  " " +
                                                  userData.nome.split(" ")[1],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 2),
                                        child: Text(
                                            userData.email.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 2),
                                        child: Text(
                                            userData.telefone.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 2),
                                        child: Text(
                                            userData.bio.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                      RaisedButton(
                                        visualDensity: VisualDensity.compact,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        onPressed: () {
                                          _auth.SignOut();
                                        },
                                        color: Color(0xff080626),
                                        textColor: Colors.white,
                                        child: Text("Sair".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 2.0,
                                              fontWeight: FontWeight.w900,
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                         
                        ],
                      ),
                    ),
                  ),
                ],
                overflow: Overflow.visible,
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
