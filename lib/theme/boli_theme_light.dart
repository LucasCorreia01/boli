import 'package:boli/theme/theme_colors_light.dart';
import 'package:flutter/material.dart';

ThemeData boliThemeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: ThemeColorsLight.primaryColor,
  primarySwatch: ThemeColorsLight.primarySwatch,
  primaryColorDark: ThemeColorsLight.onPrimaryColor,
  primaryColorLight: const Color.fromRGBO(241, 242, 244, 1),
  dividerColor: ThemeColorsLight.onSecondaryColor,
  cardColor: Colors.transparent,
  indicatorColor: ThemeColorsLight.onPrimaryColor,
  highlightColor: Colors.white,
  fontFamily: 'DM Sans',
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: ThemeColorsLight.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
    titleMedium: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: ThemeColorsLight.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
    titleSmall: TextStyle(
      color: ThemeColorsLight.onPrimaryColor,
      fontSize: 15,
      overflow: TextOverflow.ellipsis
    ),
    headlineSmall: TextStyle(
      color: ThemeColorsLight.onPrimaryColor,
      fontSize: 16,
      overflow: TextOverflow.ellipsis
    ),
    headlineMedium: TextStyle(
      color: ThemeColorsLight.onPrimaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis
    ),
    headlineLarge: const TextStyle(
      color: ThemeColorsLight.highlightColor,
      fontSize: 14,
      overflow: TextOverflow.ellipsis
    ),
    bodyMedium: const TextStyle(
      fontSize: 13,
      overflow: TextOverflow.ellipsis
    ), 
    displayMedium: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.normal,
      color: ThemeColorsLight.onPrimaryColor,
    ),
     labelMedium: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: ThemeColorsLight.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(
      fontSize: 12,
    ),
  ),
);
