import 'package:boli/database/extract_account.dart';
import 'package:boli/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class ExtractAccount {
  String id;
  String fullNameReceiver;
  String fullNameSend;
  DateTime date;
  double value;

  ExtractAccount({
    required this.fullNameReceiver,
    required this.fullNameSend,
    required this.date,
    required this.value,
  }) : id = const Uuid().v1();

  newExtract() async {
    Database db = await getDatabase();
      var count = await db.insert('extract', {
        "id": id,
        "fullNameReceiver": fullNameReceiver,
        "fullNameSend": fullNameSend,
        "date": "$date",
        "value": value
      });
  }

  static Future<List<ExtractAccount>> getExtractAccount(User user) async {
    Database db = await getDatabase();
    dynamic list1 = await db.query('extract', where: 'fullNameSend = ?', whereArgs: [user.fullname]);
    dynamic list2 = await db.query('extract', where: 'fullNameReceiver = ?', whereArgs: [user.fullname]);
    List<ExtractAccount> listSend = toList(list1);
    List<ExtractAccount> listReceiver = toList(list2);
    List<ExtractAccount> listFinal = listSend + listReceiver;
    await Future.delayed(const Duration(seconds: 1));
    listFinal.sort((a, b) => a.date.compareTo(b.date),);
    return listFinal;
  }


  static removeDB() async {
    removeDatabase();
  }

  static List<ExtractAccount> toList(List<Map<String, dynamic>> mapOfAccounts) {
    final List<ExtractAccount> accounts = [];
    for (Map<String, dynamic> item in mapOfAccounts) {
      final ExtractAccount account = ExtractAccount(
          fullNameReceiver: item["fullNameReceiver"],
          fullNameSend: item["fullNameSend"],
          date: DateTime.parse(item['date']),
          value: item['value']);
      accounts.add(account);
    }
    return accounts;
  }
}
