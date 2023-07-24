import 'package:boli_digital_bank/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background-login.png'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
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
                              width:
                                  (MediaQuery.of(context).size.width * 0.28) -
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
                              width:
                                  (MediaQuery.of(context).size.width * 0.6343) -
                                      48,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Seja bem-vindo(a)!',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width * 0.33) -
                                      48,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorDark),
                              child: Icon(
                                FontAwesome.fingerprint,
                                color: Theme.of(context).highlightColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            BoxIcons.bx_refresh,
                            color: Theme.of(context).highlightColor,
                          ),
                          label: Text(
                            'Trocar de conta',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
