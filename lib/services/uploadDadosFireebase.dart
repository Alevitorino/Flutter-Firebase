class UploadDadosFirebase {
  
  final String nome;
  final String email;
  final String sobrenome;
  final Map categoria;
  final String cpf;
  final String telefone;
  //localização
  final Map endereco;
  //Profissão
  final String bio;
  UploadDadosFirebase({
    
    this.nome,
    this.email,
    this.sobrenome,
    this.categoria,
    this.cpf,
    this.telefone,
    this.endereco,
    this.bio,
  });
}