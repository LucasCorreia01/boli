import 'package:boli/database/savings_dabase.dart';
import 'package:boli/database/users_database.dart';
import 'package:boli/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class Savings {
  String id;
  String title;
  String description;
  int icon;
  String fullName;
  DateTime date;
  double balance;

  Savings({
    required this.title,
    required this.description,
    required this.icon,
    required this.fullName,
    required this.date,
    required this.balance,
  }) : id = const Uuid().v1();

  Future<bool> addSaving(User user) async {
    Database db = await getDatabaseSavings();
    try {
      await db.insert('savings', {
        'id': id,
        'title': title,
        'description': description,
        'icon': icon,
        'fullName': fullName,
        'date': "$date",
        'balance': balance,
      });
      Database userDb = await getDatabase();
      var mapUser = await userDb.query('users', where: 'fullName = ?', whereArgs: [user.fullname]);
      List<User> listUsers = toListUser(mapUser);
      double balanceUser = listUsers.first.balance;
      balanceUser = balanceUser - balance;
      userDb.update('users', where: 'fullName = ?', whereArgs: [user.fullname], {'balance': balanceUser});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static getAllSavings() async {
    Database db = await getDatabaseSavings();
    var savings = await db.query('savings');
    print(toList(savings));
    return toList(savings);
  }

  static Future<List<Savings>> getSavingsHome(String fullName) async {
    Database db = await getDatabaseSavings();
    var savings = await db.query('savings',
        where: "fullName = ?", whereArgs: [fullName], limit: 3, orderBy: 'date DESC');
    return toList(savings);
  }

  // Adicionar novo usuário - Salvando as informações entre os formulários sections
  static Map<String, String> savings = {};
  static void addAttr(String attr, String value) {
    savings[attr] = value;
  }

  static Map<String, String> getSavingsMap() {
    return savings;
  }

  static List<Savings> toList(List<Map<String, dynamic>> mapOfSavings) {
    final List<Savings> savings= [];
    for (Map<String, dynamic> item in mapOfSavings) {
      final Savings account = Savings(
        title: item["title"],
        description: item["description"],
        icon: item["icon"],
        fullName: item["fullName"],
        date: DateTime.parse(item['date']),
        balance: item['balance'],
      );
      savings.add(account);
    }
    return savings;
  }

  //Transforma nosso mapa vindo do banco em um lista de users para a nossa aplicação.
  static List<User> toListUser(List<Map<String, dynamic>> mapOfAccounts) {
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
          movedValue: item['movedValue']);
      accounts.add(account);
    }
    return accounts;
  }

  //Remove o banco de dados
  static removedb() async {
    removeDatabaseSavings();
  }

  //Apaga todas os registros da tabela
  static deleteAllSavings() async {
    Database db = await getDatabaseSavings();
    db.delete('savings');
  }
}
