import 'dart:convert';

class CepModel {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;
  bool exibeCampos;
  bool erro;

  CepModel(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.exibeCampos,
      this.unidade,
      this.ibge,
      this.gia,
      this.erro});

  factory CepModel.fromJson(String str) => CepModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CepModel.fromMap(Map<String, dynamic> json) => CepModel(
        cep: json["cep"],
        logradouro: json["logradouro"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        localidade: json["localidade"],
        uf: json["uf"],
        unidade: json["unidade"],
        ibge: json["ibge"],
        gia: json["gia"],
        erro: json["erro"],
      );

  Map<String, dynamic> toMap() => {
        "cep": cep,
        "logradouro": logradouro,
        "complemento": complemento,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
        "unidade": unidade,
        "ibge": ibge,
        "gia": gia,
        "erro": erro,
      };
}
