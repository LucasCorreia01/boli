import 'package:boli_digital_bank/screens/sections/home_screens_sections/balance_section.dart';
import 'package:boli_digital_bank/screens/sections/home_screens_sections/income_section.dart';
import 'package:boli_digital_bank/screens/sections/home_screens_sections/saving_section.dart';
import 'package:boli_digital_bank/screens/sections/home_screens_sections/spending_section.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String salutation = 'Bom dia';
  @override
  void initState(){
    salutation = funcSalutation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$salutation, Lucas!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BalanceSection(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SavingSection(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: IncomeSection(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SpendingSection(),
          )
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
            // icon: Icon(Bootstrap.house_door_fill),
            icon: Icon(BoxIcons.bxs_home),
            label: '',
          ),
          BottomNavigationBarItem(
            // icon: Icon(FontAwesome.camera),
            icon: Icon(BoxIcons.bx_camera),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(BoxIcons.bx_bar_chart_alt_2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: '',
          ),
        ],
      ),
    );
  }

    String funcSalutation(){
    DateTime now = DateTime.now();
    if(now.hour >= 6 && now.hour <= 11){
      return 'Bom dia';
    } else if(now.hour >= 12 && now.hour <= 18){
      return 'Boa tarde';
    } else if(now.hour >= 19 && now.hour <= 5){
      return 'Boa noite';
    }
    return 'Boa noite';

  }
}
