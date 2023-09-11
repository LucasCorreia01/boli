import 'package:boli/models/savings.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;

import '../../../../components/showDialogConfirmation.dart';
import '../../../../models/user.dart';

class CreatingSaving extends StatefulWidget {
  final User user;
  const CreatingSaving(this.user, {super.key});

  @override
  State<CreatingSaving> createState() => _CreatingSavingState();
}

class _CreatingSavingState extends State<CreatingSaving> {
  int _currentBuild = 0;
  double valueProgress = 0;
  double opacityBox = 0;
  bool success = true;
  double opacityLinearIndicator = 1;
  Savings? savings;
  @override
  Widget build(BuildContext context) {
    return Center(
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
                                  'Poupança criada.',
                                  style: TextStyle(
                                      fontSize: 28.7,
                                      overflow: TextOverflow.visible),
                                )
                              : const Text(
                                  'Infelizmente não foi possível criar sua poupança.',
                                  style: TextStyle(
                                      fontSize: 28.7,
                                      overflow: TextOverflow.visible),
                                ),
                        ),
                        AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            FadeAnimatedText(
                              'Salvando seus dados...',
                              duration: const Duration(milliseconds: 3000),
                              textStyle: const TextStyle(fontSize: 30),
                            ),
                            FadeAnimatedText(
                              'Criando poupança...',
                              duration: const Duration(milliseconds: 3000),
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
                                          'Não foi possível criar sua poupança no momento.\nTente novamente mais tarde, ou entre contato conosco.',
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
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Voltar',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 40,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
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
    );
  }

  Future<bool> save() async {
    Map<String, String> savingMap = Savings.getSavingsMap();
    bool result = false;
    savings = Savings(
      title: savingMap['name']!,
      description: savingMap['description']!,
      icon: int.parse(savingMap['icon']!),
      fullName: widget.user.fullname,
      date: DateTime.now(),
      balance: double.parse(savingMap['valueToSave']!),
    );
    if (savings != null) {
      await savings!.addSaving().then((value) {
        result = value;
      });
    }
    return result;
  }
}
