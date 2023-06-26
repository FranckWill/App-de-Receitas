import 'package:flutter/material.dart';
import 'provider_usuario.dart';
import 'usuario.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {

  @override
  Widget build(BuildContext context) {
    Usuario usr = Provider.of<UsuarioProvider>(context, listen: true).usuario;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(usr.avatar!),
                  ),
                  ListTile(
                    title: Text(usr.nome!),
                    subtitle: Text(usr.email!),
                  )
                ],
              )
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/home");
            },
            leading: const Icon(Icons.image),
            title: const Text("Receitas"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/telausuario");
            },
            leading: const Icon(Icons.account_box),
            title: const Text("Usuário"),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/");
            },
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
          ),
        ],
      ),
    );
  }
}

