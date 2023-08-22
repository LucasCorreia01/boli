// ignore_for_file: depend_on_referenced_packages
import 'dart:math';

import 'package:boli/service/local_auth_service.dart';
import 'package:boli/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

// ignore: must_be_immutable
class AuthenticationScreen extends StatefulWidget {
  User? user;
  AuthenticationScreen({this.user, super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final ValueNotifier<bool> isLocalAuthFailed = ValueNotifier(false);

  checkLocalAuth() async {
    final auth = LocalAuthService(auth: LocalAuthentication());
    final isLocalAuthAvailable = await auth.isBiometricAvailable();
    isLocalAuthFailed.value = false;

    if (isLocalAuthAvailable) {
      final authenticated = await auth.authenticate();

      if (!authenticated) {
        isLocalAuthFailed.value = true;
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacementNamed('home-screen', arguments: widget.user);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPreferencesAccountAccess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPreferencesAccountAccess();
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: isLocalAuthFailed,
        builder: (context, failed, _) {
          if (failed) {
            return Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background-login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: ThemeColors.gradientColorsLogin,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 105),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'A autenticação falhou, por favor tente novamente.',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: checkLocalAuth,
                              child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Icon(
                                          Icons.person_2_outlined,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: SizedBox(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: (widget.user != null)
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Seja bem-vindo(a)!',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,
                                                    ),
                                                    Text(widget.user!.fullname)
                                                  ],
                                                )
                                              : Text(
                                                  'Seja bem-vindo(a)!',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Icon(
                                        FontAwesome.fingerprint,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('saved-accounts')
                                        .then((value) {
                                      if (value != null) {
                                        value = value as User;
                                        widget.user = value;
                                        setState(() {});
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    BoxIcons.bx_refresh,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  label: Text(
                                    'Trocar de conta',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background-login.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: ThemeColors.gradientColorsLogin,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: checkLocalAuth,
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Icon(
                                        Icons.person_2_outlined,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: SizedBox(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: (widget.user != null)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Seja bem-vindo(a)!',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall,
                                                  ),
                                                  Text(widget.user!.fullname)
                                                ],
                                              )
                                            : Text(
                                                'Seja bem-vindo(a)!',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Icon(
                                      FontAwesome.fingerprint,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('saved-accounts')
                                      .then((value) {
                                    if (value != null) {
                                      value = value as User;
                                      widget.user = value;
                                      setState(() {});
                                    }
                                  });
                                },
                                icon: Icon(
                                  BoxIcons.bx_refresh,
                                  color: Theme.of(context).highlightColor,
                                ),
                                label: Text(
                                  'Trocar de conta',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  getPreferencesAccountAccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = await prefs.getString('name');
    User.selectInitUser(name).then((value) {
      try {
        if (value[0] != null) {
          setState(() {
            widget.user = value[0];
          });
        }
      } catch (e) {}
    });
  }
}
