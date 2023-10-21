class Contato {
  // define tudo que um Contato vai ter
  dynamic? id;
  String nome = "";
  String telefone = "";
  String email = "";
  String urlImagem = "";

  Contato(this.id, this.nome, this.telefone, this.email, this.urlImagem);

  // transforma dados de um Map para um Contato
  Contato.fromMap(Map map) {
    id = map["id"];
    nome = map["nome"];
    telefone = map["telefone"];
    email = map["email"];
    urlImagem = map["urlImagem"];
  }

  // transforma dados de um Contato para um Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": nome,
      "telefone": telefone,
      "email": email,
      "urlImagem": urlImagem,
    };

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
