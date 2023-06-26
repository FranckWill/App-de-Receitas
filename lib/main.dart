import 'package:flutter/material.dart';
import 'provider_receita.dart';
import 'provider_usuario.dart';
import 'tela_receitas.dart';
import 'login.dart';
import 'tela_usuario.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'banco.dart';
import 'receita.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  BancoDeDados bd = BancoDeDados();
  await bd.criarBanco();
  print("Banco criado!!");
  await bd.inserirReceitaUsuario(Receita(
      imagemUrl: "https://cdn0.tudoreceitas.com/pt/posts/9/8/3/pizza_calabresa_e_mussarela_4389_600.jpg",
      titulo: "Pizza de Calabresa",
      ingredientes: "500 g de farinha de trigo, 25 g de fermento para pão, 1 copo de água, 1 ovo, 50 g de gordura, 1 colher de sopa de fermento em pó, 1 colher de café de sal, 300 g de tomate maduro, 50 g de queijo parmesão ralado, 1 colher de sopa de azeite de oliva, 300 g de linguiça calabresa defumada",
      instrucoes: "Bata o tomate no liquidificador com os demais ingredientes, Misture 50 g de farinha, fermento e um pouco de água, Deixe descansar por 20 minutos, Adicione os demais ingredientes e amasse até obter uma massa bem macia, Espalhe o molho de tomate por cima e leve para assar em forno pré-aquecido, a 180ºC, por 15 minutos, Retire e deixe esfriar, Espalhe a linguiça sobre o molho de tomate e cubra com a cebola, Retorne ao forno por mais 10 minutos, Retire do forno e sirva imediatamente."), 1);
  await bd.inserirReceitaUsuario(Receita(
      imagemUrl: "https://minervafoods.com/wp-content/uploads/2022/12/como_fazer_hamburguer_caseiro-1.jpg",
      titulo: "Hambúrguer Caseiro",
      ingredientes: "1 kg de carne moída, 1 cebola media picada, cebolinha a gosto, orégano a gosto, 1 sachê de creme de cebola, 4 dentes de alho picado, sal a gosto, pimenta a gosto.",
      instrucoes: "Misture todos os ingredientes, amasse bem e forme bolinhas, depois achate para ter a forma de hambúrguer, Frite numa frigideira antiaderente, coloque uma colher de óleo pois a carne não tem gordura."), 1);
  await bd.inserirReceitaUsuario(Receita(
      imagemUrl: "https://guiadacozinha.com.br/wp-content/uploads/2019/10/pudim-musse-de-maracuja-43170.jpg",
      titulo: "Mousse de maracujá",
      ingredientes: "1 lata de leite condensado, 1 lata de suco de maracujá (medida pela lata de leite condensado), 1 lata de creme de leite sem soro.",
      instrucoes: "Em um liquidificador, bata o creme de leite, o leite condensado e o suco concentrado de maracujá, Em uma tigela, despeje a mistura e leve à geladeira por, no mínimo, 4 horas."), 1);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ChangeNotifierProvider(create: (_) => ReceitaProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => TelaLogin(bd: bd,),
        "/home" : (context) => Home(bd: bd,),
        "/telausuario" : (context) => TelaUsuario(bd: bd,),
        "/telareceita" : (context) =>TelaReceita(bd: bd,),
      },
    ),
  ));
}