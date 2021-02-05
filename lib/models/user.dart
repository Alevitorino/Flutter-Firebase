import 'dart:io';

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final File fotoUsuario;
  final String nome;
  final String datanacs;
  final String email;
  final String sobrenome;
  final Map categoria;
  final String cpf;
  final String telefone;
  //localização
  final Map endereco;
  //Profissão

  final String bio;
  UserData({
    this.uid,
    this.fotoUsuario,
    this.nome,
    this.datanacs,
    this.email,
    this.sobrenome,
    this.categoria,
    this.cpf,
    this.telefone,
    this.endereco,
    this.bio,
  });
}
