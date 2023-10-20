import 'package:lista_de_contatos/helper/DatabaseHelper.dart';
import 'package:lista_de_contatos/modelos/Contato.dart';

class ContatoDAO {
  // acessar banco de dados
  DatabaseHelper _db = DatabaseHelper();
  static final String nomeTabela = "contatos";

  // salvar informações no banco de dados
  Future<dynamic> salvarContato(Contato contato) async {
    var bancoDados = await _db.db;
    dynamic resultado = await bancoDados.insert(nomeTabela, contato.toMap());
    return resultado;
  }

  // recuperar informações no banco de dados
  recuperarContato() async {
    var bancoDados = await _db.db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY nome ASC";
    List contato = await bancoDados.rawQuery(sql);
    return contato;
  }

  // recuperar informações no banco de dados
  recuperarUmContato(dynamic id) async {
    var bancoDados = await _db.db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY nome ASC";
    List contato = await bancoDados.rawQuery(sql);
    return contato;
  }

  // deletar informações no banco de dados
  Future<dynamic> removerContato(dynamic id) async {
    var bancoDados = await _db.db;
    return await bancoDados
        .delete(nomeTabela, where: "id = ?", whereArgs: [id]);
  }

  // atualizar informações no banco de dados
  Future<dynamic> atualizarContato(Contato contato) async {
    var bancoDados = await _db.db;
    return await bancoDados.update(nomeTabela, contato.toMap(),
        where: "id = ?", whereArgs: [contato.id]);
  }
}
