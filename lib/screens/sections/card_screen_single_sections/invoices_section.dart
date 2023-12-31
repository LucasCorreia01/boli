import 'package:boli/helpers/exemples.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:icons_plus/icons_plus.dart';
import '../../../components/list_item_incoices.dart';

// ignore: must_be_immutable
class InvoicesSection extends StatelessWidget {
  const InvoicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> listItemExemples = getListItensIncoces();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
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
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListItemInvoces(
                listItemExemples[index]['date']!,
                listItemExemples[index]['title']!,
                listItemExemples[index]['value']!,
              );
            },
            childCount: listItemExemples.length,
          ),
        )
      ],
    );
  }
}
