import 'package:boli/components/credit_card_home.dart';
import 'package:boli/helpers/utils.dart';
import 'package:boli/services/account_service.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';

// ignore: must_be_immutable
class BalanceSection extends StatefulWidget {
  bool balanceVisibility;
  User user;
  BalanceSection(
      {super.key, required this.balanceVisibility, required this.user});

  List<String> items = ['BRL', 'USD', 'EUR'];

  String? selectedItem = 'BRL';

  @override
  State<BalanceSection> createState() => _BalanceSectionState();
}

class _BalanceSectionState extends State<BalanceSection> {
  @override
  void initState() {
    super.initState();
  }

  String totalBalance = '';

  @override
  Widget build(BuildContext context) {
    totalBalance = "${widget.user.movedValue}";
    totalBalance = totalBalance.replaceAll('.', ',');
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
            FutureBuilder(
                future: AccountService().getMovedValueUser(),
                builder: (context, snapshot) {
                  double? movedValue = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      );
                    case ConnectionState.active:
                      return const Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        return Text(
                          (widget.balanceVisibility)
                              ? Utils.formatPrice(movedValue!)
                              : 'R\$****',
                          style: Theme.of(context).textTheme.titleMedium,
                        );
                      }
                      return const Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator()),
                      );
                  }
                }),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: widget.selectedItem,
                items: widget.items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            color: Theme.of(context).indicatorColor,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (item) => setState(() {
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
              CreditCardHome(
                  balanceVisibility: widget.balanceVisibility,
                  user: widget.user),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('screen-card', arguments: widget.user);
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
