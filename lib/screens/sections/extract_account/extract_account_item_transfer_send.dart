import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../../models/user.dart';

class ExtractAccountItemTransferSend extends StatelessWidget {
  final User actualUser;
  final String userReceiver;
  final String userSend;
  final double valueTranfered;
  final DateTime date;
  const ExtractAccountItemTransferSend(
      {required this.actualUser,
      required this.userReceiver,
      required this.userSend,
      required this.valueTranfered,
      required this.date,
      super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = {
      "userSend": userSend,
      "userReceiver": userReceiver,
      "valueToTransfer": "R\$ $valueTranfered",
      "date" : date
    };

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "transfer-voucher", arguments: arguments);
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]!))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: 50,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    BoxIcons.bx_arrow_from_bottom,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transferência enviada',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          userReceiver,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        'R\$$valueTranfered',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  DateFormat('dd/MM').format(date),
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
