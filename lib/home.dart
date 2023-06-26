import 'package:flutter/material.dart';
import 'drawer.dart';
import 'tela_favorito_receita.dart';
import 'tela_receitas.dart';
import 'tela_listagem_receita.dart';
import 'banco.dart';

class Home extends StatefulWidget {
  BancoDeDados? bd;

  Home({Key? key, this.bd}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int barraNavegacaoIndex = 0;
  var telaReceita;
  var telaListagemReceitas;
  var telaFavoritoReceitas;

  List<Widget>? telas;

  @override
  Widget build(BuildContext context) {

    telaReceita = TelaReceita(bd: widget.bd,);
    telaListagemReceitas = ListagemReceitas(bd: widget.bd,);
    telaFavoritoReceitas = FavoritoReceitas(bd: widget.bd,);

    telas = [telaReceita, telaListagemReceitas, telaFavoritoReceitas];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Receitas"),
      ),
      drawer: const DrawerMenu(),
      body: Center(
        child: telas!.elementAt(barraNavegacaoIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: "receitas",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "listagem",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "favorito",
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: barraNavegacaoIndex,
        selectedItemColor: Colors.black,
        onTap: (index){
          setState(() {
            barraNavegacaoIndex = index;
          });
        },
      ),
    );
  }
}
