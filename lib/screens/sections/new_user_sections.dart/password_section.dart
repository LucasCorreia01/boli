import 'package:flutter/material.dart';

class PasswordSection extends StatefulWidget {
  const PasswordSection({super.key});

  @override
  State<PasswordSection> createState() => _PasswordSectionState();
}

class _PasswordSectionState extends State<PasswordSection> {
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
                        icon: Icon(_isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
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
