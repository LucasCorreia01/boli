// ignore_for_file: depend_on_referenced_packages
import 'package:boli/models/user.dart';
import 'package:boli/screens/autentication_screen.dart';
import 'package:boli/screens/cards_screen.dart';
import 'package:boli/screens/card_screen_single.dart';
import 'package:boli/screens/general_settings_screen.dart';
import 'package:boli/screens/home_screen.dart';
import 'package:boli/screens/initial_screen.dart';
import 'package:boli/screens/income_screen_single.dart';
import 'package:boli/screens/new_user_screen.dart';
import 'package:boli/screens/saved_accounts.dart';
import 'package:boli/screens/savings_screen_single.dart';
import 'package:boli/screens/sections/new_user_sections.dart/loading_creation_screen.dart';
import 'package:boli/theme/boli_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/cardCreditItemModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
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

  // Caso seja a primeira vez que as prefs forem criadas
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('notifications') == null ||
      prefs.getBool('fingerprint') == null) {
    prefs.setBool('notifications', false);
    prefs.setBool('fingerprint', false);
  }

  User.getUsers();
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
            return const InitialScreen();
          });
        } else if (settings.name == 'screen-card') {
          return PageTransition(
              settings: settings,
              type: PageTransitionType.bottomToTop,
              child: const CardScreen(),
              childCurrent: const InitialScreen(),
              isIos: true);
        } else if (settings.name == 'screen-card-single') {
          var arguments = settings.arguments as CardCredit;
          return PageTransition(
            settings: settings,
            type: PageTransitionType.rightToLeftJoined,
            child: CardScreenSingle(arguments),
            childCurrent: const CardScreen(),
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
        } else if (settings.name == 'general-settings') {
          return PageTransition(
              settings: settings,
              type: PageTransitionType.rightToLeft,
              child: const GeneralSettingsScreen(),
              childCurrent: const InitialScreen(),
              isIos: true);
        } else if (settings.name == 'new-user-screen') {
          return PageTransition(
              settings: settings,
              child: const NewUserScreen(),
              type: PageTransitionType.bottomToTop,
              fullscreenDialog: true);
        } else if (settings.name == 'saved-accounts') {
          return PageTransition(
            settings: settings,
            child: const SavedAccountsScreen(),
            type: PageTransitionType.bottomToTop,
          );
        } else if (settings.name == 'loading_creation_screen') {
          return PageTransition(
            settings: settings,
            child: const LoadingCreationScreen(),
            type: PageTransitionType.rightToLeft,
          );
        } else if(settings.name == 'loading_creation_screen-home'){
          return PageTransition(
            settings: settings,
            child: const InitialScreen(),
            childCurrent: const LoadingCreationScreen(),
            type: PageTransitionType.leftToRightJoined
          );
        } else {
          return MaterialPageRoute(builder: (context) {
            return const AuthenticationScreen();
          });
        }
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('pt')],
    );
  }
}
