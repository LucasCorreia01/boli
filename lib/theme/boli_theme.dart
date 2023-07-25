import 'package:boli_digital_bank/theme/theme_colors.dart';
import 'package:flutter/material.dart';

ThemeData boliTheme = ThemeData(
  primaryColor: ThemeColors.primaryColor,
  primarySwatch: ThemeColors.primarySwatch,
  primaryColorDark: ThemeColors.onPrimaryColor,
  dividerColor: ThemeColors.onSecondaryColor,
  cardColor: ThemeColors.onPrimaryColor,
  highlightColor: Colors.white,
  fontFamily: 'DM Sans',
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: ThemeColors.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
    titleMedium: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: ThemeColors.onPrimaryColor,
      overflow: TextOverflow.ellipsis
    ),
    titleSmall: TextStyle(
      color: ThemeColors.onPrimaryColor,
      fontSize: 15,
      overflow: TextOverflow.ellipsis
    ),
    headlineSmall: TextStyle(
      color: ThemeColors.onPrimaryColor,
      fontSize: 16,
      overflow: TextOverflow.ellipsis
    ),
    headlineMedium: TextStyle(
      color: ThemeColors.onPrimaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis
    ),
    headlineLarge: const TextStyle(
      color: ThemeColors.highlightColor,
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
      color: ThemeColors.onPrimaryColor,
    )
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
