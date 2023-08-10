import 'package:boli/components/item_user_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../helpers/exemples.dart';
import '../models/user.dart';

class SavedAccountsScreen extends StatelessWidget {
  const SavedAccountsScreen({super.key});

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
                          children: [
                            CircularProgressIndicator(),
                            Text('Carregando')
                          ],
                        ),
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('Carregando')
                          ],
                        ),
                      );
                    case ConnectionState.active:
                      return const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('Carregando')
                          ],
                        ),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasData && accounts != null) {
                        if (accounts.isNotEmpty) {
                          return ListView.builder(
                            itemCount: accounts.length,
                            itemBuilder: (BuildContext context, index) {
                              return ItemUserAcess(user: accounts[index]);
                            },
                          );
                        }
                        return const Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 128,
                              ),
                              Text(
                                'Não há nenhuma tarefa',
                                style: TextStyle(fontSize: 32),
                              )
                            ],
                          ),
                        );
                      }
                      print(snapshot.hasData);
                      return const Text('Error ao carregar tarefas');
                  }
                },
              ),
            ),
          ],
        ));
  }
}
