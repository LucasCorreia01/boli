import 'package:boli/screens/home_screen.dart';
import 'package:boli/screens/extract_account_screen_home.dart';
import 'package:boli/screens/sections/profile_section/profile_screen.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/main_screen_new.dart';
import 'package:boli/services/user_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animations/animations.dart';

import '../components/camera_page.dart';
import '../models/user.dart';

class InitialScreen extends StatefulWidget {
  User user;
  InitialScreen({required this.user, super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool balanceVisibility = true;
  String salutation = 'Bom dia';
  final UserAuthService _userAuthService = UserAuthService();

  int _currentIndex = 0;

  @override
  void initState() {
    salutation = funcSalutation();
    setupListeners();
    super.initState();
  }

  @override
  void dispose() {
    _userAuthService.logoff();
    super.dispose();
  }

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
          (_currentIndex == 0)
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      balanceVisibility = !balanceVisibility;
                    });
                  },
                  icon: (balanceVisibility)
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                )
              : const SizedBox(),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'login-screen', (Route<dynamic> route) => false);
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
        selectedItemColor: Theme.of(context).indicatorColor,
        unselectedItemColor: Theme.of(context).indicatorColor,
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
            activeIcon: Icon(BoxIcons.bxs_home),
            icon: Icon(BoxIcons.bx_home),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(BoxIcons.bxs_camera),
            icon: Icon(BoxIcons.bx_camera),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(BoxIcons.bx_list_ul),
            icon: Icon(BoxIcons.bx_list_ul),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person_2),
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
      HomeScreen(
        refresh: refresh,
        balanceVisibility: balanceVisibility,
        user: widget.user,
      ),
      Container(),
      MainScreenNew(
        user: widget.user,
      ),
      ExtractAccountScreenHome(
        user: widget.user,
      ),
      ProfileScreen(
        user: widget.user,
      )
    ];
    return pages[index];
  }

  setupListeners() async{
   
    FirebaseFirestore.instance
        .collection('users')
        .doc(_userAuthService.getUid())
        .snapshots()
        .listen((snapshot) {
      refresh(snapshot: snapshot);
    });
  }

  refresh({DocumentSnapshot<Map<String, dynamic>>? snapshot}) async {
    if (snapshot != null) {
      User user = User.fromMap(snapshot.data()!);
      setState(() {
        widget.user = user;
      });
    }
  }
}
