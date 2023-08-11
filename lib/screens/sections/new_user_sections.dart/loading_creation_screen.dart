import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:math' as math;

import '../../../models/user.dart';

class LoadingCreationScreen extends StatefulWidget {
  const LoadingCreationScreen({super.key});

  @override
  State<LoadingCreationScreen> createState() => _LoadingCreationScreenState();
}

class _LoadingCreationScreenState extends State<LoadingCreationScreen> {
  int _currentBuild = 0;
  double valueProgress = 0;
  double opacityValue = 0;


  @override
  void initState() {
    print(_currentBuild);
    if(_currentBuild == 0) {save();}
    _currentBuild++;
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
          padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  height: 40,
                  child: Stack(children: [
                    Opacity(
                      opacity: opacityValue,
                      child: const Text(
                        'Tudo pronto, vamos lá?',
                        style: TextStyle(
                            fontSize: 28.7, overflow: TextOverflow.visible),
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
                          opacityValue = 1;
                          _currentBuild++;
                        });
                      },
                    ),
                  ]),
                ),
              ),
              LinearProgressIndicator(
                value: (valueProgress == 0) ? null : 1,
                color: Theme.of(context).primaryColor,
              ),
              Opacity(
                opacity: opacityValue,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 40,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        int sensibility = 300;
                        if (details.delta.dx < sensibility) {
                          Navigator.of(context).pushReplacementNamed(
                              'home-screen');
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
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  save(){
    Map<String, String> userMap = User.getUserMap();
    // Divisão de nome e sobre nome
    List<String> name = userMap['name']!.trim().split(" ");
    User user = User(name: name[0], lastName: name[name.length - 1], email: userMap['email']!, fullname: userMap["fullName"]!, password: userMap['password']!, dateOfBirth: DateTime.parse(userMap['dateOfBirth']!), lastSeen: DateTime.parse(userMap['dateOfBirth']!));
    user.addUser();
  }
}
