import 'package:flutter/material.dart';

import '../models/cardCreditItemModel.dart';

class CardCreditItemWidget extends StatelessWidget {
  final CardCredit card;
  const CardCreditItemWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: card.colorCard,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.7) * 0.62,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          'Saldo da conta',
                          style: TextStyle(
                              color: card.colorText,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Image.asset(
                        '${card.imageLogo}',
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${card.balanceCard}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: card.colorText,
                    overflow: TextOverflow.ellipsis),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card.cardNumber,
                      style: TextStyle(
                        color: card.colorText,
                        fontSize: 14.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      card.dueDate,
                      style: TextStyle(
                        color: card.colorText,
                        fontSize: 14.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'CVV ${card.cvv}',
                      style: TextStyle(
                        color: card.colorText,
                        fontSize: 14.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
