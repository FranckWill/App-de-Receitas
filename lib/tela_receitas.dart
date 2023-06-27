import 'package:flutter/material.dart';
import 'provider_receita.dart';
import 'provider_usuario.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'receita.dart';
import 'detalhe_receita.dart';

class TelaReceita extends StatefulWidget {
  BancoDeDados? bd;

  TelaReceita({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaReceita> createState() => _TelaReceitaState();
}

class _TelaReceitaState extends State<TelaReceita> {

  List<Receita> rec = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerImagemUrl = TextEditingController();
  final TextEditingController _controllerTitulo = TextEditingController();
  final TextEditingController _controllerIngredientes = TextEditingController();
  final TextEditingController _controllerInstrucoes = TextEditingController();
  int cont = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarReceitas();
  }

  Future<void> carregarReceitas() async {
    rec = await widget.bd!.listarReceitas(Provider.of<UsuarioProvider>(context, listen: false).usr!.id!);
    carregarProvider();
    setState(() {
      rec;
    });
  }

  void carregarProvider(){
    Provider.of<ReceitaProvider>(context, listen: false).listaReceita = rec;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: () async {
                  final id = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetalhesReceitaScreen(rec: rec[cont], bd: widget.bd,)
                      )
                  );
                  if(id != null){
                    widget.bd!.removerReceita(id);
                    cont--
                  }
                  carregarReceitas();
                },
                child: rec.isEmpty ? const Text("carregando") : Image.network(rec[cont].imagemUrl)
            ),
            rec.isEmpty ? const Text("carregando") : Text(rec[cont].titulo,
              style: const TextStyle(
                  fontSize: 18
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      setState((){
                        if(cont > 0) {
                          cont = cont - 1;
                        }
                      });
                    },
                    child: const Text("<<")
                ),
                const SizedBox(width: 25,),
                ElevatedButton(
                    onPressed: (){
                      setState((){
                        if(cont < rec.length-1) {
                          cont = cont + 1;
                        }
                      });
                    },
                    child: const Text(">>")
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (contexto){
                return AlertDialog(
                  title: const Text("Inserir nova receita"),
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
                                validator: (url){
                                  if(url == null || url.isEmpty){
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
                                validator: (ingred){
                                  if(ingred == null || ingred.isEmpty){
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
                                    labelText: "Instruções"
                                ),
                                validator: (inst){
                                  if(inst == null || inst.isEmpty){
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
                            await widget.bd!.inserirReceitaUsuario(
                                Receita(
                                    imagemUrl:
                                    _controllerImagemUrl.text,
                                    titulo:
                                    _controllerTitulo.text,
                                    ingredientes:
                                    _controllerIngredientes.text,
                                    instrucoes:
                                    _controllerInstrucoes.text,
                                    favorito: 0
                                ),
                                Provider.of<UsuarioProvider>(context, listen: false).usr!.id!
                            );
                            await carregarReceitas();
                            _controllerImagemUrl.clear();
                            _controllerTitulo.clear();
                            _controllerIngredientes.clear();
                            _controllerInstrucoes.clear();

                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Salvar")
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
