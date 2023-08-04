import 'package:boli/components/list_item_incoices.dart';
import 'package:boli/screens/sections/card_screen_single_sections/actions_buttons.dart';
import 'package:boli/screens/sections/card_screen_single_sections/card_section.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter/material.dart';
import '../helpers/exemples.dart';
import '../models/cardCreditItemModel.dart';

// ignore: must_be_immutable
class CardScreenSingle extends StatelessWidget {
  final CardCredit card;
  const CardScreenSingle(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> listItemExemples = getListItensIncoces();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          card.nameCard,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CardSection(card)),
          const SliverToBoxAdapter(child: ActionsButtons()),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListItemInvoces(
                    listItemExemples[index]['date']!,
                    listItemExemples[index]['title']!,
                    listItemExemples[index]['value']!,
                  ),
                );
              },
              childCount: listItemExemples.length,
            ),
          )
        ],
      ),
    );
  }
}
