import 'package:boli/routes.dart';
import 'package:boli/services/user_auth_service.dart';
import 'package:boli/theme/boli_theme_light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:boli/theme/boli_theme_dark.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );

  SystemChrome.setSystemUIOverlayStyle ( 
      SystemUiOverlayStyle ( 
        statusBarColor: Colors.black, // status de cor da barra superiorBarIconBrightness 
      ) 
  ); 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Caso seja a primeira vez que as prefs forem criadas
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('notifications') == null ||
      prefs.getBool('fingerprint') == null) {
    prefs.setBool('notifications', false);
    prefs.setBool('fingerprint', false);
  }

  UserAuthService userAuthService = UserAuthService();
  print(userAuthService.firebaseAuth.currentUser);

  // ExtractAccount.getallExtracts();
  runApp(const MainApp());
}

var theme = boliThemeDark;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    changeTheme();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    changeTheme();
  }

  changeTheme() {
    var brightness = WidgetsBinding.instance!.window.platformBrightness;
    brightness == Brightness.dark
        ? theme = boliThemeDark
        : theme = boliThemeLight;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      color: Colors.yellow,
      initialRoute: 'login-screen',
      onGenerateRoute: (settings) => generatePageRoute(settings),
      debugShowCheckedModeBanner: false,
    );
  }
}
