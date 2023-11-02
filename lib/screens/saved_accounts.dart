import 'package:boli/components/item_user_acess.dart';
import 'package:flutter/material.dart';
import '../components/showDialogConfirmation.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedAccountsScreen extends StatefulWidget {
  const SavedAccountsScreen({super.key});

  @override
  State<SavedAccountsScreen> createState() => _SavedAccountsScreenState();
}

class _SavedAccountsScreenState extends State<SavedAccountsScreen> {
  bool isPossibleCreateAccount = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trocar acesso',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 10, 20),
            child: Text(
              'Contas salvas',
              style: TextStyle(
                  fontSize: 19,
                  letterSpacing: 0.75,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: User.getUsers(),
              builder: (context, snapshot) {
                List<User>? accounts = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: CircularProgressIndicator(),
                          ),
                          Text(
                            'Carregando...',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: CircularProgressIndicator(),
                          ),
                          Text(
                            'Carregando...',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    );
                  case ConnectionState.active:
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: CircularProgressIndicator(),
                          ),
                          Text(
                            'Carregando...',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasData && accounts != null) {
                      isPossibleCreateAccount = true;
                      if (accounts.isNotEmpty) {
                        return ListView.builder(
                          itemCount: accounts.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).pop(accounts[index]);
                                  setPreferencesAccountAccess(accounts[index].fullname);
                                },
                                child: ItemUserAcess(user: accounts[index]));
                          },
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Nenhuma conta salva em seu dispositivo.',
                          style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      );
                    }
                    isPossibleCreateAccount = false;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.warning,
                              color: Color.fromRGBO(255, 0, 0, 1),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Error ao carregar as contas salvas. Tente novamente mais tarde.',
                              style: TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                }
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: InkWell(
                onTap: () {
                  print(isPossibleCreateAccount);
                  if (isPossibleCreateAccount) {
                    Navigator.of(context).pushNamed('new-user-screen');
                  } else {
                    showConfirmationDialog(
                        context: context,
                        title: 'Desculpe-nos...  :(',
                        content:
                            'Descupe, estamos tendo problemas com nossa base de dados. Por favor tente mais tarde.');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text(
                      'ABRIR UMA NOVA CONTA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  setPreferencesAccountAccess(String fullName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fullName', fullName);
  }
}
