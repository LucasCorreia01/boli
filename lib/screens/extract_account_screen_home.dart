// import 'package:boli/components/list_item_notification.dart';
import 'package:boli/helpers/exemples.dart';
import 'package:boli/screens/sections/extract_account/extract_account_item_transfer_receiver.dart';
import 'package:boli/screens/sections/extract_account/extract_account_item_transfer_savings.dart';
import 'package:boli/screens/sections/extract_account/extract_account_item_transfer_send.dart';
import 'package:flutter/material.dart';

import '../models/extract_account.dart';
import '../models/user.dart';

class ExtractAccountScreenHome extends StatefulWidget {
  User user;
  ExtractAccountScreenHome({required this.user, super.key});

  @override
  State<ExtractAccountScreenHome> createState() =>
      _ExtractAccountScreenHomeState();
}

class _ExtractAccountScreenHomeState extends State<ExtractAccountScreenHome> {
  final List<Map<String, String>> notifications = getListItensNotifications();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ExtractAccount.getExtractAccount(widget.user),
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
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: extractAccounts.length,
                    itemBuilder: (BuildContext context, index) {
                      if (extractAccounts[index]
                          .fullNameReceiver
                          .contains('Poupança')) {
                        return ExtractAccountItemTransferSavings(
                          actualUser: widget.user,
                          userReceiver: extractAccounts[index].fullNameReceiver,
                          userSend: extractAccounts[index].fullNameSend,
                          valueTranfered: extractAccounts[index].value,
                          date: extractAccounts[index].date,
                        );
                      } else if (widget.user.fullname ==
                          extractAccounts[index].fullNameSend) {
                        return ExtractAccountItemTransferSend(
                          actualUser: widget.user,
                          userReceiver: extractAccounts[index].fullNameReceiver,
                          userSend: extractAccounts[index].fullNameSend,
                          valueTranfered: extractAccounts[index].value,
                          date: extractAccounts[index].date,
                        );
                      } else {
                        return ExtractAccountItemTransferReceiver(
                          actualUser: widget.user,
                          userReceiver: extractAccounts[index].fullNameReceiver,
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
    );
    // return CustomScrollView(
    //   slivers: [
    //     SliverToBoxAdapter(
    //       child: Text(
    //         'Notificações:',
    //         textAlign: TextAlign.center,
    //         style: Theme.of(context).textTheme.displayMedium,
    //       ),
    //     ),
    //     SliverList(
    //         delegate: SliverChildBuilderDelegate((context, index) {
    //       return ListItemNotification(
    //         title: notifications[index]['title']!,
    //         content: notifications[index]['content']!,
    //       );
    //     }, childCount: notifications.length))
    //   ],
    // );
  }
}
