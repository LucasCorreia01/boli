import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double movedValue = 0;
  double balance = 0;  
  

  //Atualizar visto por último
  Future<String?> updateLastSeen() async{
    try{
      _firestore.collection('users').doc(_uid).update({'lastSeen' : DateTime.now()});
    } on FirebaseException catch(e){
      return e.code;
    }

    return null;
  }


}