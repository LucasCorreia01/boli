import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String table = "CREATE TABLE extract (id VARCHAR(11) NOT NULL, fullNameReceiver VARCHAR(80) NOT NULL, fullNameSend VARCHAR(11) NOT NULL, date DateTime NOT NULL DEFAULT CURRENT_TIMESTAMP, value FLOAT NOT NULL)";

Future<Database> getDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'extract.db');

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // Caso o banco ainda não exista, ele cria um novo e adiciona a tabela
    await db.execute(table);
  });

  return database;
}

void removeDatabase() async{
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'extract.db');
  deleteDatabase(path);
}
