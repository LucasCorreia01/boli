import 'package:boli/models/extract_account.dart';
import 'package:boli/models/saved_accounts.dart';
import 'package:boli/models/savings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';
import '../database/users_database.dart';

class User extends ChangeNotifier {
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

  User({
    required this.name,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.lastSeen,
    this.balance = 0,
    this.movedValue = 0,
  }) : id = const Uuid().v1();

  User.empty()
      : id = '',
        name = "",
        lastName = "",
        fullName = "",
        email = "",
        password = "",
        dateOfBirth = DateTime.now(),
        lastSeen = DateTime.now(),
        balance = 0,
        movedValue = 0;

  User.fromMap(Map<String, dynamic> map)
      : id = map['uid'],
        name = map['name'],
        lastName = map['lastName'],
        fullName = map['fullName'],
        email = map['email'],
        password = map['password'],
        dateOfBirth = (map['dateOfBirth'] as Timestamp).toDate(),
        lastSeen = (map['lastSeen'] as Timestamp).toDate(),
        balance = map['balance'],
        movedValue = map['movedValue'];

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'lastSeen': lastSeen,
      'balance': balance,
      'movedValue': movedValue
    };
  }

  // // Adicionar novo usuário ao banco de dados
  // Future<bool> addUser() async {
  //   var db = await getDatabase();
  //   try {
  //     await db.insert('users', {
  //       'id': id,
  //       'name': name,
  //       'lastName': lastName,
  //       'fullName': fullName,
  //       'email': email,
  //       'password': password,
  //       'dateOfBirth': "$dateOfBirth",
  //       'lastSeen': "$lastSeen",
  //       'balance': balance,
  //       'movedValue': movedValue
  //     });
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  //Recupera todos os usuários da base de dados
  static Future<List<User>> getUsers() async {
    Database db = await getDatabase();
    var list = await db.query('users');
    return toList(list);
  }

  //Editar informações
  // Future<bool> editInformation(String attr, String value) async {
  //   Database db = await getDatabase();
  //   if (attr == 'fullName') {
  //     try {
  //       List<String> name = value.trim().split(" ");
  //       db.update('users', {"name": name[0]},
  //           where: 'fullName = ?', whereArgs: [fullName]);
  //       db.update('users', {"lastName": name[name.length - 1]},
  //           where: 'fullName = ?', whereArgs: [fullName]);
  //       db.update('users', {"fullName": value},
  //           where: 'fullName = ?', whereArgs: [fullName]);

  //       SavedAccounts.updateInfo(fullName, attr, value);
  //       return true;
  //     } catch (e) {
  //       print(e.toString());
  //       return false;
  //     }
  //   } else {
  //     try {
  //       db.update('users', {attr: value},
  //           where: 'fullName = ?', whereArgs: [fullName]);
  //       SavedAccounts.updateInfo(fullName, attr, value);
  //       return true;
  //     } catch (e) {
  //       print(e.toString());
  //       return false;
  //     }
  //   }
  // }

  //Pega todos os usuários disponíveis para transferência
  // static Future<List<User>> getUsersForTransfer(String fullName) async {
  //   Database db = await getDatabase();
  //   var list =
  //       await db.query('users', where: 'fullName != ?', whereArgs: [fullName]);
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   return toList(list);
  // }

  // Faz a transferência entre as contas
  Future<bool> makeTransfer(
      {required String fullNameSend,
      required String fullNameReceiver,
      required String value}) async {
    Database db = await getDatabase();
    //Double parse
    value = value.replaceAll('R\$', '');
    value = value.replaceAll(',', '.');
    double valueToTransfer = double.parse(value);
    balance = balance - valueToTransfer;
    //Atualiza o saldo do usuário que está enviando.
    db.update('users', {'balance': balance},
        where: 'fullName = ?', whereArgs: [fullNameSend]);

    //Atualiza o saldo do usuário que está recebendo.
    // Recupera o saldo atual
    dynamic list = await db
        .query('users', where: 'fullName = ?', whereArgs: [fullNameReceiver]);
    list = toList(list);
    User user = list[0] as User;
    //Soma com o valor da transferência
    user.balance += valueToTransfer;
    await Future.delayed(const Duration(seconds: 3));
    // Atualiza o valor do usuário no db
    await db.update('users', {'balance': user.balance},
        where: 'fullName = ?', whereArgs: [fullNameReceiver]);
    ExtractAccount extract = ExtractAccount(
        fullNameReceiver: fullNameReceiver,
        fullNameSend: fullNameSend,
        date: DateTime.now(),
        value: valueToTransfer);
    extract.newExtract();
    notifyListeners();
    return true;
  }

  //Apaga usuário de acordo com o nome informados
  static Future<bool> deleteUser(String fullName) async {
    Database db = await getDatabase();
    try {
      await db.delete('users', where: 'fullName = ?', whereArgs: [fullName]);
      ExtractAccount.deleteExtractsOfUser(fullName);
      Savings.deleteSavingsForFullname(fullName);
      SavedAccounts.deleteUser(fullName);
      return true;
    } catch (e) {
      return false;
    }
  }

  //Recupera o valor movimentado
  // Future<double> getMovedValueUser() async {
  //   Database db = await getDatabase();
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 300));
  //     var list =
  //         await db.query('users', where: 'fullName = ?', whereArgs: [fullName]);
  //     List<User> user = toList(list);
  //     return user[0].movedValue;
  //   } catch (e) {
  //     print(e.toString());
  //     return 0;
  //   }
  // }

  //Recupera o saldo do usuário
  // Future<double> getBalanceUser() async {
  //   Database db = await getDatabase();
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 300));
  //     var list =
  //         await db.query('users', where: 'fullName = ?', whereArgs: [fullName]);
  //     List<User> user = toList(list);
  //     return user[0].balance;
  //   } catch (e) {
  //     print(e.toString());
  //     return 0;
  //   }
  // }

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

  //Atualizar visto por último
  // updateLastSeen() async {
  //   Database db = await getDatabase();
  //   await db.update('users', {'lastSeen': '${DateTime.now()}'},
  //       where: 'id = ?', whereArgs: [id]);
  //   notifyListeners();
  // }

  //Adiciona dinheiro a conta
  receiveMoney(String value) async {
    Database db = await getDatabase();
    value = value.replaceAll('R\$', '');
    value = value.replaceAll(',', '.');
    double valueReceived = double.parse(value);
    double newBalance = double.parse(value);
    movedValue += newBalance;
    newBalance = newBalance + balance;
    balance = newBalance;

    await db.update('users', {'balance': newBalance, 'movedValue': movedValue},
        where: 'name = ?', whereArgs: [name]);
    ExtractAccount extract = ExtractAccount(
        fullNameReceiver: fullName,
        fullNameSend: 'Depósito Boli',
        date: DateTime.now(),
        value: valueReceived);
    extract.newExtract();
    notifyListeners();
  }

  //Apaga todos os usuário da base de dados
  static deleteAllUsers() async {
    Database db = await getDatabase();
    await db.delete('users');
  }

  // static Future<Map<String, dynamic>> autenticar(
  //     String email, String password) async {
  //   Database db = await getDatabase();
  //   Map<String, dynamic> result = {};
  //   try {
  //     List<User> list = await User.getUsers();
  //     if (list.isNotEmpty) {
  //       for (int i = 0; i < list.length; i++) {
  //         if (list[i].email == email && list[i].password == password) {
  //           result['bool'] = true;
  //           result['user'] = list[i];
  //           return result;
  //         }
  //       }
  //       result['bool'] = false;
  //     }
  //     result['bool'] = false;
  //   } catch (e) {
  //     print(e.toString());
  //     result['bool'] = false;
  //   }
  //   return result;
  // }

  //Apaga o banco de dados por completo
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
          fullName: item["fullName"],
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
}
