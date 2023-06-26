class Usuario{
  int? id;
  String? nome;
  String? email;
  String? login;
  String? senha;
  String? avatar;

  Usuario({this.id, this.nome, this.email, required this.login, required this.senha, this.avatar});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'nome' : nome,
      'email' : email,
      'login' : login,
      'senha' : senha,
      'avatar' : avatar,
    };
  }
}