import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../models/user.dart';
import 'dart:math' as math;

class ReceiveMoney extends StatefulWidget {
  User user;
  ReceiveMoney({required this.user, super.key});

  @override
  State<ReceiveMoney> createState() => _ReceiveMoneyState();
}

class _ReceiveMoneyState extends State<ReceiveMoney> {
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
                  onChanged: (value) {
                    User.addAttr("dateOfBirth", value);
                  },
                  inputFormatters: [maskFormatter],
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.user.receiveMoney(value.text);
          Navigator.of(context).pop();
        },
        child: Transform.rotate(
            angle: -math.pi, child: const Icon(BoxIcons.bx_arrow_back)),
      ),
    );
  }
}
