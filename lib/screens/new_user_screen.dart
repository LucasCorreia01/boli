import 'package:boli/screens/sections/new_user_sections/date_of_birth_section.dart';
import 'package:boli/screens/sections/new_user_sections/email_section.dart';
import 'package:boli/screens/sections/new_user_sections/name_section.dart';
import 'package:boli/screens/sections/new_user_sections/password_section.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animations/animations.dart';
import 'dart:math' as math;

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});
  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  // User? user;
  final TextEditingController nameController = TextEditingController();
  int _currentIndex = 0;
  List<Widget> pages = [
    const NameSection(),
    const EmailSection(),
    const PasswordSection(),
    const DateOfBirth(),
    Container()
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Nova conta',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 4.5,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
                      borderRadius: BorderRadius.circular(4.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 4.5,
                      height: 4.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).indicatorColor,
                        borderRadius: BorderRadius.circular(4.5),
                      ),
                    ),
                  ),
                  Container(
                    width: 4.5,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                ],
              ))
        ],
      ),
      // body: pages.elementAt(_currentIndex),
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
                if (_currentIndex == 4) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('loading_creation_screen', (Route<dynamic> route) => false)
                      .then(
                        (value) => _currentIndex--,
                      );
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
