import 'package:boli/components/show_snackbar.dart';
import 'package:boli/services/user_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../services/account_service.dart';
import '../../services/notification_service.dart';

class ReceiveMoney extends StatefulWidget {
  final User user;
  const ReceiveMoney({required this.user, super.key});

  @override
  State<ReceiveMoney> createState() => _ReceiveMoneyState();
}

class _ReceiveMoneyState extends State<ReceiveMoney> {
  final TextEditingController value = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(
    mask: 'R\$#########',
    filter: {"#": RegExp('[0-9,]')},
    type: MaskAutoCompletionType.lazy,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
                child: Text(
                  'Quanto você deseja receber?',
                  style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'R\$0,00'),
                    controller: value,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }

                      return 'Nenhum valor inserido.';
                    },
                    onChanged: (value) {
                      User.addAttr("dateOfBirth", value);
                    },
                    inputFormatters: [maskFormatter],
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            AccountService().receiveMoney(value.text).then((value){
              if(value != null){
                showSnackBar(context: context, content: value, isErro: true);
              } else {
                Navigator.of(context).pop();
              }

            });
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Transform.rotate(
            angle: -math.pi, child: const Icon(BoxIcons.bx_arrow_back)),
      ),
    );
  }
}
