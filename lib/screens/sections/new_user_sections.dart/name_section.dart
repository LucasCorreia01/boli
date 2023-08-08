import 'package:flutter/material.dart';

class NameSection extends StatelessWidget {
  const NameSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: Text(
              'Eai, vamos começar pelo seu nome?',
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
            validator: (value){
              if(value == null || value == "" || value.length < 10){
                return 'Por favor digite seu nome completo';
              }
              return null;
            },
            onEditingComplete: () {
              print('nome inserido');
            },
            keyboardType: TextInputType.name,
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
              hintText: 'Digite seu nome completo',
            ),
          ),
        )),
      ],
    );
  }
}