import 'package:boli/screens/actions/receive_money.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';
import '../database/users_database.dart';

class User {
  String id;
  String name;
  String lastName;
  String fullname;
  String email;
  String password;
  DateTime dateOfBirth;
  DateTime lastSeen;
  double balance;
  double movedValue;

  User({
    required this.name,
    required this.lastName,
    required this.fullname,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.lastSeen,
    this.balance = 0,
    this.movedValue = 0,
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
        'lastSeen': "$lastSeen",
        'balance': balance,
        'movedValue': movedValue
      });
      return true;
    } catch (e) {
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
    try {
      print(id);
      var count = await db.delete('users', where: 'name = ?', whereArgs: [id]);
      print(count);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<dynamic> selectInitUser(String? name) async {
    Database db = await getDatabase();
    try {
      var user =
          await db.query('users', where: 'fullName = ?', whereArgs: [name]);
      return toList(user);
    } catch (e) {
      print(e);
    }
  }

  //Atualizar visto por último
  updateLastSeen() async {
    Database db = await getDatabase();
    var count = await db.update('users', {'lastSeen': '${DateTime.now()}'},
        where: 'id = ?', whereArgs: ['$id']);
    print(count);
  }

  receiveMoney(String value) async {
    Database db = await getDatabase();
    value = value.replaceAll('R\$', '');
    value = value.replaceAll(',', '.');
    double newBalance = double.parse(value);
    newBalance = newBalance + balance;
    var count = await db.update('users', {'balance': newBalance},
        where: 'name = ?', whereArgs: [name]);
    print(count);
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
        dateOfBirth: DateTime.parse(item['dateOfBirth']),
        lastSeen: DateTime.now(),
        balance: item["balance"],
        movedValue: item['movedValue']
      );
      accounts.add(account);
    }
    return accounts;
  }
}
