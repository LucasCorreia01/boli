import 'package:boli/components/showDialogConfirmation.dart';
import 'package:boli/models/saved_accounts.dart';
import 'package:boli/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemAllUser extends StatelessWidget {
  final User user;
  const ItemAllUser({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    String abbreviation = user.name.substring(0, 2);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
                child: Text(
              abbreviation,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullname,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ID: ${user.id}',
                    style: const TextStyle(
                        fontSize: 15, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                showConfirmationDialog(context: context, title: 'Apagar').then(
                  (value) {
                    if (value) {
                      User.deleteUser(user.fullname).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Conta apagada com sucesso.'),
                          ),
                        );
                        SavedAccounts.deleteUser(user.fullname).then((value){
                          if(value) deleteInfoSharedPrefs();
                        });
                        Navigator.pushNamedAndRemoveUntil(context, 'login-screen', (Route<dynamic> route) => false);
                      });
                    }
                  },
                );
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }

  deleteInfoSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fullName', "");
  }
}
