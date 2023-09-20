import 'package:boli/models/savings.dart';
import 'package:flutter/material.dart';

class NameSaving extends StatelessWidget {
  const NameSaving({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: Text(
              'Qual o nome da sua poupança?',
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
              if (value == null || value == "") {
                return 'Por favor digite um nome para sua poupança';
              }
              return null;
            },
            onChanged: (value){
              Savings.addAttr('name', value);
            },
            keyboardType: TextInputType.name,
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
              hintText: 'Nome da poupança',
            ),
          ),
        )),
      ],
    );
  }
}