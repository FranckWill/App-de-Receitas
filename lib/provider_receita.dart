import 'package:flutter/foundation.dart';
import 'receita.dart';

class ReceitaProvider extends ChangeNotifier
{
  List<Receita> _receita = [];

  set receita(Receita rec){
    _receita.add(rec);

    notifyListeners();
  }

  set listaReceita(List<Receita> rec){
    _receita = rec;

    notifyListeners();
  }
  List<Receita> get listaReceita => _receita;
}