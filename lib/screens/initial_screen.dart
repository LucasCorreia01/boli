import 'package:boli_digital_bank/screens/home_screen.dart';
import 'package:boli_digital_bank/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool balanceVisibility = false;
  String salutation = 'Bom dia';
  @override
  void initState() {
    salutation = funcSalutation();
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$salutation, Lucas!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                balanceVisibility = !balanceVisibility;
              });
            },
            icon: (balanceVisibility)
                ? const Icon(Icons.visibility_off_outlined)
                : const Icon(Icons.visibility_outlined),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('login-screen');
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: pages(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).dividerColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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

  String funcSalutation() {
    DateTime now = DateTime.now();
    if (now.hour >= 6 && now.hour <= 11) {
      return 'Bom dia';
    } else if (now.hour >= 12 && now.hour <= 18) {
      return 'Boa tarde';
    } else if (now.hour >= 19 && now.hour <= 5) {
      return 'Boa noite';
    }
    return 'Boa noite';
  }

  Widget pages(int index) {
    List<Widget> pages = [
      HomeScreen(balanceVisibility: balanceVisibility),
      Container(),
      Container(),
      NotificationsScreen(),
    ];
    return pages[index];
  }
}
