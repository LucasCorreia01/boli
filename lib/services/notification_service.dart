import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class CustomNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _initializeNotifications();
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('mipmap-xxxhdpi/ic_launcher.png');
    const ios = IOSInitializationSettings();

    await localNotificationPlugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onSelectNotification: onSelectNotification,
    );
  }

  onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {}
  }

  showNotification(CustomNotification notification) {
    androidDetails = const AndroidNotificationDetails(
        'transitions_notification', 'Transções',
        channelDescription:
            'Este canal é para avisar sobre transações realizadas!',
        importance: Importance.max,
        priority: Priority.max,
        enableVibration: true);

    localNotificationPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        NotificationDetails(
          android: androidDetails,
        ),
        payload: notification.payload);
  }

  checkForNotifications() async {
    final details =
        await localNotificationPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onSelectNotification(details.payload);
    }
  }
}
