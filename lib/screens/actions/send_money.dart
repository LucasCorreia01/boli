import 'package:boli/screens/actions/send_money_form.dart';
import 'package:boli/screens/actions/users_to_transfer.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../models/user.dart';
import 'package:animations/animations.dart';
import 'dart:math' as math;

class SendMoney extends StatefulWidget {
  final User user;
  const SendMoney({required this.user, super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Map<String, String> map = User.getUserMap();
    String valueToTransfer = "";
    if (map['valueToTransfer'] != null) {
      valueToTransfer = map['valueToTransfer']!;
    } else {
      valueToTransfer = '';
    }

    List<Widget> pages = [
      SendMoneyForm(user: widget.user),
      UsersToTransfer(
        user: widget.user,
        valueToTransfer: valueToTransfer,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'global_transfer');
            },
            icon: const Icon(BoxIcons.bx_world, size: 28,),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'payment_qr');
            },
            icon: const Icon(BoxIcons.bx_qr_scan, size: 28),
          )
        ],
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
      floatingActionButton: (_currentIndex == 0)
          ? FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _currentIndex++;
                  });
                }
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Transform.rotate(
                angle: -math.pi,
                child: const Icon(BoxIcons.bx_arrow_back),
              ),
            )
          : null,
    );
  }
}
