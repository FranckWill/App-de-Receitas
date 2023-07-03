import 'banco.dart';
import 'receita.dart';
import 'package:flutter/material.dart';

class DetalhesReceitaScreen extends StatefulWidget {
  Receita? rec;
  BancoDeDados? bd;

  DetalhesReceitaScreen({Key? key, this.rec, this.bd}) : super(key: key);

  @override
  State<DetalhesReceitaScreen> createState() => _DetalhesReceitaScreenState();
}

class _DetalhesReceitaScreenState extends State<DetalhesReceitaScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerImagemUrl = TextEditingController();
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerIngredientes = TextEditingController();
  TextEditingController _controllerInstrucoes = TextEditingController();

  formEditarImagem(context){
    _controllerImagemUrl.text = widget.rec!.imagemUrl;
    _controllerTitulo.text = widget.rec!.titulo;
    _controllerIngredientes.text = widget.rec!.ingredientes;
    _controllerInstrucoes.text = widget.rec!.instrucoes;

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Editar Receitas"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerImagemUrl,
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                              hintText: "Insira uma url",
                              labelText: "Url"
                          ),
                          validator: (imagemUrl){
                            if(imagemUrl == null || imagemUrl.isEmpty){
                              return "digite uma url";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerTitulo,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira um título",
                              labelText: "Título"
                          ),
                          validator: (titulo){
                            if(titulo == null || titulo.isEmpty){
                              return "Insira um título";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerIngredientes,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira um ingrediente",
                              labelText: "Ingrediente"
                          ),
                          validator: (ingrediente){
                            if(ingrediente == null || ingrediente.isEmpty){
                              return "Insira um ingrediente";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerInstrucoes,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira uma instrução",
                              labelText: "Instrução"
                          ),
                          validator: (instrucao){
                            if(instrucao == null || instrucao.isEmpty){
                              return "Insira uma instrução";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      widget.bd!.atualizarReceita(
                          Receita(
                              id: widget.rec!.id,
                              imagemUrl: _controllerImagemUrl.text,
                              titulo: _controllerTitulo.text,
                              ingredientes: _controllerIngredientes.text,
                              instrucoes: _controllerInstrucoes.text
                          )
                      );
                      Navigator.pop(context);
                    }
                    widget.rec = await widget.bd!.obterReceita(widget.rec!.id);
                    setState(() {
                      widget.rec;
                    });
                  },
                  child: const Text("Salvar")
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhe da receita"),
        actions: [
          IconButton(
              onPressed: (){
                formEditarImagem(context);
              },
              icon: const Icon(Icons.edit)
          ),
          IconButton(
              onPressed: (){
                Navigator.pop(context, widget.rec!.id);
              },
              icon: const Icon(Icons.delete)
          )
        ],
      ),
      body: ListView(
        children: [
          Image.network(widget.rec!.imagemUrl),
          ListTile(
            title: Text(widget.rec!.titulo, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text("Ingredientes", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            subtitle: Text(widget.rec!.ingredientes, style: const TextStyle(fontSize: 20)),
          ),
          ListTile(
            title: const Text("Instruções", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            subtitle: Text(widget.rec!.instrucoes, style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
