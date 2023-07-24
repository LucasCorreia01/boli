import 'package:boli_digital_bank/screens/autentication_screen.dart';
import 'package:boli_digital_bank/screens/home_screen.dart';
import 'package:boli_digital_bank/theme/boli_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    systemNavigationBarColor: Colors.black
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: boliTheme,
      home: AuthenticationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
