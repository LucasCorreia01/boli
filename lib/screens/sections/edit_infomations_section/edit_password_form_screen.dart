import 'package:flutter/material.dart';
import '../../../models/user.dart';

class EditPasswordFormScreen extends StatefulWidget {
  final User user;
  const EditPasswordFormScreen({required this.user, super.key});

  @override
  State<EditPasswordFormScreen> createState() => _EditPasswordFormScreen();
}

class _EditPasswordFormScreen extends State<EditPasswordFormScreen> {
  final TextEditingController password = TextEditingController();
  bool _isObscure = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar senha',
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
                  'Vamos definir uma senha para sua conta.',
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
                  controller: password,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Insira uma senha válida de pelo menos 8 dígitos.';
                    }
                    return null;
                  },
                  obscureText: _isObscure,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).dividerColor)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).dividerColor)),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).dividerColor)),
                      hintText: 'Senha numérica',
                      suffixIcon: SizedBox(
                        child: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            widget.user.editInformation('password', password.text);
            Navigator. pushNamedAndRemoveUntil(context, 'login-screen', (Route<dynamic> route) => false);
          }
        },
        backgroundColor: Theme.of(context).primaryColor ,
        child: const Icon(Icons.check),
      ),
    );
  }
}
