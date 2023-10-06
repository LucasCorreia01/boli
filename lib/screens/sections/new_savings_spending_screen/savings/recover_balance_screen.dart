import 'package:boli/models/savings.dart';
import 'package:boli/screens/savings_screen_single.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../models/user.dart';

class RecoverBalanceScreen extends StatelessWidget {
  Savings savings;
  User user;
  RecoverBalanceScreen(this.savings, this.user, {super.key});

  final TextEditingController value = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
    mask: 'R\$#########',
    filter: {"#": RegExp('[0-9,]')},
    type: MaskAutoCompletionType.lazy,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resgatar valor',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Text(
                  'Quanto você deseja resgatar da sua poupança?',
                  style: TextStyle(
                    fontSize: 28,
                    letterSpacing: 0.75,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Poupança: ${savings.title}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [maskFormatter],
                  decoration: const InputDecoration(hintText: 'R\$0,00'),
                  controller: value,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      value = value.replaceAll("R\$", '');
                      value = value.replaceAll(',', '.');
                      if (double.parse(value) > user.balance) {
                        return 'Você não tem saldo suficiente para essa operação.';
                      }
                      return null;
                    }
                    return 'Por favor insira um valor válido!';
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                child: Text.rich(
                  TextSpan(
                      text: 'Saldo disponível: ',
                      style: const TextStyle(fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'R\$${user.balance}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
                child: Text.rich(
                  TextSpan(
                      text: 'Valor nessa poupança: ',
                      style: const TextStyle(fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'R\$${savings.balance}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      value.text = value.text.replaceAll("R\$", '');
                      value.text = value.text.replaceAll(',', '.');
                      savings.redeemMoneySaving(double.parse(value.text));
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 24),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(26)),
                      child: const Text(
                        'Resgatar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
