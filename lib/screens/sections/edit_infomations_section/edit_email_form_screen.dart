import 'package:boli/models/user.dart';
import 'package:boli/services/user_auth_service.dart';
import 'package:flutter/material.dart';

class EditEmailFormScreen extends StatelessWidget {
  final User user;
  const EditEmailFormScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final formKey = GlobalKey<FormState>();
    email.text = user.email;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar e-mail',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
                child: Text(
                  'Eai, vamos editar o seu e-mail?',
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
                controller: email,
                validator: (value) {
                  if (value != null &&
                      value.contains('@') &&
                      value.length > 5 &&
                      value.contains('.com')) {
                    return null;
                  }
                  return 'Insira um e-mail válido.';
                },
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
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
                  hintText: 'Email de contato',
                ),
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(formKey.currentState!.validate()){
            UserAuthService().editInformations('email', email.text).then((value){
              Navigator.pop(context);
            });
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
