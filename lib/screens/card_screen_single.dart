import 'package:boli_digital_bank/screens/sections/card_screen_single_sections/actions_buttons.dart';
import 'package:boli_digital_bank/screens/sections/card_screen_single_sections/card_section.dart';
import 'package:boli_digital_bank/screens/sections/card_screen_single_sections/invoices_section.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../models/cardCreditItemModel.dart';

// ignore: must_be_immutable
class CardScreenSingle extends StatelessWidget {
  CardCredit card;
  CardScreenSingle(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          card.nameCard,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CardSection(card),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: ActionsButtons(),
          ),
          InvoicesSection()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).dividerColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(BoxIcons.bxs_home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(BoxIcons.bx_camera),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(BoxIcons.bx_bar_chart_alt_2),
            label: 'Investimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
