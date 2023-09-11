import 'package:boli/database/savings_dabase.dart';
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

  Future<bool> addSaving() async {
    Database db = await getDatabase();
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
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static getAllSavings() async {
    Database db = await getDatabase();
    var savings = await db.query('savings');
    print(toList(savings));
    return toList(savings);
  }

  static Future<List<Savings>> getSavingsHome(String fullName) async {
    Database db = await getDatabase();
    var savings = await db.query('savings',
        where: "fullName = ?", whereArgs: [fullName], limit: 3);
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

  //Remove o banco de dados
  static removedb() async {
    removeDatabase();
  }

  //Apaga todas os registros da tabela
  static deleteAllSavings() async {
    Database db = await getDatabase();
    db.delete('savings');
  }
}
