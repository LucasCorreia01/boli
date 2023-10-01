import 'package:boli/screens/autentication_screen.dart';
import 'package:flutter/material.dart';

class RoutesBoliBank {
  RouteSettings settings;

  RoutesBoliBank(this.settings){
    routes[settings.name];
  }

  var routes = <String, WidgetBuilder>{
    "/": (BuildContext context) {
      return AuthenticationScreen();
    }
  };
}
