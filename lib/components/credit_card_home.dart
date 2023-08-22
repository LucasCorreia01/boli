import 'package:flutter/material.dart';

import '../models/user.dart';

// ignore: must_be_immutable
class CreditCardHome extends StatelessWidget {
  bool balanceVisibility;
  User user;
  CreditCardHome(
      {super.key, required this.balanceVisibility, required this.user});
  String balance = '';
  @override
  Widget build(BuildContext context) {
    balance = "${user.movedValue}";
    balance = balance.replaceAll('.', ',');

    return Container(
      width: MediaQuery.of(context).size.width * 0.69,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.7) * 0.62,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        'Saldo da conta',
                        style: Theme.of(context).textTheme.titleSmall,
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
            ),
            Text(
              (balanceVisibility) ? 'R\$$balance' : 'R\$****',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '**** **** **** 7348',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '12/26',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
