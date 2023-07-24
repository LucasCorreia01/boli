import 'package:boli_digital_bank/components/list_item.dart';
import 'package:flutter/material.dart';

class SavingSection extends StatelessWidget {
  const SavingSection({super.key});

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
                'Poupanças',
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
            title: 'Viagens',
            subtitle: 'Viagem para Cartagena, Colombia.',
            icon: Icon(
              Icons.airplanemode_active_outlined,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
          ),
          ListItem(
            title: 'Festa de aniversário!',
            subtitle: 'Dinheiro para a festa surpresa.',
            icon: Icon(
              Icons.cake_sharp,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
          ),
          ListItem(
            title: 'Para emergências',
            subtitle: 'Usar só quando necessário.',
            icon: Icon(
              Icons.report_gmailerrorred_outlined,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
