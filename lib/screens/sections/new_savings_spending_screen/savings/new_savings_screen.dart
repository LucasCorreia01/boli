import 'package:animations/animations.dart';
import 'package:boli/models/user.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/balance_saving.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/description_saving.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/name_savings.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:math' as math;

import 'creating_saving.dart';
import 'icon_saving.dart';

class NewSavingsScreen extends StatefulWidget {
  final User user;
  const NewSavingsScreen({required this.user, super.key});

  @override
  State<NewSavingsScreen> createState() => _NewSavingsScreenState();
}

class _NewSavingsScreenState extends State<NewSavingsScreen> {
  int _currentIndex = 0;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    List<Widget> pages = [
      const NameSaving(),
      const DescriptionSaving(),
      const IconSaving(),
      BalanceSaving(widget.user),
      CreatingSaving(widget.user)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova poupança',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Form(
        key: _formKey,
        child: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              SharedAxisTransition(
            transitionType: SharedAxisTransitionType.horizontal,
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
          child: pages.elementAt(_currentIndex),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              if (_currentIndex <= 4) {
                _currentIndex++;
              }
            });
          }
        },
        child: Transform.rotate(
            angle: -math.pi, child: const Icon(BoxIcons.bx_arrow_back)),
      ),
    );
  }
}
