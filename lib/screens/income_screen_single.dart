import 'package:boli/screens/sections/income_single_sections/selectors_income.dart';
import 'package:flutter/material.dart';

class IncomeScreenSingle extends StatelessWidget {
  final String balance;
  final String nameIncome;
  const IncomeScreenSingle({required this.balance, required this.nameIncome, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          nameIncome,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Text(
                    'Saldo total:',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    '\$$balance',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Theme.of(context).primaryColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
          SelectorsIncome(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 24.0, left: 24.0, right: 24.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(26)),
                      child: const Text(
                        'Ver última fatura',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
