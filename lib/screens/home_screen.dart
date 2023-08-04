import 'package:boli_digital_bank/screens/sections/home_screens_sections/balance_section.dart';
import 'package:boli_digital_bank/screens/sections/home_screens_sections/income_section.dart';
import 'package:boli_digital_bank/screens/sections/home_screens_sections/saving_section.dart';
import 'package:boli_digital_bank/screens/sections/home_screens_sections/spending_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  bool balanceVisibility;
  HomeScreen({required this.balanceVisibility, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BalanceSection(
              balanceVisibility: balanceVisibility,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SavingSection(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: IncomeSection(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SpendingSection(),
          )
        ],
      );
  }
}