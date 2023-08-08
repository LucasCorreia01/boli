import 'package:sqflite/sqflite.dart';
import '../database/users_dao.dart';
import 'package:uuid/uuid.dart';

class User {
  String id;
  String name;
  String lastName;
  String email;
  String password;
  DateTime dateOfBirth;
  DateTime lastSeen;

  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.lastSeen,
  }) : id = const Uuid().v1();

  static addUser() async {
    var db = await getDatabase();
    try {
      await db.insert('users', {
        'id': 'idasdas',
        'name': 'Lucas',
        'lastName': 'Damasceno',
        'email': 'lucas@gmail.com',
        'password': 'senha123',
        'dateOfBirth': "${DateTime.now()}",
        'lastSeen': "${DateTime.now()}"
      });
    } catch (e) {
      print(e.toString());
    }
    //TODO:: método de adicionar novo usuário
  }

  static getUsers() async {
    Database db = await getDatabase();
    var list = await db.query('users');
    print(list);
  }

  static deleteUser() async {
    Database db = await getDatabase();
    var count =
        await db.delete('users', where: 'id = ?', whereArgs: ['idasdas']);
    print(count);
  }

  static removeDB() async {
    removeDatabase();
  }
}
