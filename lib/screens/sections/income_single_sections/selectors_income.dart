// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../../models/user.dart';

// ignore: must_be_immutable
class SelectorsIncome extends StatefulWidget {
  User user;
  SelectorsIncome(this.user, {super.key});

  List<String> cardItems = ['MasterCard', 'Visa', 'BBVA'];
  String? selectedItemCard = 'MasterCard';

  List<String> frequencyItems = ['Diariamente', 'Semanalmente', 'Mensalmente', 'Anualmente'];
  String? selectedItemfrequency = 'Diariamente';

  @override
  State<SelectorsIncome> createState() => _SelectorsIncomeState();
}

class _SelectorsIncomeState extends State<SelectorsIncome> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();

  @override
  void initState(){
    _moneyController.text = formatMoney(widget.user.balance);
    _cardNumber.text = '0298 6652 9142 7345';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Total mensal:',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    child: TextField(
                      controller: _moneyController,
                      maxLines: 1,
                      readOnly: true,
                      style: const TextStyle(fontSize: 16),
                      cursorColor: Theme.of(context).primaryColorDark,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(60)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(60)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(60)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Frequência:',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).indicatorColor),
                    ),
                  ),
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        borderRadius: BorderRadius.circular(24),
                        isExpanded: true,
                        value: widget.selectedItemfrequency,
                        items: widget.frequencyItems
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
                          widget.selectedItemfrequency = item;
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Cartão de destino:',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        borderRadius: BorderRadius.circular(24),
                        isExpanded: true,
                        value: widget.selectedItemCard,
                        items: widget.cardItems
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
                          widget.selectedItemCard = item;
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Número do cartão:',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    child: TextField(
                      controller: _cardNumber,
                      maxLines: 1,

                      style: const TextStyle(fontSize: 16),
                      cursorColor: Theme.of(context).primaryColorDark,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(60)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(60)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(60)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatMoney(double value) {
    MoneyFormatter fmf = MoneyFormatter(
      amount: value,
      settings: MoneyFormatterSettings(
        symbol: 'R\$',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 2,
        compactFormatType: CompactFormatType.long,
      ),
    );
    _moneyController.text = fmf.output.symbolOnLeft;
    return fmf.output.symbolOnLeft;
  }
}
