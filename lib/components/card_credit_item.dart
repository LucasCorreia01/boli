import 'package:flutter/material.dart';

class CardCreditItem extends StatelessWidget {
  final String balanceCard;
  final String cardNumber;
  final String cvv;
  final String dueDate;
  final Color colorCard;
  final Color colorText;
  final IconData iconCard;
  const CardCreditItem({
    super.key,
    required this.balanceCard,
    required this.cardNumber,
    required this.cvv,
    required this.dueDate,
    required this.colorCard,
    required this.colorText,
    required this.iconCard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: colorCard,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                            color: colorText,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Image.asset(
                      'assets/images/mastercard-logo.png',
                    ),
                  ),
                ],
              ),
              Text(
                '\$$balanceCard',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: colorText,
                    overflow: TextOverflow.ellipsis),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cardNumber,
                      style: TextStyle(
                        color: colorText,
                        fontSize: 14.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      dueDate,
                      style: TextStyle(
                        color: colorText,
                        fontSize: 14.5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'CVV $cvv',
                      style: TextStyle(
                        color: colorText,
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
