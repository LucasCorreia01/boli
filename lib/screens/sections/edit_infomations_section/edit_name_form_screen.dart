import 'package:flutter/material.dart';

import '../../../models/user.dart';

class EditNameFormScreen extends StatefulWidget {
  final User user;
  const EditNameFormScreen({required this.user, super.key});

  @override
  State<EditNameFormScreen> createState() => _EditNameFormScreenState();
}

class _EditNameFormScreenState extends State<EditNameFormScreen> {
  final TextEditingController name = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    name.text = widget.user.fullname;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar nome',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
                child: Text(
                  'Vamos editar o seu nome?',
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
                controller: name,
                validator: (value) {
                  if (value == null || value == "" || value.length < 10) {
                    return 'Por favor digite seu nome completo';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                autofocus: false,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(fontWeight: FontWeight.normal),
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor)),
                  hintText: 'Digite seu nome completo',
                ),
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_formKey.currentState!.validate()){
            widget.user.editInformation('fullname', name.text);
            Navigator. pushNamedAndRemoveUntil(context, 'login-screen', (Route<dynamic> route) => false);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
