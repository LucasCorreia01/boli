import 'package:flutter/material.dart';

class CardCredit {
  final String balanceCard;
  final String cardNumber;
  final String cvv;
  final String dueDate;
  final Color colorCard;
  final Color colorText;
  final IconData iconCard;
  final String nameCard;
  String? imageLogo; 
  CardCredit({
    required this.balanceCard,
    required this.cardNumber,
    required this.cvv,
    required this.dueDate,
    required this.colorCard,
    required this.colorText,
    required this.iconCard,
    required this.nameCard, 
    this.imageLogo
  });
}
