import 'package:boli/models/savings.dart';
import 'package:flutter/material.dart';

class DescriptionSaving extends StatelessWidget {
  const DescriptionSaving({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController description = TextEditingController();
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
            child: Text(
              'Adicione uma descrição a sua poupança',
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
              controller: description,
              validator: (value) {
                if (value == null || value == "" || value.length < 10) {
                  return 'Por favor digite uma descrição para sua poupança';
                }
                return null;
              },
              onChanged: (value) {
                Savings.addAttr('description', value);
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
                hintText: 'Descrição da poupança',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
