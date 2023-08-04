import 'package:boli/components/credit_card_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BalanceSection extends StatefulWidget {
  bool balanceVisibility;
  BalanceSection({super.key, required this.balanceVisibility});

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
              (widget.balanceVisibility) ? '\$10,000,000.00' : '\$****',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: widget.selectedItem,
                items: widget.items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    )
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
              CreditCardHome(balanceVisibility: widget.balanceVisibility),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('screen-card');
                },
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
