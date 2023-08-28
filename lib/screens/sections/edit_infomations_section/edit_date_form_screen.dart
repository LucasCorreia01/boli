import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../models/user.dart';

class EditDateFormScreen extends StatelessWidget {
  final User user;
  const EditDateFormScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController date = TextEditingController();
    date.text = "${user.dateOfBirth}";
    final format = DateFormat('dd/MM/yyyy');

    var maskFormatter = MaskTextInputFormatter(
        mask: '##/##/####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alterar senha',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
              child: Text(
                'Qual a sua data de nascimento?',
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
                decoration: const InputDecoration(hintText: 'xx/xx/xxxx'),
                controller: date,
                validator: (value) {
                  if (value != null && value.length == 10) {
                    try {
                      DateFormat('dd/MM/yyyy').parse(value);
                    } catch (e) {
                      return 'Digite uma data válida!';
                    }

                    return null;
                  }
                  return 'Digite uma data válida!';
                },
                onChanged: (value) {
                  User.addAttr("dateOfBirth", value);
                },
                inputFormatters: [maskFormatter],
              ),
            ),
          )
        ],
      ),
    );
  }
}
