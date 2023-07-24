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
            icon: Icon(
              Icons.offline_bolt,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
          ),
          ListItem(
            title: 'Netflix',
            subtitle: 'Streaming.',
            icon: Icon(
              Icons.movie,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
          ),
          ListItem(
            title: 'Conta telefónica',
            subtitle: 'Pagar a conta de telefone.',
            icon: Icon(
              Icons.phone,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}