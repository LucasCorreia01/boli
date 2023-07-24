import 'package:boli_digital_bank/components/card_item.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class IncomeSection extends StatelessWidget {
  const IncomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Renda',
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardItem(
                title: 'Empresa',
                icon: Icon(
                  Icons.paypal_rounded,
                  color: Theme.of(context).highlightColor,
                  size: 24,
                ),
              ),
              CardItem(
                title: 'Ventas día',
                icon: Icon(
                  Icons.offline_bolt,
                  color: Theme.of(context).highlightColor,
                  size: 24,
                ),
              ),
              CardItem(
                title: 'Social',
                icon: Icon(
                  Bootstrap.instagram,
                  color: Theme.of(context).highlightColor,
                  size: 24,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
