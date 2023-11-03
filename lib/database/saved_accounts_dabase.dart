import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


String table = "CREATE TABLE saved_users(id VARCHAR(11) NOT NULL, name VARCHAR(80) NOT NULL, lastName VARCHAR(80) NOT NULL, fullName VARCHAR(120) NOT NULL,  email VARCHAR(80) NOT NULL, password TEXT NOT NULL, dateOfBirth DateTime NOT NULL, lastSeen DateTime NOT NULL, balance FLOAT NOT NULL DEFAULT 0, movedValue FLOAT NOT NULL DEFAULT 0)";

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
