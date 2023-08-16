import 'package:boli/screens/actions/send_money_form.dart';
import 'package:boli/screens/actions/users_to_transfer.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../models/user.dart';
import 'package:animations/animations.dart';
import 'dart:math' as math;

class SendMoney extends StatefulWidget {
  User user;
  SendMoney({required this.user, super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      SendMoneyForm(user: widget.user),
      UsersToTransfer(user: widget.user,)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _currentIndex++;
            });
          }
        },
        child: Transform.rotate(
          angle: -math.pi,
          child: const Icon(BoxIcons.bx_arrow_back),
        ),
      ),
    );
  }
}
