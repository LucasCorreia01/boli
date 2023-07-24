import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text('Buenos días!'),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
        ],
      ),
    );
  }
}