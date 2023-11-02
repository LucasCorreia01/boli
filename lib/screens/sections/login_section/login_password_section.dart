import 'package:flutter/material.dart';

import '../../../models/user.dart';

class LoginPasswordSection extends StatefulWidget {
  const LoginPasswordSection({super.key});

  @override
  State<LoginPasswordSection> createState() => _LoginPasswordSectionState();
}

class _LoginPasswordSectionState extends State<LoginPasswordSection> {
  final TextEditingController password = TextEditingController();

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: Text(
              'Digite sua senha, por favor.',
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
              onChanged: (value) {
                User.addAttr("password", value);
              },
              obscureText: _isObscure,
              keyboardType: TextInputType.number,
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
                  hintText: 'Senha numérica',
                  suffixIcon: SizedBox(
                    child: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
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
    );
  }
}
