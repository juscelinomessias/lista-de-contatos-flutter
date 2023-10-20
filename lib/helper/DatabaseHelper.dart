import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // cria o Objeto da própria classe: _instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // (_db) o banco de dados só pode ser acessado pela classe DatabaseHelper
  Database? _db;

  // para pegar o Banco de dados basta colocar .db
  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  inicializarDB() async {
    // Caminho para o Banco de Dados
    final caminhoBancoDados = await getDatabasesPath();
    // Local onde está o Banco de Dados + Nome do Banco de Dados
    final localBancoDados = join(caminhoBancoDados, "contato.db");

    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    String sqlContatos = "CREATE TABLE contatos ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "nome VARCHAR, "
        "telefone VARCHAR, "
        "email VARCHAR, "
        "urlImagem VARCHAR)";

    await db.execute(sqlContatos);
  }
}
