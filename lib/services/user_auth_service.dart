import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/saved_accounts.dart';
import '../models/user.dart' as user_app;

class UserAuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Adiciona novo usuário
  Future<String?> addUser({required user_app.User user}) async {
    Map<String, dynamic> mapUser = user.toMap();
    String? uid;

    try {
      //Cria um novo usuário no FirebaseAuth e atualiza seu nome
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      userCredential.user!.updateDisplayName('${user.name} ${user.lastName}');

      //uid gerado pelo firebase
      uid = userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      //Caso a criação de errado caimos aqui
      //e retornamos uma mensagem amigável
      switch (e.code) {
        case 'email-already-exists':
          return 'Esse e-mail já está em uso!';

        case 'email-already-in-use':
          return 'Esse e-mail já está em uso!';

        case 'user-not-found':
          return 'Nenhum usuário foi encotrado com esse e-mail.';

        case 'invalid-credential':
          return 'As credenciais do app estão inválidas.';

        case 'network-request-failed':
          return 'Estamos com problemas na conexão.';
      }
      return 'Um erro desconhecido impediu a criação da sua conta.';
    }

    //salva a uid do firebase no user
    mapUser['uid'] = uid;

    //Salva os dados adicionais da conta no Firestore Database
    await _firestore.collection('users').doc(uid).set(mapUser);

    return null;
  }

  //Faz login em usuário existente
  Future<String?> login(
      {required String email, required String password}) async {
    try {
      //Tenta fazer login na conta
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'network-request-failed':
          return 'Sem conexão com a internet.';

        case 'invalid-credential':
          return 'Credênciais inválidas.';
      }

      return e.code;
    }

    return null;
  }

  //Sai da conta atual
  Future<String?> logoff() async {
    try {
      //Deloga da conta atual
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      //Retorna a string de erro, caso algo de errado
      return e.code;
    }

    return null;
  }

  //Apaga a conta atual
  Future<String?> deleteUser() async {
    try {
      firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
    return null;
  }

  //Recupera os dados da conta - Firestore
  Future<Map<String, dynamic>> getUserLoggedData({DocumentSnapshot<Map<String, dynamic>>? snapshot}) async {
    Map<String, dynamic> result = {'error': null, 'user': null};

    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshotUser =
          await _firestore.collection('users').doc(uid).get();
      user_app.User user = user_app.User.fromMap(snapshotUser.data()!);
      result['user'] = user;
    } on FirebaseAuthException catch (e) {
      result['error'] = e.code;
      return result;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'object-not-found':
          result['error'] = 'O objeto buscado não foi encotrado.';
          return result;

        case 'unauthenticated':
          result['error'] = 'O usuário não está autenticado.';
          return result;
      }

      result['error'] = 'Um erro desconhecido ocorreu.';
      return result;
    }

    await Future.delayed(const Duration(seconds: 2));

    return result;
  }

  //Editar informações
  Future<String?> editInformations(String attr, String value) async {
    final String uid = firebaseAuth.currentUser!.uid;

    if (attr == 'fullName') {
      try {
        List<String> name = value.trim().split(" ");
        await _firestore.collection('users').doc(uid).update(
          {
            'fullName': value,
            'name': name[0],
            'lastName': name[name.length - 1]
          },
        );
        SavedAccounts.updateInfo(uid, attr, value);

        return null;
      } on FirebaseException catch (e) {
        return e.code;
      }
    } else {
      try {
        _firestore.collection('users').doc(uid).update({attr: value});
      } on FirebaseException catch (e) {
        return e.code;
      }
    }

    return null;
  }
  //Recupera o Id do usuário
  String getUid(){
    return firebaseAuth.currentUser!.uid;
  }
}
