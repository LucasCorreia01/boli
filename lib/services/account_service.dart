import 'package:boli/models/user.dart' as user_app;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double movedValue = 0;
  double balance = 0;

  //Atualizar visto por último
  Future<String?> updateLastSeen() async {
    try {
      _firestore
          .collection('users')
          .doc(_uid)
          .update({'lastSeen': DateTime.now()});
    } on FirebaseException catch (e) {
      return e.code;
    }

    return null;
  }

  Future<String?> receiveMoney(String value) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userMap =
          await _firestore.collection('users').doc(_uid).get();
      user_app.User user = user_app.User.fromMap(userMap.data()!);

      value = value.replaceAll('R\$', '');
      value = value.replaceAll(',', '.');

      balance = user.balance;
      balance += double.parse(value);

      movedValue = user.movedValue;
      movedValue += double.parse(value);

      _firestore
          .collection('users')
          .doc(_uid)
          .update({'balance': balance, 'movedValue': movedValue});
    } on FirebaseException catch (e) {
      return e.code;
    }

    return null;
  }

  Future<double> getMovedValueUser() async {
    late user_app.User user;
    try {
      DocumentSnapshot<Map<String, dynamic>> userMap =
          await _firestore.collection('users').doc(_uid).get();
      user = user_app.User.fromMap(userMap.data()!);
    } on FirebaseException catch (e) {
      e.code;
      return user.movedValue = 0;
    }

    return user.movedValue;
  }

  Future<double> getBalanceUser() async {
    late user_app.User user;
    try {
      DocumentSnapshot<Map<String, dynamic>> userMap =
          await _firestore.collection('users').doc(_uid).get();
      user = user_app.User.fromMap(userMap.data()!);
    } on FirebaseException catch (e) {
      e.code;
      return user.balance = 0;
    }

    return user.balance;
  }

  Future<List<user_app.User>> getUsersForTransfer() async {
    List<user_app.User> listUsers = [];
    try {
      QuerySnapshot<Map<String, dynamic>> users = await _firestore
          .collection('users')
          .where('uid', isNotEqualTo: _uid)
          .get();
      for (var user in users.docs) {
        listUsers.add(user_app.User.fromMap(user.data()));
      }

      return listUsers;
    } on FirebaseException catch (e) {
      print(e.code);
    }

    return listUsers;
  }

  // Faz a transferência entre as contas
  Future<String?> makeTransfer(
      {required String uidSend,
      required String uidReceiver,
      required String value}) async {
    value = value.replaceAll('R\$', '');
    value = value.replaceAll(',', '.');
    double valueToTransfer = double.parse(value);

    try {
      DocumentSnapshot<Map<String, dynamic>> mapUserSend =
          await _firestore.collection('users').doc(_uid).get();
      user_app.User userSend = user_app.User.fromMap(mapUserSend.data()!);

      DocumentSnapshot<Map<String, dynamic>> mapUserReceiver =
          await _firestore.collection('users').doc(_uid).get();
      user_app.User userReceiver =
          user_app.User.fromMap(mapUserReceiver.data()!);

      userSend.balance -= valueToTransfer;
      userReceiver.balance += valueToTransfer;

      //Atualiza o saldo do usuário que está enviando.
      _firestore
          .collection('users')
          .doc(_uid)
          .update({'balance': userSend.balance});

      //Atualiza o saldo do usuário que está recebendo.
      _firestore
          .collection('users')
          .doc(_uid)
          .update({'balance': userReceiver.balance});
    } on FirebaseException catch (e) {
      return e.code;
    }

    // ExtractAccount extract = ExtractAccount(
    //     fullNameReceiver: fullNameReceiver,
    //     fullNameSend: fullNameSend,
    //     date: DateTime.now(),
    //     value: valueToTransfer);
    // extract.newExtract();

    return null;
  }
}
