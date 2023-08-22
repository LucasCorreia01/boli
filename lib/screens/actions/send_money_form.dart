import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../models/user.dart';

class SendMoneyForm extends StatelessWidget {
  final User user;
  const SendMoneyForm({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController value = TextEditingController();
    String valueToTransfer = "";

    var maskFormatter = MaskTextInputFormatter(
      mask: 'R\$###,##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    return CustomScrollView(
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
                validator: (value) {
                  print(value);
                  if (value != null && value.isNotEmpty) {
                    value = value.replaceAll("R\$", '');
                    value = value.replaceAll(',', '.');
                    if(double.parse(value) > user.balance){
                      return 'Você não tem saldo suficiente para essa operação.';
                    }
                    valueToTransfer = value;
                    return null;
                  }
                  return 'Por favor insira um valor válido!';
                },
                inputFormatters: [maskFormatter],
                onChanged: (value){
                  User.addAttr('valueToTransfer', value);
                },
              )),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Text.rich(
              TextSpan(
                  text: 'Saldo disponível: ',
                  style: const TextStyle(fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'R\$${user.balance}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ]),
            ),
          ),
        )
      ],
    );
  }
}
