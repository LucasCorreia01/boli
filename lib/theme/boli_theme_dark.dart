import 'package:boli/theme/theme_colors_dark.dart';
import 'package:flutter/material.dart';

ThemeData boliThemeDark = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  canvasColor: Colors.black,
  brightness: Brightness.dark,
  primaryColor: ThemeColorsDark.primaryColor,
  primarySwatch: ThemeColorsDark.primarySwatch,
  primaryColorDark: ThemeColorsDark.onPrimaryColor,
  primaryColorLight: ThemeColorsDark.onSecondaryColor,
  dividerColor: ThemeColorsDark.onSecondaryColor,
  cardColor: ThemeColorsDark.onSecondaryColor,
  indicatorColor: Colors.white,
  highlightColor: Colors.white,
  splashColor: ThemeColorsDark.primaryColor,
  fontFamily: 'DM Sans',
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: ThemeColorsDark.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
    titleMedium: const TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      overflow: TextOverflow.ellipsis
    ),
    titleSmall: const TextStyle(
      color: Colors.white,
      fontSize: 15,
      overflow: TextOverflow.ellipsis
    ),
    headlineSmall: TextStyle(
      color: ThemeColorsDark.onPrimaryColor,
      fontSize: 16,
      overflow: TextOverflow.ellipsis
    ),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis
    ),
    headlineLarge: const TextStyle(
      color: ThemeColorsDark.highlightColor,
      fontSize: 14,
      overflow: TextOverflow.ellipsis
    ),
    bodyMedium: const TextStyle(
      fontSize: 13,
      overflow: TextOverflow.ellipsis,
      color: Colors.white
    ), 
    displayMedium: const TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 15,
      color: ThemeColorsDark.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
    labelMedium: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: ThemeColorsDark.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ThemeColorsDark.primaryColor
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(
      fontSize: 12,
      color: Colors.white
    ),
  ),
);

