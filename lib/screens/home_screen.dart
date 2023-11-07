import 'package:boli/screens/sections/home_screens_sections/balance_section.dart';
import 'package:boli/screens/sections/home_screens_sections/saving_section.dart';
import 'package:boli/screens/sections/home_screens_sections/spending_section.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'actions/actions_button_home.dart';

class HomeScreen extends StatelessWidget {
  final bool balanceVisibility;
  final User user;
  const HomeScreen(
      {required this.balanceVisibility, required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BalanceSection(
            user: user,
            balanceVisibility: balanceVisibility,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ActionsButtonsHome(user: user),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SavingSection(user),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SpendingSection(),
        )
      ],
    );
  }
}
