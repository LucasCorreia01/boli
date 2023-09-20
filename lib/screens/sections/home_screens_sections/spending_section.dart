import 'package:flutter/material.dart';
import '../../../components/list_item.dart';

class SpendingSection extends StatelessWidget {
  const SpendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gastos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Ver mais',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Theme.of(context).primaryColorDark,
                    )
                  ],
                ),
              )
            ],
          ),
          ListItem(
            title: 'Serviços Públicos',
            subtitle: 'Energia, Água, Internet, Cable.',
            icon: 2
          ),
          ListItem(
            title: 'Netflix',
            subtitle: 'Streaming.',
            icon: 4
          ),
          ListItem(
            title: 'Conta telefónica',
            subtitle: 'Pagar a conta de telefone.',
            icon: 3
          )
        ],
      ),
    );
  }
}