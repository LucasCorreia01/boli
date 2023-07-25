import 'package:boli_digital_bank/screens/autentication_screen.dart';
import 'package:boli_digital_bank/screens/card_screen.dart';
import 'package:boli_digital_bank/screens/home_screen.dart';
import 'package:boli_digital_bank/theme/boli_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, systemNavigationBarColor: Colors.black));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: boliTheme,
      initialRoute: 'login-screen',
      onGenerateRoute: (settings) {
        if (settings.name == 'login-screen') {
          return MaterialPageRoute(builder: (context) {
            return const AuthenticationScreen();
          });
        } else if (settings.name == 'home-screen') {
          return MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          });
        } else if (settings.name == 'screen-card') {
            return PageTransition(
              settings: settings,
              type: PageTransitionType.bottomToTop,
              child: const CardScreen(),
              childCurrent: const HomeScreen(),
              isIos: true
            );
        } else {
          return MaterialPageRoute(builder: (context) {
            return const AuthenticationScreen();
          });
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
