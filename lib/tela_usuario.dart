import 'package:flutter/material.dart';
import 'banco.dart';
import 'drawer.dart';
import 'usuario.dart';

class TelaUsuario extends StatefulWidget {

  BancoDeDados? bd;

  TelaUsuario({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaUsuario> createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {

  List<Usuario> listaUser = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerAvatar = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  Future<void> listarUsuarios() async {
    listaUser = await widget.bd!.listarUsuarios();
    setState(() {
      listaUser;
    });
  }

  void adicionarNovoUsuario(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Adicionar usuário"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerAvatar,
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                              hintText: "Insira uma url",
                              labelText: "Avatar"
                          ),
                          validator: (url){
                            if(url == null || url.isEmpty){
                              return "digite uma url";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerNome,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira um nome",
                              labelText: "Nome"
                          ),
                          validator: (nome){
                            if(nome == null || nome.isEmpty){
                              return "Insira um nome";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerEmail,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira um e-mail",
                              labelText: "E-mail"
                          ),
                          validator: (email){
                            if(email == null || email.isEmpty){
                              return "Insira um e-mail";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerLogin,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira um login",
                              labelText: "Login"
                          ),
                          validator: (login){
                            if(login == null || login.isEmpty){
                              return "Insira um login";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controllerSenha,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: "Insira uma senha",
                              labelText: "Senha"
                          ),
                          validator: (senha){
                            if(senha == null || senha.isEmpty){
                              return "Insira uma senha";
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
                      await widget.bd!.inserirUsuario(Usuario(
                        nome: _controllerNome.text,
                        email: _controllerEmail.text,
                        login: _controllerLogin.text,
                        senha: _controllerSenha.text,
                        avatar: _controllerAvatar.text,
                      ));
                      listarUsuarios();
                      _controllerAvatar.clear();
                      _controllerNome.clear();
                      _controllerEmail.clear();
                      _controllerLogin.clear();
                      _controllerSenha.clear();

                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Salvar")
              )
            ],
          );
        }
    );
  }

  void removerUsuario(Usuario usuario) async {
    await widget.bd!.removerUsuario(usuario.id!);
    listarUsuarios();
  }

  void editarUsuario(Usuario usuario) {
    _controllerAvatar.text = usuario.avatar!;
    _controllerNome.text = usuario.nome!;
    _controllerEmail.text = usuario.email!;
    _controllerLogin.text = usuario.login!;
    _controllerSenha.text = usuario.senha!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar usuário"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllerAvatar,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          hintText: "Insira uma url",
                          labelText: "Avatar",
                        ),
                        validator: (url) {
                          if (url == null || url.isEmpty) {
                            return "Digite uma url";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _controllerNome,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Insira um nome",
                          labelText: "Nome",
                        ),
                        validator: (nome) {
                          if (nome == null || nome.isEmpty) {
                            return "Insira um nome";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _controllerEmail,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Insira um e-mail",
                          labelText: "E-mail",
                        ),
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Insira um e-mail";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _controllerLogin,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Insira um login",
                          labelText: "Login",
                        ),
                        validator: (login) {
                          if (login == null || login.isEmpty) {
                            return "Insira um login";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _controllerSenha,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Insira uma senha",
                          labelText: "Senha",
                        ),
                        validator: (senha) {
                          if (senha == null || senha.isEmpty) {
                            return "Insira uma senha";
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await widget.bd!.atualizarUsuario(Usuario(
                    id: usuario.id,
                    nome: _controllerNome.text,
                    email: _controllerEmail.text,
                    login: _controllerLogin.text,
                    senha: _controllerSenha.text,
                    avatar: _controllerAvatar.text,
                  ));
                  listarUsuarios();
                  _controllerAvatar.clear();
                  _controllerNome.clear();
                  _controllerEmail.clear();
                  _controllerLogin.clear();
                  _controllerSenha.clear();

                  Navigator.pop(context);
                }
              },
              child: const Text("Salvar"),
            )
          ],
        );
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listarUsuarios();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuário"),
      ),
      drawer: const DrawerMenu(),
      body: ListView.builder(
          itemCount: listaUser.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(listaUser[index].avatar!)),
              title: Text(listaUser[index].nome!),
              subtitle: Text(listaUser[index].email!),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          editarUsuario(listaUser[index]);
                        },
                        icon: const Icon(Icons.edit,
                          color: Colors.blue,
                        )
                    ),
                    IconButton(
                        onPressed: (){
                          removerUsuario(listaUser[index]);
                        },
                        icon: const Icon(Icons.delete,
                          color: Colors.red,
                        )
                    ),
                  ],
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          adicionarNovoUsuario();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
