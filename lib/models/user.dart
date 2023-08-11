import 'package:sqflite/sqflite.dart';
import '../database/users_database.dart';
import 'package:uuid/uuid.dart';

class User {
  String id;
  String name;
  String lastName;
  String fullname;
  String email;
  String password;
  DateTime dateOfBirth;
  DateTime lastSeen;

  User({
    required this.name,
    required this.lastName,
    required this.fullname,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.lastSeen,
  }) : id = const Uuid().v1();

  // Adicionar novo usuário ao banco de dados
  Future<bool> addUser() async {
    var db = await getDatabase();
    try {
      var count = await db.insert('users', {
        'id': id,
        'name': name,
        'lastName': lastName,
        'fullname': fullname, 
        'email': email,
        'password': password,
        'dateOfBirth': "$dateOfBirth",
        'lastSeen': "$lastSeen"
      });
      print(count);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List<User>> getUsers() async {
    Database db = await getDatabase();
    var list = await db.query('users');
    await Future.delayed(const Duration(milliseconds: 500));
    print(list);
    return toList(list);
  }

  static Future<bool> deleteUser(String id) async {
    Database db = await getDatabase();
    // List<String> IDs = id.split('-');
    // String userId = "";
    // for (int i = 0; i < IDs.length; i++) {
    //   if (i != (IDs.length - 1)) {
    //     userId += "${IDs[i]}\n";
    //   } else {
    //     userId += IDs[i];
    //   }
    // }
    try {
      // var count = await db.delete('users', where: 'name = ?', whereArgs: [id]);
      db.execute('DELETE FROM users WHERE id = "$id"');
      // print(count);
      return true;
    } catch (e) {
      print(e.toString());
      print(id);

      return false;
    }
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

  //Transforma nosso mapa vindo do banco em um lista de users para a nossa aplicação.
  static List<User> toList(List<Map<String, dynamic>> mapOfAccounts) {
    final List<User> accounts = [];
    for (Map<String, dynamic> item in mapOfAccounts) {
      final User account = User(
          name: item["name"],
          lastName: item["lastName"],
          fullname: item["fullName"],
          email: item["email"],
          password: item["password"],
          dateOfBirth: DateTime.parse(item["dateOfBirth"]),
          lastSeen: DateTime.parse(item["dateOfBirth"]));
      accounts.add(account);
    }
    return accounts;
  }
}
