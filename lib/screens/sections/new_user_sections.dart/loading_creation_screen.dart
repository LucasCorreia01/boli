import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import '../../../components/showDialogConfirmation.dart';
import '../../../models/user.dart';

class LoadingCreationScreen extends StatefulWidget {
  const LoadingCreationScreen({super.key});

  @override
  State<LoadingCreationScreen> createState() => _LoadingCreationScreenState();
}

class _LoadingCreationScreenState extends State<LoadingCreationScreen> {
  int _currentBuild = 0;
  double valueProgress = 0;
  double opacityBox = 0;
  bool success = true;
  double opacityLinearIndicator = 1;
  User? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SizedBox(
                        // height: 40,
                        child: Stack(children: [
                          Opacity(
                            opacity: opacityBox,
                            child: (success)
                                ? const Text(
                                    'Tudo pronto, vamos lá?',
                                    style: TextStyle(
                                        fontSize: 28.7,
                                        overflow: TextOverflow.visible),
                                  )
                                : const Text(
                                    'Infelizmente não foi possível criar sua conta.',
                                    style: TextStyle(
                                        fontSize: 28.7,
                                        overflow: TextOverflow.visible),
                                  ),
                          ),
                          AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              FadeAnimatedText(
                                'Preparando...',
                                duration: const Duration(milliseconds: 3000),
                                textStyle: const TextStyle(fontSize: 30),
                              ),
                              FadeAnimatedText(
                                'Salvando seus dados...',
                                duration: const Duration(milliseconds: 3000),
                                textStyle: const TextStyle(fontSize: 30),
                              ),
                              FadeAnimatedText(
                                'Quase tudo pronto...',
                                duration: const Duration(milliseconds: 5000),
                                textStyle: const TextStyle(fontSize: 30),
                              ),
                            ],
                            onFinished: () {
                              setState(() {
                                valueProgress = 1;
                                if (_currentBuild == 0) {
                                  opacityBox = 1;
                                  save().then((value) {
                                    if (value) {
                                      success = true;
                                    } else {
                                      success = false;
                                      opacityLinearIndicator = 0;
                                      showConfirmationDialog(
                                        context: context,
                                        title: 'Desculpe-nos',
                                        content:
                                            'Não foi possível criar sua conta no momento.\nTente novamente mais tarde, ou entre contato conosco.',
                                        twoOptions: false,
                                      );
                                    }
                                    setState(() {});
                                  });
                                }
                                _currentBuild++;
                              });
                            },
                          ),
                        ]),
                      ),
                    ),
                    Opacity(
                      opacity: opacityLinearIndicator,
                      child: LinearProgressIndicator(
                        value: (valueProgress == 0) ? null : 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Opacity(
                      opacity: opacityBox,
                      child: (success)
                          ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 40,
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    int sensibility = 300;
                                    if (details.delta.dx < sensibility) {
                                      Navigator.of(context).pushReplacementNamed(
                                          'home-screen',
                                          arguments: user);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            'Deslize',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Transform.rotate(
                                              angle: -math.pi,
                                              child: const Icon(
                                                BoxIcons.bx_arrow_back,
                                                size: 26,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          )
                          : SizedBox(
                              height: 40,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  int sensibility = 300;
                                  if (details.delta.dx < sensibility) {
                                    Navigator.of(context)
                                        .pushReplacementNamed('login-screen');
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          'Voltar a tela inicial',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Transform.rotate(
                                            angle: -math.pi,
                                            child: const Icon(
                                              BoxIcons.bx_arrow_back,
                                              size: 26,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: SizedBox(
                    width: 150,
                    child: Image.asset('assets/images/logo-boli.png'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> save() async {
    Map<String, String> userMap = User.getUserMap();
    // Divisão de nome e sobre nome
    List<String> name = userMap['name']!.trim().split(" ");
    bool result = false;
    user = User(
        name: name[0],
        lastName: name[name.length - 1],
        email: userMap['email']!,
        fullname: userMap["fullName"]!,
        password: userMap['password']!,
        dateOfBirth: DateFormat('dd/MM/yyyy').parse(userMap['dateOfBirth']!),
        lastSeen: DateTime.now());
    if (user != null) {
      await user!.addUser().then((value) {
        setPreferencesAccountAccess(user!.name, userMap["fullName"]!);
        result = value;
      });
    }
    return result;
  }

  setPreferencesAccountAccess(String name, String fullName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('fullName', fullName);
  }
}
