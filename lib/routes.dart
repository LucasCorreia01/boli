// import 'package:flutter/material.dart';
// import 'package:boli_digital_bank/screens/autentication_screen.dart';
// import 'package:boli_digital_bank/screens/cards_screen.dart';
// import 'package:boli_digital_bank/screens/card_screen_single.dart';
// import 'package:boli_digital_bank/screens/home_screen.dart';
// import 'package:boli_digital_bank/screens/income_screen_single.dart';
// import 'package:boli_digital_bank/screens/savings_screen_single.dart';
// import 'package:boli_digital_bank/theme/boli_theme.dart';
// import 'package:page_transition/page_transition.dart';
// import 'models/cardCreditItemModel.dart';

// class Routes {
//   onGenerateRoute(settings) {
//     if (settings.name == 'login-screen') {
//       return MaterialPageRoute(builder: (context) {
//         return const AuthenticationScreen();
//       });
//     } else if (settings.name == 'home-screen') {
//       return MaterialPageRoute(builder: (context) {
//         return const HomeScreen();
//       });
//     } else if (settings.name == 'screen-card') {
//       return PageTransition(
//           settings: settings,
//           type: PageTransitionType.bottomToTop,
//           child: const CardScreen(),
//           childCurrent: const HomeScreen(),
//           isIos: true);
//     } else if (settings.name == 'screen-card-single') {
//       var arguments = settings.arguments as CardCredit;
//       return PageTransition(
//         settings: settings,
//         type: PageTransitionType.rightToLeftJoined,
//         child: CardScreenSingle(arguments),
//         childCurrent: const CardScreen(),
//         isIos: true,
//       );
//     } else if (settings.name == 'saving-screen-single') {
//       return MaterialPageRoute(builder: (context) {
//         return const SavingScreenSingle();
//       });
//     } else if (settings.name == 'income-screen-single') {
//       var arguments = settings.arguments as Map<String, String>;
//       return PageTransition(
//         child: IncomeScreenSingle(
//           nameIncome: arguments['nameIncome'],
//           balance: arguments['balance'],
//         ),
//         type: PageTransitionType.bottomToTop,
//         childCurrent: const HomeScreen(),
//         isIos: true,
//         settings: settings,
//       );
//     } else {
//       return MaterialPageRoute(builder: (context) {
//         return const AuthenticationScreen();
//       });
//     }
//   }
// }
