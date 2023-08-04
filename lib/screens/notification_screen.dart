import 'package:boli_digital_bank/components/list_item_notification.dart';
import 'package:boli_digital_bank/helpers/exemples.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final List<Map<String, String>> notifications = getListItensNotifications();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Text(
            'Notificações:',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return ListItemNotification(
            title: notifications[index]['title']!,
            content: notifications[index]['content']!,
          );
        }, childCount: notifications.length))
      ],
    );
  }
}
