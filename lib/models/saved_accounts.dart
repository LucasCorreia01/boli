import 'package:boli/database/saved_accounts_dabase.dart';
import 'package:sqflite/sqflite.dart';

class SavedAccounts {
  String id;
  String name;
  String lastName;
  String fullName;
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
    required this.fullName,
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
      'fullName': fullName,
      'email': email,
      'password': password,
      'dateOfBirth': "$dateOfBirth",
      'lastSeen': "$lastSeen",
      'balance': balance,
      'movedValue': movedValue
    });
  }

  static removeDB() async {
    removeDatabase();
  }

  static Future<List<SavedAccounts>> getAllUsers() async {
    Database db = await getDatabase();
    var list = await db.query('saved_users');
    return toList(list);
  }

  static updateInfo(String id, String attr, String value) async {
    Database db = await getDatabase();

    if (attr == 'fullName') {
      List<String> name = value.trim().split(" ");
      db.update('saved_users', {"name": name[0]},
          where: 'id = ?', whereArgs: [id]);
      db.update('saved_users', {"lastName": name[name.length - 1]},
          where: 'id = ?', whereArgs: [id]);
      db.update('saved_users', {"fullName": value},
          where: 'id = ?', whereArgs: [id]);
    } else {
      await db.update(
        'saved_users',
        {attr: value},
        where: 'id = ?',
        whereArgs: [id],
      );
    }
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
      await db
          .delete('saved_users', where: 'fullName = ?', whereArgs: [fullName]);
      return true;
    } catch (e) {
      return false;
    }
  }

  //Transforma nosso mapa vindo do banco em um lista de users para a nossa aplicação.
  static List<SavedAccounts> toList(List<Map<String, dynamic>> mapOfAccounts) {
    final List<SavedAccounts> accounts = [];
    for (Map<String, dynamic> item in mapOfAccounts) {
      List<String> name = item["fullName"].trim().split(' ');
      final SavedAccounts account = SavedAccounts(
        id: item["id"],
        name: name[0],
        lastName: name[name.length - 1],
        fullName: item["fullName"],
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
