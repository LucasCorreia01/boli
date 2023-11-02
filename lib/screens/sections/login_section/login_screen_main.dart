import 'package:animations/animations.dart';
import 'package:boli/models/user.dart';
import 'package:boli/screens/sections/login_section/login_password_section.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:math' as math;

import 'login_email_section.dart';

class LoginScreenMain extends StatefulWidget {
  const LoginScreenMain({super.key});

  @override
  State<LoginScreenMain> createState() => _LoginScreenMainState();
}

class _LoginScreenMainState extends State<LoginScreenMain> {
  int _currentIndex = 0;
  final _formKey = GlobalKey<FormState>();
  List<Widget> pages = [
    const LoginEmailSection(),
    const LoginPasswordSection()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Login',
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
          if(_formKey.currentState!.validate()) {
            setState(() {
              if(_currentIndex <= 2){
                _currentIndex++;
                if(_currentIndex == 2){
                  Map<String, String> userMap = User.getUserMap();
                  if(userMap["email"] != null && userMap["password"] != null){
                    User.autenticar(userMap["email"]!, userMap["password"]!);
                  } else {
                    print('Usuário não econtrado');
                  }
                }
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
