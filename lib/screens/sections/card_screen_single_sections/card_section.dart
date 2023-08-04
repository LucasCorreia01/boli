import 'package:boli/components/card_credit_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../models/cardCreditItemModel.dart';

class CardSection extends StatelessWidget {
  final CardCredit card;
  const CardSection(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return CardCreditItemWidget(card: card);
  }
}
