import 'package:flutter/material.dart';
import 'provider_usuario.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'receita.dart';

class FavoritoReceitas extends StatefulWidget {
  BancoDeDados? bd;

  FavoritoReceitas({Key? key, this.bd}) : super(key: key);

  @override
  State<FavoritoReceitas> createState() => _FavoritoReceitasState();
}

class _FavoritoReceitasState extends State<FavoritoReceitas> {
  List<Receita> listarec = [];

  Future<void> carregarReceitasFavoritas() async {
    listarec = await widget.bd!.listarReceitasFavoritas(Provider.of<UsuarioProvider>(context, listen: false).usuario.id!);
    setState(() {
      listarec;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarReceitasFavoritas();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: listarec.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(listarec[index].titulo),
          subtitle: Text(listarec[index].ingredientes),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(listarec[index].imagemUrl),
          ),
        );
      },
    );
  }
}
