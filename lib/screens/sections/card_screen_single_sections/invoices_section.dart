import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../components/list_item_incoices.dart';

class InvoicesSection extends StatelessWidget {
  const InvoicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transações',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(BoxIcons.bx_search))
              ],
            ),
            const ListItemInvoces('12 Jan 2023', 'Conta de água', '110'),
            const ListItemInvoces('13 Fev 2023', 'Netflix', '55'),
            const ListItemInvoces('15 Fev 2023', 'Conta de telefone', '20'),
            const ListItemInvoces('12 Jan 2023', 'Conta de água', '110'),
            const ListItemInvoces('13 Fev 2023', 'Netflix', '55'),
            const ListItemInvoces('15 Fev 2023', 'Conta de telefone', '20'),
            const ListItemInvoces('12 Jan 2023', 'Conta de água', '110'),
            const ListItemInvoces('13 Fev 2023', 'Netflix', '55'),
            const ListItemInvoces('15 Fev 2023', 'Conta de telefone', '20'),
          ],
        ),
      ),
    );
  }
}
