import 'package:flutter/material.dart';

class ListItemNotification extends StatelessWidget {
  final String title;
  final String content;
  const ListItemNotification({required this.title, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            const Expanded(
                flex: 4, child: Icon(Icons.notifications_active_outlined)),
            Expanded(
              flex: 14,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      content,
                      style: const TextStyle(fontSize: 14.5, overflow: TextOverflow.visible),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
