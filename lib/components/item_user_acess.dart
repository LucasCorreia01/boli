import 'package:boli/components/showDialogConfirmation.dart';
import 'package:boli/components/show_snackbar.dart';
import 'package:boli/models/saved_accounts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemUserAcess extends StatelessWidget {
  final SavedAccounts user;
  const ItemUserAcess({required this.user, super.key});

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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorDark),
            )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
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
                      SavedAccounts.deleteUser(user.fullName).then((value) {
                        showSnackBar(context: context, content: 'Registro apagado.');
                        deleteInfoSharedPrefs();
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
