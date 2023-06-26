class Receita {
  int? _id;
  String? _imagemUrl;
  String? _titulo;
  String? _ingredientes;
  String? _instrucoes;
  int? _favorito;

  Receita({int? id, required String? imagemUrl, required String? titulo, required String? ingredientes, required String? instrucoes, int? favorito}){
  _id = id;
  _imagemUrl = imagemUrl;
  _titulo = titulo;
  _ingredientes = ingredientes;
  _instrucoes = instrucoes;
  _favorito = favorito;
  }

  int get id => _id!;

  String get imagemUrl => _imagemUrl!;

  set imagemUrl(String value) {
    _imagemUrl = value;
  }

  String get titulo => _titulo!;

  set titulo(String value) {
    _titulo = value;
  }

  String get ingredientes => _ingredientes!;

  set ingredientes(String value) {
    _ingredientes = value;
  }

  String get instrucoes => _instrucoes!;

  set instrucoes(String value) {
    _instrucoes = value;
  }

  int get favorito => _favorito!;

  set favorito(int value) {
    _favorito = value;
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'imagemUrl' : _imagemUrl,
      'titulo' : _titulo,
      'ingredientes' : _ingredientes,
      'instrucoes' : _instrucoes,
      'favorito' : _favorito,
    };
  }
}