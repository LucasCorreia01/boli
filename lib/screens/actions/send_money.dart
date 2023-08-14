import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../models/user.dart';
import 'dart:math' as math;

class SendMoney extends StatefulWidget {
  User user;
  SendMoney({required this.user, super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final TextEditingController value = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
    mask: 'R\$###,##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
              child: Text(
                'Qual o valor da transferência?',
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
                  onChanged: (value) {
                    User.addAttr("dateOfBirth", value);
                  },
                  inputFormatters: [maskFormatter],
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Text.rich(
                TextSpan(text: 'Saldo disponível: ', style: const TextStyle(fontSize: 18), children: <TextSpan>[
                  TextSpan(
                    text: 'R\$${widget.user.balance}',
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Transform.rotate(
            angle: -math.pi, child: const Icon(BoxIcons.bx_arrow_back)),
      ),
    );
  }
}
