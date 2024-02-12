import 'package:boli/screens/actions/sending_money.dart';
import 'package:flutter/material.dart';
import '../../components/item_user_transfer.dart';
import '../../models/user.dart';

class UsersToTransfer extends StatefulWidget {
  final User user;
  final String valueToTransfer;
  const UsersToTransfer({required this.user, required this.valueToTransfer, super.key});

  @override
  State<UsersToTransfer> createState() => _UsersToTransferState();
}

class _UsersToTransferState extends State<UsersToTransfer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 10, 20),
          child: Text(
            'Para quem você deseja transferir?',
            style: TextStyle(
                fontSize: 28, letterSpacing: 0.75, fontWeight: FontWeight.bold, overflow: TextOverflow.visible),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: User.getUsersForTransfer(widget.user.fullName),
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
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                  return SendingMoneyScreen(userSend: widget.user, valueToTransfer: widget.valueToTransfer, userReceiver: accounts[index],);
                                }));
                              },
                              child: ItemUserTransfer(user: accounts[index]));
                        },
                      );
                    }
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Nenhuma outra conta encontrada.',
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    );
                  }
                  print(snapshot.hasData);
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
    );
  }
}
