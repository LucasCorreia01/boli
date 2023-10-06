import 'package:boli/database/savings_dabase.dart';
import 'package:boli/database/users_database.dart';
import 'package:boli/models/user.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'extract_account.dart';

class Savings extends ChangeNotifier {
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

  Savings.empty()
      : id = "",
        title = "",
        description = "",
        icon = 0,
        fullName = "",
        date = DateTime.now(),
        balance = 0;

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
      var mapUser = await userDb
          .query('users', where: 'fullName = ?', whereArgs: [user.fullname]);
      List<User> listUsers = toListUser(mapUser);
      double balanceUser = listUsers.first.balance;
      balanceUser = balanceUser - balance;
      userDb.update(
          'users',
          where: 'fullName = ?',
          whereArgs: [user.fullname],
          {'balance': balanceUser});
      ExtractAccount extract = ExtractAccount(
        fullNameReceiver: "Poupança: $title",
        fullNameSend: fullName,
        date: DateTime.now(),
        value: balance,
      );
      extract.newExtract();
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
        where: "fullName = ?",
        whereArgs: [fullName],
        limit: 3,
        orderBy: 'date DESC');
    return toList(savings);
  }

  Future<bool> addBalanceSaving(double value) async {
    try {
      Database db = await getDatabaseSavings();
      Database userDb = await getDatabase();
      var mapUser = await userDb
          .query('users', where: 'fullName = ?', whereArgs: [fullName]);
      List<User> listUsers = toListUser(mapUser);
      double balanceUser = listUsers.first.balance;
      balanceUser = balanceUser - value;
      balance = balance + value;
      db.update('savings', {'balance': balance},
          where: 'title = ?', whereArgs: [title]);
      try {
        userDb.update(
          'users',
          where: 'fullName = ?',
          whereArgs: [fullName],
          {'balance': balanceUser},
        );
      } on Exception {
        print('Estamos aqui! dentro do Catch');
      }
      ExtractAccount extract = ExtractAccount(
        fullNameReceiver: "Poupança: $title",
        fullNameSend: fullName,
        date: DateTime.now(),
        value: value,
      );
      extract.newExtract();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> redeemMoneySaving(double value) async {
    try {
      Database db = await getDatabaseSavings();
      Database userDb = await getDatabase();
      var mapUser = await userDb
          .query('users', where: 'fullName = ?', whereArgs: [fullName]);
      List<User> listUsers = toListUser(mapUser);
      double actualBalance = listUsers.first.balance;
      actualBalance = actualBalance + value;
      balance = balance - value;
      userDb.update('users', {'balance' : actualBalance}, where: 'fullName = ?', whereArgs: [fullName]);
      db.update('savings', {'balance' : balance}, where: 'fullName = ? and title = ?', whereArgs: [fullName, title]);
      print(actualBalance);
      print(balance);
      ExtractAccount extract = ExtractAccount(
        fullNameReceiver: "Resgate poupança: $title",
        fullNameSend: fullName,
        date: DateTime.now(),
        value: value,
      );
      extract.newExtract();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteSaving() async {
    try {
      Database db = await getDatabaseSavings();
      Database userDb = await getDatabase();
      db.delete('savings', where: 'title = ?', whereArgs: [title]);
      var mapUser = await userDb
          .query('users', where: 'fullName = ?', whereArgs: [fullName]);
      List<User> listUsers = toListUser(mapUser);
      double balanceUser = listUsers.first.balance;
      print(balanceUser);
      balanceUser = balanceUser + balance;
      print(balanceUser);
      userDb.update(
          'users',
          where: 'fullName = ?',
          whereArgs: [fullName],
          {'balance': balanceUser});

      return true;
    } catch (e) {
      print('Um erro aconteceu ao tentar realizar a ação');
      return false;
    }
  }

  // Adicionar novo usuário - Salvando as informações entre os formulários sections
  static Map<String, String> savings = {};
  static void addAttr(String attr, String value) {
    savings[attr] = value;
  }

  static Map<String, String> getSavingsMap() {
    return savings;
  }

  //Transforma nosso mapa vindo do banco em um lista de poupanças para a nossa aplicação.
  static List<Savings> toList(List<Map<String, dynamic>> mapOfSavings) {
    final List<Savings> savings = [];
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
