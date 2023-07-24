import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BalanceSection extends StatefulWidget {
  BalanceSection({super.key});

  List<String> items = ['BRL', 'USD', 'EUR'];

  String? selectedItem = 'BRL';

  @override
  State<BalanceSection> createState() => _BalanceSectionState();
}

class _BalanceSectionState extends State<BalanceSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dinheiro movimentado esse mês:',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$10,000,000.00',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: widget.selectedItem,
                items: widget.items
                    .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.headlineSmall,
                        )))
                    .toList(),
                onChanged: (item) => setState(() {
                  print(item);
                  widget.selectedItem = item;
                }),
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.69,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width * 0.7) *
                                0.62,
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
                      Text(
                        '\$32,003,000',
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
              ),
              InkWell(
                onTap: () => print('Item tocado'),
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
