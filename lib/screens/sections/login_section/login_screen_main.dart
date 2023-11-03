import 'package:animations/animations.dart';
import 'package:boli/models/saved_accounts.dart';
import 'package:boli/models/user.dart';
import 'package:boli/screens/sections/login_section/login_password_section.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:math' as math;

import '../../../components/showDialogConfirmation.dart';
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
          if (_formKey.currentState!.validate()) {
            if (_currentIndex < 2) {
              setState(() {
                _currentIndex++;
              });
              if (_currentIndex == 2) {
                Map<String, String> userMap = User.getUserMap();
                if (userMap["email"] != null && userMap["password"] != null) {
                  User.autenticar(userMap["email"]!, userMap["password"]!)
                      .then((value) {
                    print('O valor do value é: ${value["bool"]}');
                    if (value["bool"]) {
                      Navigator.pushNamedAndRemoveUntil(context, 'home-screen',
                          (Route<dynamic> route) => false,
                          arguments: value["user"]);
                      var save = SavedAccounts(
                          id: value["user"].id,
                          name: value["user"].name,
                          fullname: value["user"].fullname,
                          lastName: value["user"].lastName,
                          email: value["user"].email,
                          password: value["user"].password,
                          dateOfBirth: value["user"].dateOfBirth,
                          lastSeen: value["user"].lastSeen,
                          balance: value["user"].balance,
                          movedValue: value["user"].movedValue);
                      save.newAccountSave();
                    } else {
                      _currentIndex = 0;
                      setState(() {
                        showConfirmationDialog(
                            context: context,
                            title: 'Dados inválidos  :(',
                            content:
                                'Descupe, por favor verifique seus dados.');
                      });
                    }
                  });
                } else {
                  _currentIndex = 0;
                  showConfirmationDialog(
                      context: context,
                      title: 'Dados inválidos  :(',
                      content: 'Descupe, por favor verifique seus dados.');
                }
              }
            }
          }
        },
        child: Transform.rotate(
            angle: -math.pi, child: const Icon(BoxIcons.bx_arrow_back)),
      ),
    );
  }
}
