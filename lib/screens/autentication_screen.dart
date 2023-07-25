import 'package:boli_digital_bank/service/local_auth_service.dart';
import 'package:boli_digital_bank/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:icons_plus/icons_plus.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

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
        Navigator.of(context).pushReplacementNamed('home-screen');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      fit: BoxFit.cover)),
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
                                  style: Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width *
                                            0.300) -
                                        48,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Icon(
                                      Icons.person_2_outlined,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width *
                                            0.68) -
                                        48,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Seja bem-vindo(a)!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: checkLocalAuth,
                                    child: Icon(
                                      FontAwesome.fingerprint,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  print(MediaQuery.of(context).size.width);
                                },
                                icon: Icon(
                                  BoxIcons.bx_refresh,
                                  color: Theme.of(context).highlightColor,
                                ),
                                label: Text(
                                  'Trocar de conta',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            ;
          }
          return Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background-login.png'),
                    fit: BoxFit.cover)),
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
                          horizontal: 24.0, vertical: 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width *
                                          0.300) -
                                      48,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.person_2_outlined,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width *
                                          0.68) -
                                      48,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Seja bem-vindo(a)!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: checkLocalAuth,
                                  child: Icon(
                                    FontAwesome.fingerprint,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                )
                              ],
                            ),
                          ),
                          TextButton.icon(
                              onPressed: () {
                                print(MediaQuery.of(context).size.width);
                              },
                              icon: Icon(
                                BoxIcons.bx_refresh,
                                color: Theme.of(context).highlightColor,
                              ),
                              label: Text(
                                'Trocar de conta',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ))
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
}
