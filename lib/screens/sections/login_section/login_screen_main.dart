import 'package:animations/animations.dart';
import 'package:boli/models/saved_accounts.dart';
import 'package:boli/models/user.dart';
import 'package:boli/screens/sections/login_section/login_password_section.dart';
import 'package:boli/services/user_auth_service.dart';
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
    const LoginPasswordSection(),
    const Loading()
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
                  UserAuthService()
                      .login(
                          email: userMap["email"]!,
                          password: userMap["password"]!)
                      .then((error) {
                    if (error == null) {
                      UserAuthService().getUserLoggedData().then((value) {
                        if (value['error'] == null) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              'home-screen', (Route<dynamic> route) => false,
                              arguments: value["user"]);
                          var save = SavedAccounts(
                              id: value["user"].id,
                              name: value["user"].name,
                              fullName: value["user"].fullName,
                              lastName: value["user"].lastName,
                              email: value["user"].email,
                              password: value["user"].password,
                              dateOfBirth: value["user"].dateOfBirth,
                              lastSeen: value["user"].lastSeen,
                              balance: value["user"].balance,
                              movedValue: value["user"].movedValue);
                          save.newAccountSave();
                        }
                      });
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

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
