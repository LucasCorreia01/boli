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


  // Adicionar novo usuário ao banco de dados
  addUser() async {
    var db = await getDatabase();
    try {
      var count = await db.insert('users', {
        'id': id,
        'name': name,
        'lastName': lastName,
        'email': email,
        'password': password,
        'dateOfBirth': "$dateOfBirth",
        'lastSeen': "$lastSeen"
      });
    } catch (e) {
      print(e.toString());
    }
  }
  

  static Future<List<User>> getUsers() async {
    Database db = await getDatabase();
    var list = await db.query('users');
    return toList(list);
  }

  static deleteUser(String id) async {
    Database db = await getDatabase();
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  static deleteAllUsers() async {
    Database db = await getDatabase();
    await db.delete('users');
  }

  static removeDB() async {
    removeDatabase();
  }




  // Adicionar novo usuário - Salvando as informações entre os formulários sections
  static Map<String, String> user = {};
  static void addAttr(String attr, String value) {
    user[attr] = value;
  }
  static Map<String, String> getUserMap() {
    return user;
  }

    //Transforma nosso mapa vindo do banco em um lista de tarefas para a nossa aplicação.
  static List<User> toList(List<Map<String, dynamic>> mapOfAccounts) {
    final List<User> accounts = [];
    for (Map<String, dynamic> item in mapOfAccounts) {
      final User account = User(
        name: item["name"],
        lastName: item["lastName"],
        email: item["email"],
        password: item["password"],
        dateOfBirth: DateTime.parse(item["dateOfBirth"]),
        lastSeen: DateTime.parse(item["dateOfBirth"])
      );
      accounts.add(account);
    }
    // print(' Lista de tarefas: $tarefas');
    return accounts;
  }
  
}
