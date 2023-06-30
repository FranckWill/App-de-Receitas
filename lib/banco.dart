import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'receita.dart';
import 'usuario.dart';

class BancoDeDados {
  Future<Database>? database;

  Future<void> criarBanco() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'bancoreceita.db'),
      onCreate: (db, version){
        return db.transaction((txn) async {
          await txn.execute('CREATE TABLE receitas(id INTEGER PRIMARY KEY, titulo TEXT, imagemUrl TEXT, ingredientes TEXT, instrucoes TEXT, favorito INTEGER DEFAULT 0, id_usuario INTEGER)');
          await txn.execute('CREATE TABLE usuario(id INTEGER PRIMARY KEY, nome TEXT, email TEXT, avatar TEXT, login TEXT, senha TEXT)');
          await txn.rawInsert('INSERT INTO usuario (nome, email, login, senha, avatar) VALUES (?, ?, ?, ?, ?)', ['Frank', 'frank@gmail.com', 'frank', '123456', 'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg']);
        });
      },
      version: 1,
    );
  }

  Future<void> inserirReceita(Receita rec) async {
    final db = await database;

    db!.insert("receitas", rec.toMap());
  }

  Future<void> inserirReceitaUsuario(Receita rec, int id_usuario) async {
    final db = await database;

    db!.rawInsert('INSERT INTO receitas (titulo, imagemUrl, ingredientes, instrucoes, id_usuario) VALUES (?, ?, ?, ?, ?)', [rec.titulo, rec.imagemUrl, rec.ingredientes, rec.instrucoes, id_usuario]);
  }

  Future<List<Receita>> listarReceitas(int id_usuario) async{
    final db = await database;

    final List<Map<String, dynamic>> map = await db!.query('receitas', where: 'id_usuario = ?', whereArgs: [id_usuario]);
    return List.generate(map.length,
            (index) {
          return Receita(
            id: map[index]['id'],
            imagemUrl: map[index]['imagemUrl'],
            titulo: map[index]['titulo'],
            ingredientes: map[index]['ingredientes'],
            instrucoes: map[index]['instrucoes'],
            favorito: map[index]['favorito'],
          );
        }
    );
  }

  Future<List<Receita>> listarReceitasFavoritas(int id_usuario) async{
    final db = await database;

    final List<Map<String, dynamic>> map = await db!.query('receitas', where: 'id_usuario = ? and favorito = ?', whereArgs: [id_usuario, 1]);

    return List.generate(map.length,
            (index) {
          return Receita(
            id: map[index]['id'],
            imagemUrl: map[index]['imagemUrl'],
            titulo: map[index]['titulo'],
            ingredientes: map[index]['ingredientes'],
            instrucoes: map[index]['instrucoes'],
            favorito: map[index]['favorito'],
          );
        }
    );
  }

  Future<void> removerReceita(int id) async {
    final db = await database;

    await db!.delete("receitas", where: "id = ?", whereArgs: [id]);
  }

  Future<void> atualizarReceita(Receita rec) async{
    final db = await database;

    await db!.update("receitas",
        rec.toMap(),
        where: 'id = ?',
        whereArgs: [rec.id]
    );
  }

  Future<Receita> obterReceita(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db!.query("receitas", where: "id = ?", whereArgs: [id]);

    Receita? rec;
    if(maps.isNotEmpty){
      rec = Receita(
          id: maps.first['id'],
          imagemUrl: maps.first['imagemUrl'],
          titulo: maps.first['titulo'],
          ingredientes: maps.first['ingredientes'],
          instrucoes: maps.first['instrucoes']
      );
    }
    return rec!;
  }

  Future<Usuario?> autenticacao(login, senha) async{

    final db = await database;

    List<Map<String, dynamic>> map = await db!.query("usuario", where: "login = ? and senha = ?", whereArgs: [login, senha]);

    if(map.isNotEmpty) {
      return Usuario(
        id: map[0]['id'],
        nome: map[0]['nome'],
        email: map[0]['email'],
        login: map[0]['login'],
        senha: map[0]['senha'],
        avatar: map[0]['avatar'],
      );
    }else {
      return null;
    }
  }

  Future<List<Usuario>> listarUsuarios() async{
    final db = await database;
    final List<Map<String, dynamic>> map = await db!.query("usuario");

    return List.generate(map.length,
            (index) {
          return Usuario(
            id: map[index]['id'],
            nome: map[index]['nome'],
            email: map[index]['email'],
            login: map[index]['login'],
            senha: map[index]['senha'],
            avatar: map[index]['avatar'],
          );
        }
    );
  }

  Future<void> inserirUsuario(Usuario usr) async {
    final db = await database;
    usr.id = DateTime.now().millisecondsSinceEpoch;

    db!.insert("usuario", usr.toMap());
  }

  Future<void> removerUsuario(int id) async {
    final db = await database;
    await db!.delete("usuario", where: "id = ?", whereArgs: [id]);
  }

  Future<void> atualizarUsuario(Usuario usr) async {
    final db = await database;
    await db!.update(
      "usuario",
      usr.toMap(),
      where: 'id = ?',
      whereArgs: [usr.id],
    );
  }

}
