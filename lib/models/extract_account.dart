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

  //Cria um novo registro/extrato no banco quando o usuário realiza uma transferência
  newExtract() async {
    Database db = await getDatabase();
    await db.insert('extract', {
      "id": id,
      "fullNameReceiver": fullNameReceiver,
      "fullNameSend": fullNameSend,
      "date": "$date",
      "value": value
    });
  }

  //Pega todos os extratos do banco de dados com base no nome do usuário
  static Future<List<ExtractAccount>> getExtractAccount(User user) async {
    Database db = await getDatabase();
    dynamic list1 = await db.query('extract',
        where: 'fullNameSend = ?', whereArgs: [user.fullname], orderBy: 'date DESC');
    dynamic list2 = await db.query('extract',
        where: 'fullNameReceiver = ?', whereArgs: [user.fullname], orderBy: 'date DESC');
    List<ExtractAccount> listSend = toList(list1);
    List<ExtractAccount> listReceiver = toList(list2);
    List<ExtractAccount> listFinal = listSend + listReceiver;
    await Future.delayed(const Duration(seconds: 1));
    listFinal.sort(
      (a, b) => a.date.compareTo(b.date),
    );
    listFinal = listFinal.reversed.toList();
    return listFinal;
  }

  // Transforma o Map que vem do banco de dados em uma lista de extrato para nossa aplicação.
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

  //Remove o banco de dados
  static removeDB() async {
    removeDatabase();
  }
}
