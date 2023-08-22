import 'package:flutter/material.dart';

import '../../components/item_user_transfer.dart';
import '../../models/user.dart';

class SendingMoneyScreen extends StatefulWidget {
  final User userSend;
  final User userReceiver;
  final String valueToTransfer;
  const SendingMoneyScreen({ required this.userSend, required this.userReceiver,  required this.valueToTransfer, super.key});

  @override
  State<SendingMoneyScreen> createState() => _SendingMoneyScreenState();
}

class _SendingMoneyScreenState extends State<SendingMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 10, 20),
          child: Text(
            'Realizando sua transação...',
            style: TextStyle(
                fontSize: 28,
                letterSpacing: 0.75,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible),
          ),
        ),
        Expanded(
            child: FutureBuilder(
          future: widget.userSend.makeTransfer(fullnameSend: widget.userSend.fullname, fullnameReceiver: widget.userReceiver.fullname, value: widget.valueToTransfer),
          builder: (context, snapshot) {
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
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Transação concluída com sucesso.',
                      style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  );
            }
          },
        ))
      ],
    ),
    );
  }
}
