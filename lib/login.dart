import 'package:flutter/material.dart';
import 'provider_usuario.dart';
import 'package:provider/provider.dart';
import 'banco.dart';
import 'usuario.dart';

class TelaLogin extends StatefulWidget {

  BancoDeDados? bd;

  TelaLogin({Key? key, this.bd}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerAvatar = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  void autenticar(context, login, senha) async{
    Usuario? usr = await widget.bd!.autenticacao(login, senha);
    if(usr != null){
      Provider.of<UsuarioProvider>(context, listen: false).usuario = usr;
      Navigator.pushReplacementNamed(context, "/home");
    }else{
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text("Aviso"),
              content: const Text("Usuário não encontrado!"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")
                )
              ],
            );
          }
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset('images/receita.png'),
            ),
            Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controllerLogin,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Login"
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _controllerSenha,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Senha"
                      ),
                      obscureText: true,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          autenticar(context, _controllerLogin.text, _controllerSenha.text);
                        },
                        child: const Text("Entrar")
                    )
                  ],
                )
            ),
            ElevatedButton(
                onPressed: (){
                  adicionarNovoUsuario();
                },
                child: const Text("Cadastrar-se")
            )
          ],
        ),
      ),
    );
  }
}
