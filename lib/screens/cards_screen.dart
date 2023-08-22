import 'package:boli/components/card_credit_item_widget.dart';
import 'package:boli/models/cardCreditItemModel.dart';
import 'package:flutter/material.dart';
import 'package:boli/helpers/exemples.dart';

import '../models/user.dart';

// ignore: must_be_immutable
class CardScreen extends StatelessWidget {
  final User? user;
  const CardScreen({this.user, super.key});

  @override
  Widget build(BuildContext context) {
    String balance = "";
    List<CardCredit> listCardExemples = getCardExemples();
    if (user != null) {
      balance = "${user!.movedValue}";
      balance = balance.replaceAll('.', ',');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Cartões',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        toolbarHeight: 80,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 4.5,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(4.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 4.5,
                      height: 4.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(4.5),
                      ),
                    ),
                  ),
                  Container(
                    width: 4.5,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                ],
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                children: [
                  Text(
                    'Dinheiro total',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "R\$$balance",
                    // (user != null) ? balance :'\$100.000.000',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'screen-card-single',
                    arguments: listCardExemples[index]);
              },
              child: CardCreditItemWidget(card: listCardExemples[index]),
            );
          }, childCount: listCardExemples.length))
        ],
      ),
    );
  }
}
