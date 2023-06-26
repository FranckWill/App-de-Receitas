import 'package:flutter/material.dart';
import 'provider_receita.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'receita.dart';
import 'detalhe_receita.dart';

class ListagemReceitas extends StatefulWidget {
  BancoDeDados? bd;

  ListagemReceitas({Key? key, this.bd}) : super(key: key);

  @override
  State<ListagemReceitas> createState() => _ListagemReceitasState();
}

class _ListagemReceitasState extends State<ListagemReceitas> {

  List<Receita> listarec = [];
  int? favorito;

  void atualizarFavorito(context, Receita rec){
    if(rec.favorito == 1){
      rec.favorito = 0;
    }else{
      rec.favorito = 1;
    }
    widget.bd!.atualizarReceita(rec);
  }

  @override
  Widget build(BuildContext context) {

    listarec = Provider.of<ReceitaProvider>(context, listen: true).listaReceita;

    return ListView.builder(
      itemCount: listarec.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(listarec[index].titulo),
          subtitle: Text(listarec[index].ingredientes),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(listarec[index].imagemUrl),
          ),
          trailing: IconButton(
            onPressed: (){
              setState(() {
                atualizarFavorito(context, listarec[index]);
              });
            },
            icon: listarec[index].favorito == 1 ? const Icon(Icons.star, color: Colors.blue,) : const Icon(Icons.star_border) ,
          ),
          onTap: ()async {
            final id = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetalhesReceitaScreen(rec: listarec[index], bd: widget.bd,)
                )
            );
            if(id != null){
              widget.bd!.removerReceita(id);
            }
          },
        );
      },
    );
  }
}
