import 'package:flutter/material.dart';
import '../models/user.dart';

class ItemUserAcess extends StatelessWidget {
  final User user;
  const ItemUserAcess({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    String abbreviation = user.name.substring(0,2);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(child: Text(abbreviation, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name} ${user.lastName}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ID: ${user.id}',
                    style: const  TextStyle(
                        fontSize: 15, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
