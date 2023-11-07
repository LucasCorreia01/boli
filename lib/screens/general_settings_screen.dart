import 'package:boli/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_settings/app_settings.dart';
import 'package:provider/provider.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({super.key});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  bool? isOnFingerprint;
  bool? isOnNotifications;

  @override
  void initState() {
    //TODO:: Arrumar uma maneira de fazer essa função ser executada antes do build
    getInitiPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Geral',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        toolbarHeight: 60,
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(241, 242, 244, 1)),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 10, 20),
                child: Text(
                  'CONFIGURAÇÕES',
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Icon(
                      FontAwesome.fingerprint,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 58,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(241, 242, 244, 1),
                          ),
                        )),
                        child: Row(
                          children: [
                            const Expanded(
                                flex: 9,
                                child: Text(
                                  'Entrar utilizando a digital',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                              flex: 2,
                              child: Switch(
                                // thumb color (round icon)
                                activeColor: Colors.white70,
                                activeTrackColor:
                                    Theme.of(context).primaryColor,
                                inactiveThumbColor: Colors.blueGrey,
                                inactiveTrackColor: Colors.grey,
                                splashRadius: 50.0,
                                // boolean variable value
                                value: isOnFingerprint!,
                                // changes the state of the switch
                                onChanged: (value) {
                                  setState(() {
                                    isOnFingerprint = !isOnFingerprint!;
                                    switchFingerprint(isOnFingerprint!);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Icon(
                      Icons.notifications_none_outlined,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 58,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(241, 242, 244, 1),
                          ),
                        )),
                        child: Row(
                          children: [
                            const Expanded(
                                flex: 9,
                                child: Text(
                                  'Receber notificações',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                              flex: 2,
                              child: Switch(
                                // thumb color (round icon)
                                activeColor: Colors.white70,
                                activeTrackColor:
                                    Theme.of(context).primaryColor,
                                inactiveThumbColor: Colors.blueGrey,
                                inactiveTrackColor: Colors.grey,
                                splashRadius: 50.0,
                                // boolean variable value
                                value: isOnNotifications!,
                                // changes the state of the switch
                                onChanged: (value) {
                                  setState(() {
                                    isOnNotifications = !isOnNotifications!;
                                    switchNotification(isOnNotifications!);
                                    if (value) {
                                      Provider.of<NotificationService>(context,
                                              listen: false)
                                          .showNotification(CustomNotification(
                                              id: 1,
                                              title: 'Notificações ligadas!',
                                              body:
                                                  'Agora você receberá notificações no app!',
                                              payload: ''));
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(241, 242, 244, 1)),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(24, 40, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AVANÇADO',
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Configure acessos e permissões do aplicativo Boli no sistema do seu telefone',
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(241, 242, 244, 1),
                ),
              )),
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: InkWell(
                  onTap: openAppSettings,
                  child: const SizedBox(
                    height: 58,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 9,
                            child: Text(
                              'Configurações do sistema',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 2,
                            child: Icon(Icons.keyboard_arrow_right_outlined)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void switchFingerprint(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fingerprint', value);
  }

  void switchNotification(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', value);
  }

  void openAppSettings() {
    AppSettings.openAppSettings();
  }

  Future<void> getInitiPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isOnFingerprint = prefs.getBool('fingerprint')!;
    isOnNotifications = prefs.getBool('notifications')!;
    setState(() {});
  }
}
