import 'package:boli/screens/sections/extract_account/extract_account_item_transfer_savings_redeem.dart';
import 'package:boli/screens/sections/extract_account/extract_account_item_transfer_send.dart';
import 'package:flutter/material.dart';
import '../../../models/extract_account.dart';
import '../../../models/user.dart';
import 'extract_account_item_transfer_receiver.dart';
import 'extract_account_item_transfer_savings.dart';

class ExtractAccountScreen extends StatelessWidget {
  final User user;
  const ExtractAccountScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Extrato da conta',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ExtractAccount.getExtractAccount(user),
        builder: (context, snapshot) {
          List<ExtractAccount>? extractAccounts = snapshot.data;
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
              if (snapshot.hasData && extractAccounts != null) {
                if (extractAccounts.isNotEmpty) {
                  return Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: extractAccounts.length,
                      itemBuilder: (BuildContext context, index) {
                        if (extractAccounts[index]
                                .fullNameReceiver
                                .contains('Poupança') ||
                            extractAccounts[index]
                                .fullNameReceiver
                                .contains('Resgate')) {
                          if (extractAccounts[index]
                              .fullNameReceiver
                              .contains('Resgate')) {
                            return ExtractAccountItemTransferSavingsRedeem(
                              actualUser: user,
                              userReceiver:
                                  extractAccounts[index].fullNameReceiver,
                              userSend: extractAccounts[index].fullNameSend,
                              valueTranfered: extractAccounts[index].value,
                              date: extractAccounts[index].date,
                            );
                          } else {
                            return ExtractAccountItemTransferSavings(
                              actualUser: user,
                              userReceiver:
                                  extractAccounts[index].fullNameReceiver,
                              userSend: extractAccounts[index].fullNameSend,
                              valueTranfered: extractAccounts[index].value,
                              date: extractAccounts[index].date,
                            );
                          }
                        } else if (user.fullname ==
                            extractAccounts[index].fullNameSend) {
                          return ExtractAccountItemTransferSend(
                            actualUser: user,
                            userReceiver:
                                extractAccounts[index].fullNameReceiver,
                            userSend: extractAccounts[index].fullNameSend,
                            valueTranfered: extractAccounts[index].value,
                            date: extractAccounts[index].date,
                          );
                        } else {
                          return ExtractAccountItemTransferReceiver(
                            actualUser: user,
                            userReceiver:
                                extractAccounts[index].fullNameReceiver,
                            userSend: extractAccounts[index].fullNameSend,
                            valueTranfered: extractAccounts[index].value,
                            date: extractAccounts[index].date,
                          );
                        }
                      },
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Nenhuma extrato encontrado.',
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
    );
  }
}
