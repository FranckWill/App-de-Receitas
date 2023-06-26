import 'package:flutter/cupertino.dart';
import 'usuario.dart';

class UsuarioProvider extends ChangeNotifier{

  Usuario? usr;

  set usuario (Usuario usr){
    this.usr = usr;

    notifyListeners();
  }

  Usuario get usuario => usr!;
}