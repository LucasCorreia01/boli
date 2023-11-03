import 'package:boli/database/saved_accounts_dabase.dart';
import 'package:sqflite/sqflite.dart';

class SavedAccounts {
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

  SavedAccounts({
    required this.id,
    required this.name,
    required this.lastName,
    required this.fullname,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.lastSeen,
    required this.balance,
    required this.movedValue,
  });

  newAccountSave() async {
    Database db = await getDatabase();
    await db.insert('saved_users', {
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
    print('estamos aqui');
  }

  static removeDB() async {
    removeDatabase();
  }

  static Future<List<SavedAccounts>> getAllUsers() async {
    Database db = await getDatabase();
    var list = await db.query('saved_users');
    return toList(list);
  }

  //Seleciona o usuário com base no nome
  static Future<dynamic> selectInitUser(String? fullName) async {
    Database db = await getDatabase();
    try {
      var user =
          await db.query('users', where: 'fullName = ?', whereArgs: [fullName]);
      return toList(user);
    } catch (e) {
      print('Um erro aconteceu na aplicação');
    }
  }

  static Future<bool> deleteUser(String fullName) async {
    Database db = await getDatabase();
    try {
      await db.delete('saved_users', where: 'fullName = ?', whereArgs: [fullName]);
      return true;
    } catch (e) {
      return false;
    }
  }

  //Transforma nosso mapa vindo do banco em um lista de users para a nossa aplicação.
  static List<SavedAccounts> toList(List<Map<String, dynamic>> mapOfAccounts) {
    final List<SavedAccounts> accounts = [];
    for (Map<String, dynamic> item in mapOfAccounts) {
      print(item);
      final SavedAccounts account = SavedAccounts(
        id: item["id"],
        name: item["name"],
        lastName: item["lastName"],
        fullname: item["fullName"],
        email: item["email"],
        password: item["password"],
        dateOfBirth: DateTime.parse(item['dateOfBirth']),
        lastSeen: DateTime.parse(item["lastSeen"]),
        balance: item["balance"],
        movedValue: item['movedValue'],
      );
      accounts.add(account);
    }
    return accounts;
  }
}
