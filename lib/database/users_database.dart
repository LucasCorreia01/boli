import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String table =
    'CREATE TABLE users (id TEXT NOT NULL, name TEXT NOT NULL, lastName TEXT NOT NULL, fullName TEXT NOT NULL,  email TEXT NOT NULL, password TEXT NOT NULL, dateOfBirth DateTime NOT NULL, lastSeen DateTime NOT NULL)';

Future<Database> getDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'demo.db');

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(table);
  });

  return database;
}

void removeDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'demo.db');
  deleteDatabase(path);
}
