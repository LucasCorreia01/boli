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
    balance = "${user.balance}";
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: user.getBalanceUser(),
                    builder: (context, snapshot) {
                      double? movedValue = snapshot.data;
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Center(
                            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
                          );
                        case ConnectionState.waiting:
                          return const Center(
                            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
                          );
                        case ConnectionState.active:
                          return const Center(
                            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            return Text(
                              (balanceVisibility) ? 'R\$$movedValue' : 'R\$****',
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          }
                          return const Center(
                            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
                          );
                      }
                    }),
              ],
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
