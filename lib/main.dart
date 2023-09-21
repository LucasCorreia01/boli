import 'package:boli/screens/actions/receive_money.dart';
import 'package:boli/screens/actions/send_money.dart';
import 'package:boli/screens/autentication_screen.dart';
import 'package:boli/screens/cards_screen.dart';
import 'package:boli/screens/card_screen_single.dart';
import 'package:boli/screens/general_settings_screen.dart';
import 'package:boli/screens/initial_screen.dart';
import 'package:boli/screens/income_screen_single.dart';
import 'package:boli/screens/new_user_screen.dart';
import 'package:boli/screens/saved_accounts.dart';
import 'package:boli/screens/savings_screen_single.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_date_form_screen.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_email_form_screen.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_name_form_screen.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_information.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_password_form_screen.dart';
import 'package:boli/screens/sections/extract_account/extract_screen.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/creating_saving.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/new_savings_screen.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/single_savings_screen.dart';
import 'package:boli/screens/sections/new_user_sections.dart/loading_creation_screen.dart';
import 'package:boli/screens/transfer_voucher/transfer_voucher_screen.dart';
import 'package:boli/theme/boli_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/card_credit_item_model.dart';
import 'models/user.dart';

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
            return AuthenticationScreen();
          });
        } else if (settings.name == 'home-screen') {
          return MaterialPageRoute(builder: (context) {
            User user = settings.arguments as User;
            return InitialScreen(
              user: user,
            );
          });
        } else if (settings.name == 'screen-card') {
          var user = settings.arguments as User;
          return PageTransition(
              settings: settings,
              type: PageTransitionType.bottomToTop,
              child: CardScreen(
                user: user,
              ),
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
            isIos: true,
            settings: settings,
          );
        } else if (settings.name == 'general-settings') {
          return PageTransition(
              settings: settings,
              type: PageTransitionType.rightToLeft,
              child: const GeneralSettingsScreen(),
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
        } else if (settings.name == 'receive_money') {
          var user = settings.arguments as User;
          return PageTransition(
            child: ReceiveMoney(
              user: user,
            ),
            type: PageTransitionType.bottomToTop,
            fullscreenDialog: true,
          );
        } else if (settings.name == 'send_money') {
          var user = settings.arguments as User;
          return PageTransition(
            child: SendMoney(
              user: user,
            ),
            type: PageTransitionType.bottomToTop,
            fullscreenDialog: true,
          );
        } else if (settings.name == 'transfer-voucher') {
          var arguments = settings.arguments as Map<String, dynamic>;
          return PageTransition(
            child: TransferVoucherScreen(
              userSend: arguments["userSend"],
              userReceiver: arguments["userReceiver"],
              valueToTransfer: arguments["valueToTransfer"],
              date: arguments['date'],
            ),
            type: PageTransitionType.bottomToTop,
            fullscreenDialog: true,
          );
        } else if (settings.name == 'choose-edit-informations') {
          return PageTransition(
            child: ChooseEditInformationsScreen(
              user: settings.arguments as User,
            ),
            type: PageTransitionType.bottomToTop,
          );
        } else if (settings.name == 'edit-form-screen') {
          var arguments = settings.arguments as Map<String, dynamic>;
          switch (arguments["information"]) {
            case 1:
              return PageTransition(
                  child: EditNameFormScreen(
                    user: arguments["user"],
                  ),
                  type: PageTransitionType.rightToLeft);

            case 2:
              return PageTransition(
                child: EditEmailFormScreen(
                  user: arguments['user'],
                ),
                type: PageTransitionType.rightToLeft,
              );

            case 3:
              return PageTransition(
                child: EditPasswordFormScreen(
                  user: arguments['user'],
                ),
                type: PageTransitionType.rightToLeft,
              );

            case 4:
              return PageTransition(
                child: EditDateFormScreen(
                  user: arguments['user'],
                ),
                type: PageTransitionType.rightToLeft,
              );
          }
        } else if (settings.name == "extract-screen") {
          return PageTransition(
            child: ExtractAccountScreen(
              user: settings.arguments as User,
            ),
            type: PageTransitionType.bottomToTop,
          );
        } else if (settings.name == "new-savings") {
          User user = settings.arguments as User;
          return PageTransition(
              child: NewSavingsScreen(
                user: user,
              ),
              type: PageTransitionType.rightToLeft);
        } else if (settings.name == 'loading_creation_screen_saving') {
          User user = settings.arguments as User;
          return PageTransition(
            settings: settings,
            child: CreatingSaving(user),
            type: PageTransitionType.rightToLeft,
          );
        } else if (settings.name == 'single_savings_screen') {
          Map<String, dynamic> savings = settings.arguments as Map<String, dynamic>;
          return PageTransition(
            settings: settings,
            child: SingleSavingsScreen(savings),
            type: PageTransitionType.rightToLeft,
          );
        } else {
          return MaterialPageRoute(builder: (context) {
            return AuthenticationScreen();
          });
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
