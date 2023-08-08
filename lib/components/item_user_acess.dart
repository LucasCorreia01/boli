import 'package:flutter/material.dart';

class ItemUserAcess extends StatelessWidget {
  final String name;
  final String abbreviation;
  const ItemUserAcess({required this.name, required this.abbreviation, super.key});

  @override
  Widget build(BuildContext context) {
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
                    name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'ID: c99e57e0-20ae-11ee-9a53-332097d095ae',
                    style: TextStyle(
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
