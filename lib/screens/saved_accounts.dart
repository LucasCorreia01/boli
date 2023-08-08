import 'package:boli/components/item_user_acess.dart';
import 'package:flutter/material.dart';

import '../helpers/exemples.dart';

class SavedAccountsScreen extends StatelessWidget {
  const SavedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> usersSaved = getListUsersSaved();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trocar acesso',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 10, 20),
              child: Text(
                'Contas salvas',
                style: TextStyle(
                    fontSize: 19,
                    letterSpacing: 0.75,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            return ItemUserAcess(name: usersSaved[index]["name"]!, abbreviation: usersSaved[index]["abbreviation"]!);
          }, childCount: usersSaved.length))
        ],
      ),
    );
  }
}
