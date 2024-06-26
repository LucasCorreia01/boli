// ignore_for_file: depend_on_referenced_packages
import 'package:boli/components/show_snackbar.dart';
import 'package:boli/models/saved_accounts.dart';
import 'package:boli/services/account_service.dart';
import 'package:boli/services/local_auth_service.dart';
import 'package:boli/services/user_auth_service.dart';
import 'package:boli/theme/theme_colors_light.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:local_auth/local_auth.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/camera_page.dart';
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
  int index = 0;

  checkLocalAuth() async {
    final auth = LocalAuthService(auth: LocalAuthentication());
    final isLocalAuthAvailable = await auth.isBiometricAvailable();
    isLocalAuthFailed.value = false;
    final UserAuthService userAuthService = UserAuthService();

    if (isLocalAuthAvailable) {
      final authenticated = await auth.authenticate();

      if (!authenticated) {
        isLocalAuthFailed.value = true;
      } else {
        await userAuthService
            .login(
          email: widget.user!.email,
          password: widget.user!.password,
        )
            .then(
          (error) {
            if (error == null) {
              AccountService().updateLastSeen();
              // Navigator.of(context).pushNamedAndRemoveUntil('loading-screen', (Route<dynamic> route) => false);
              setState(() {
                index = 1;
              });
              userAuthService.getUserLoggedData().then(
                (result) {
                  if (result['error'] == null) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      'home-screen',
                      arguments: result['user'],
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    showSnackBar(
                      context: context,
                      content:
                          'Um erro inesperado aconteceu: \n${result['error']}',
                      isErro: true,
                    );
                  }
                },
              );
            } else {
              showSnackBar(
                context: context,
                content: 'Um erro inesperado aconteceu: \n$error',
                isErro: true,
              );
            }
          },
        );
      }
    }
  }

  @override
  void initState() {
    getPreferencesAccountAccess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (index == 0)
          ? ValueListenableBuilder<bool>(
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
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
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
                                  horizontal: 24.0, vertical: 105),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'A autenticação falhou, por favor tente novamente.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: checkLocalAuth,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: (widget.user != null)
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Seja bem-vindo(a)!',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineSmall,
                                                          ),
                                                          Text(
                                                            widget
                                                                .user!.fullName,
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      43,
                                                                      43,
                                                                      63,
                                                                      1),
                                                            ),
                                                          )
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
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('saved-accounts')
                                              .then((value) {
                                            if (value != null) {
                                              value = value as SavedAccounts;
                                              var user = User(
                                                name: value.name,
                                                lastName: value.lastName,
                                                fullName: value.fullName,
                                                email: value.email,
                                                password: value.password,
                                                dateOfBirth: value.dateOfBirth,
                                                lastSeen: value.lastSeen,
                                              );
                                              setState(() {
                                                widget.user = user;
                                              });
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          BoxIcons.bx_refresh,
                                          color:
                                              Theme.of(context).highlightColor,
                                        ),
                                        label: Text(
                                          'Trocar de conta',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge,
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
                                            color: Theme.of(context)
                                                .highlightColor,
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
                                  onTap: checkLocalAuth,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: (widget.user != null)
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Seja bem-vindo(a)!',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall,
                                                        ),
                                                        Text(
                                                          widget.user!.fullName,
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          43,
                                                                          43,
                                                                          63,
                                                                          1)),
                                                        )
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
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('saved-accounts')
                                            .then((value) {
                                          if (value != null) {
                                            value = value as SavedAccounts;
                                            var user = User(
                                              name: value.name,
                                              lastName: value.lastName,
                                              fullName: value.fullName,
                                              email: value.email,
                                              password: value.password,
                                              dateOfBirth: value.dateOfBirth,
                                              lastSeen: value.lastSeen,
                                            );
                                            setState(() {
                                              widget.user = user;
                                            });
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
                                          color:
                                              Theme.of(context).highlightColor,
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
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  getPreferencesAccountAccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fullName = prefs.getString('fullName');
    User.selectInitUser(fullName).then((value) {
      try {
        if (value[0] != null && value[0].id != "") {
          setState(() {
            widget.user = value[0];
          });
        }
      } catch (e) {
        try {
          SavedAccounts.getAllUsers().then((value) {
            if (value.isNotEmpty && value[0].id != "") {
              setState(() {
                User user = User(
                    name: value[0].name,
                    lastName: value[0].lastName,
                    fullName: value[0].fullName,
                    email: value[0].email,
                    password: value[0].password,
                    dateOfBirth: value[0].dateOfBirth,
                    lastSeen: value[0].lastSeen);
                widget.user = user;
              });
            } else {
              showSnackBar(
                context: context,
                content: 'Nenhuma conta salva. Faça login primeiro.',
                isErro: true,
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, 'first-login', (Route<dynamic> route) => false);
            }
          });
        } catch (e) {
          showSnackBar(
            context: context,
            content: 'Nenhuma conta salva. Faça login primeiro.',
            isErro: true,
          );
          Navigator.pushNamedAndRemoveUntil(
              context, 'first-login', (Route<dynamic> route) => false);
        }
      }
    });
  }

  readQRCode() async{
    // String code = await FlutterBarcodeScanner.scanBarcode(
    //   "#FFFFFF",
    //   "Cancelar",
    //   true,
    //   ScanMode.QR,
    // );

  }
}
