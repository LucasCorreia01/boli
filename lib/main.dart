// ignore_for_file: depend_on_referenced_packages
import 'package:boli/screens/autentication_screen.dart';
import 'package:boli/screens/cards_screen.dart';
import 'package:boli/screens/card_screen_single.dart';
import 'package:boli/screens/initial_screen.dart';
import 'package:boli/screens/income_screen_single.dart';
import 'package:boli/screens/savings_screen_single.dart';
import 'package:boli/theme/boli_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'models/cardCreditItemModel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: boliTheme,
      initialRoute: 'login_screen',
      onGenerateRoute: (settings) {
        if (settings.name == 'login-screen') {
          return MaterialPageRoute(builder: (context) {
            return const AuthenticationScreen();
          });
        } else if (settings.name == 'home-screen') {
          return MaterialPageRoute(builder: (context) {
            return const InitialScreen();
          });
        } else if (settings.name == 'screen-card') {
          return PageTransition(
              settings: settings,
              type: PageTransitionType.bottomToTop,
              child: CardScreen(),
              childCurrent: const InitialScreen(),
              isIos: true);
        } else if (settings.name == 'screen-card-single') {
          var arguments = settings.arguments as CardCredit;
          return PageTransition(
            settings: settings,
            type: PageTransitionType.rightToLeftJoined,
            child: CardScreenSingle(arguments),
            childCurrent: CardScreen(),
            isIos: true,
          );
        } else if (settings.name == 'saving-screen-single') {
          return MaterialPageRoute(builder: (context) {
            return const SavingScreenSingle();
          });
        } else if (settings.name == 'income-screen-single') {
          var arguments = settings.arguments as Map<String, String>;
          return PageTransition(
            child: IncomeScreenSingle(
              nameIncome: arguments['nameIncome']!,
              balance: arguments['balance']!,
            ),
            type: PageTransitionType.bottomToTop,
            childCurrent: const InitialScreen(),
            isIos: true,
            settings: settings,
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
