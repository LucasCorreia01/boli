import 'package:boli/components/card_item_home.dart';
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
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('income-screen-single',
                      arguments: {
                        'nameIncome': 'Empresa',
                        'balance': '250.000.00'
                      });
                },
                child: CardItemHome(
                  title: 'Empresa',
                  icon: Icon(
                    Icons.paypal_rounded,
                    color: Theme.of(context).highlightColor,
                    size: 24,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('income-screen-single',
                      arguments: {
                        'nameIncome': 'Vendas diárias',
                        'balance': '250.000.00'
                      });
                },
                child: CardItemHome(
                  title: 'Vendas diárias',
                  icon: Icon(
                    Icons.offline_bolt,
                    color: Theme.of(context).highlightColor,
                    size: 24,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('income-screen-single',
                      arguments: {
                        'nameIncome': 'Social',
                        'balance': '70.000.000'
                      });
                },
                child: CardItemHome(
                  title: 'Social',
                  icon: Icon(
                    Bootstrap.instagram,
                    color: Theme.of(context).highlightColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
