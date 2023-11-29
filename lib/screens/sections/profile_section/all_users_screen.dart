import 'package:boli/models/user.dart';
import 'package:boli/screens/sections/profile_section/item_all_user_screen.dart';
import 'package:flutter/material.dart';

import '../../../components/item_user_acess.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todos os usuários',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).indicatorColor,
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
              'Todas as contas do sistema:',
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
                      if (accounts.isNotEmpty) {
                        return ListView.builder(
                          itemCount: accounts.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                                onTap: () {
                                  //TODO::: Apagar usuário
                                },
                                child: ItemAllUser(user: accounts[index]));
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
        ],
      ),
    );
  }
}
