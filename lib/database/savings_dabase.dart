import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String table = "CREATE TABLE savings (id VARCHAR(11) NOT NULL, title VARCHAR(80) NOT NULL, description VARCHAR(80) NOT NULL, icon INT NOT NULL, fullName VARCHAR(80) NOT NULL, date DateTime NOT NULL DEFAULT CURRENT_TIMESTAMP, balance FLOAT NOT NULL)";

Future<Database> getDatabaseSavings() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'savings.db');

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // Caso o banco ainda não exista, eele cria um novo e adiciona a tabela
    await db.execute(table);
  });

  return database;
}


void removeDatabaseSavings() async{
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'saving.db');
  deleteDatabase(path);
}