import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//TODO:: Preciso implementar o método de login antes de fazer essa tabela, senão vou perder acesso a algumas contas.

String table = "CREATE TABLE saved_users(id VARCHAR(11) NOT NULL, name VARCHAR(), fullName VARCHAR(80))";

Future<Database> getDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'saved_accounts.db');

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(table);
  });

  return database;
}

void removeDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'saved_accounts.db');
  deleteDatabase(path);
}
