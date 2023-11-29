import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../components/camera_page.dart';
import '../models/user.dart';
import '../theme/theme_colors_light.dart';

class LoginFormScreen extends StatefulWidget {
  User? user;  
  LoginFormScreen({this.user, super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                      colors: ThemeColorsLight.gradientColorsLogin,
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
                            onTap: (){
                              Navigator.pushNamed(context, 'form-login-screen');
                            },
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
                                                    'Fazer login em uma conta.',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall,
                                                  ),
                                                  Text(widget.user!.fullname)
                                                ],
                                              )
                                            : Text(
                                                'Fazer login.',
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
                                      FontAwesome.keyboard,
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
                                  Navigator.of(context).pushNamed('new-user-screen');
                                  // Navigator.of(context)
                                  //     .pushNamed('saved-accounts')
                                  //     .then((value) {
                                  //   if (value != null) {
                                  //     value = value as User;
                                  //     widget.user = value;
                                  //     setState(() {});
                                  //   }
                                  // });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Theme.of(context).highlightColor,
                                ),
                                label: Text(
                                  'Criar conta',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) {
                                              return const CameraPage();
                                            },
                                            fullscreenDialog: true));
                                  },
                                  icon: Icon(
                                    BoxIcons.bx_qr_scan,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                  label: const SizedBox()),
                            ],
                          )
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
