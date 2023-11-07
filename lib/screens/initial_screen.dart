import 'package:boli/screens/home_screen.dart';
import 'package:boli/screens/extract_account_screen_home.dart';
import 'package:boli/screens/sections/profile_section/profile_screen.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/main_screen_new.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animations/animations.dart';

import '../components/camera_page.dart';
import '../models/user.dart';

class InitialScreen extends StatefulWidget {
  final User user;
  const InitialScreen({required this.user, super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool balanceVisibility = true;
  String salutation = 'Bom dia';
  @override
  void initState() {
    salutation = funcSalutation();
    widget.user.updateLastSeen();
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
            '$salutation, ${widget.user.name}!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        actions: [
          (_currentIndex == 0) ? IconButton(
            onPressed: () {
              setState(() {
                balanceVisibility = !balanceVisibility;
              });
            },
            icon: (balanceVisibility)
                ? const Icon(Icons.visibility_off_outlined)
                : const Icon(Icons.visibility_outlined),
          ): const SizedBox(),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('login-screen', (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            SharedAxisTransition(
          transitionType: SharedAxisTransitionType.horizontal,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: pages(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).dividerColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            if (index == 1) {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return const CameraPage();
                          },
                          fullscreenDialog: true))
                  .then((value) {
                setState(() {
                  _currentIndex = 0;
                });
              });
            }
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            // icon: Icon(Bootstrap.house_door_fill),
            icon: Icon(BoxIcons.bx_home),
            label: '',
          ),
          BottomNavigationBarItem(
            // icon: Icon(FontAwesome.camera),
            icon: Icon(BoxIcons.bx_camera),
            label: '',
          ),
          BottomNavigationBarItem(
            // icon: Icon(FontAwesome.camera),
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(BoxIcons.bx_list_ul),
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
      HomeScreen(balanceVisibility: balanceVisibility, user: widget.user,),
      Container(),
      MainScreenNew(user: widget.user,),
      ExtractAccountScreenHome(user: widget.user,),
      ProfileScreen(user: widget.user,)
    ];
    return pages[index];
  }

  update(){
    setState(() {
    });
  }
}
