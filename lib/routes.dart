import 'package:boli/components/loading_screen.dart';
import 'package:boli/screens/actions/global_transfer_screen.dart';
import 'package:boli/screens/actions/payment_qr_screen.dart';
import 'package:boli/screens/actions/receive_money.dart';
import 'package:boli/screens/actions/send_money.dart';
import 'package:boli/screens/autentication_screen.dart';
import 'package:boli/screens/card_screen_single.dart';
import 'package:boli/screens/cards_screen.dart';
import 'package:boli/screens/general_settings_screen.dart';
import 'package:boli/screens/income_screen_single.dart';
import 'package:boli/screens/initial_screen.dart';
import 'package:boli/screens/login_form_screen.dart';
import 'package:boli/screens/new_user_screen.dart';
import 'package:boli/screens/saved_accounts.dart';
import 'package:boli/screens/savings_screen_single.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_date_form_screen.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_email_form_screen.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_information.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_name_form_screen.dart';
import 'package:boli/screens/sections/edit_infomations_section/edit_password_form_screen.dart';
import 'package:boli/screens/sections/extract_account/extract_screen.dart';
import 'package:boli/screens/sections/login_section/login_screen_main.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/creating_saving.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/new_savings_screen.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/single_savings_screen.dart';
import 'package:boli/screens/sections/new_user_sections/loading_creation_screen.dart';
import 'package:boli/screens/sections/profile_section/all_users_screen.dart';
import 'package:boli/screens/transfer_voucher/transfer_voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'models/card_credit_item_model.dart';
import 'models/user.dart';

PageRoute generatePageRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'login-screen':
      return PageTransition(
        settings: settings,
        child: AuthenticationScreen(),
        type: PageTransitionType.leftToRight,
      );

    case 'home-screen':
      User user = settings.arguments as User;
      return PageTransition(
        settings: settings,
        child: InitialScreen(user: user),
        type: PageTransitionType.bottomToTop,
      );

    case 'screen-card':
      var user = settings.arguments as User;
      return PageTransition(
        settings: settings,
        type: PageTransitionType.bottomToTop,
        child: CardScreen(
          user: user,
        ),
      );

    case 'screen-card-single':
      var arguments = settings.arguments as CardCredit;
      return PageTransition(
        settings: settings,
        type: PageTransitionType.rightToLeftJoined,
        child: CardScreenSingle(arguments),
        childCurrent: const CardScreen(),
        isIos: true,
      );

    case 'saving-screen-single':
      return MaterialPageRoute(
        builder: (context) {
          return const SavingScreenSingle();
        },
      );

    case 'income-screen-single':
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

    case 'general-settings':
      return PageTransition(
        settings: settings,
        type: PageTransitionType.rightToLeft,
        child: const GeneralSettingsScreen(),
        isIos: true,
      );

    case 'new-user-screen':
      return PageTransition(
        settings: settings,
        child: const NewUserScreen(),
        type: PageTransitionType.bottomToTop,
        fullscreenDialog: true,
      );

    case 'saved-accounts':
      return PageTransition(
        settings: settings,
        child: const SavedAccountsScreen(),
        type: PageTransitionType.bottomToTop,
      );

    case 'loading_creation_screen':
      return PageTransition(
        settings: settings,
        child: const LoadingCreationScreen(),
        type: PageTransitionType.rightToLeft,
      );

    case 'receive_money':
      var user = settings.arguments as User;
      return PageTransition(
        child: ReceiveMoney(
          user: user,
        ),
        type: PageTransitionType.bottomToTop,
        fullscreenDialog: true,
      );

    case 'send_money':
      var user = settings.arguments as User;
      return PageTransition(
        child: SendMoney(
          user: user,
        ),
        type: PageTransitionType.bottomToTop,
        fullscreenDialog: true,
      );

    case 'transfer-voucher':
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

    case 'choose-edit-informations':
      return PageTransition(
        child: ChooseEditInformationsScreen(
          user: settings.arguments as User,
        ),
        type: PageTransitionType.bottomToTop,
      );

    case 'edit-form-screen':
      var arguments = settings.arguments as Map<String, dynamic>;
      switch (arguments["information"]) {
        case 1:
          return PageTransition(
            child: EditNameFormScreen(
              user: arguments["user"],
            ),
            type: PageTransitionType.rightToLeft,
          );

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

    case 'extract-screen':
      return PageTransition(
        child: ExtractAccountScreen(
          user: settings.arguments as User,
        ),
        type: PageTransitionType.bottomToTop,
      );

    case 'new-savings':
      User user = settings.arguments as User;
      return PageTransition(
        child: NewSavingsScreen(
          user: user,
        ),
        type: PageTransitionType.rightToLeft,
      );

    case 'loading_creation_screen_saving':
      User user = settings.arguments as User;
      return PageTransition(
        settings: settings,
        child: CreatingSaving(user),
        type: PageTransitionType.rightToLeft,
      );

    case 'single_savings_screen':
      Map<String, dynamic> savings = settings.arguments as Map<String, dynamic>;
      return PageTransition(
        settings: settings,
        child: SingleSavingsScreen(savings),
        type: PageTransitionType.rightToLeft,
      );

    case 'global_transfer':
      return PageTransition(
        settings: settings,
        child: const GlobalTransferScreen(),
        type: PageTransitionType.bottomToTop,
        fullscreenDialog: true,
      );

    case 'payment_qr':
      return PageTransition(
        settings: settings,
        child: const PaymentQrScreen(),
        type: PageTransitionType.rightToLeft,
        fullscreenDialog: true,
      );

    case 'first-login':
      return PageTransition(
        child: LoginFormScreen(),
        type: PageTransitionType.bottomToTop,
      );

    case 'form-login-screen':
      return PageTransition(
        child: const LoginScreenMain(),
        type: PageTransitionType.bottomToTop,
      );

    case 'all-users-screen':
      return PageTransition(
        child: const AllUsersScreen(),
        type: PageTransitionType.rightToLeft,
      );

    case 'loading-screen':
      return PageTransition(
          settings: settings,
          type: PageTransitionType.bottomToTop,
          child: const LoadingScreen());

    default:
      return MaterialPageRoute(
        builder: (context) {
          return AuthenticationScreen();
        },
      );
  }
  return MaterialPageRoute(
    builder: (context) {
      return AuthenticationScreen();
    },
  );
}
