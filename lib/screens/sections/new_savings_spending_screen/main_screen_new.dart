import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../models/user.dart';

class MainScreenNew extends StatelessWidget {
  final User user;
  const MainScreenNew({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(241, 242, 244, 1),
              ),
              child: InkWell(
                onTap: () {
                  if (user.balance > 0) {
                    Navigator.pushNamed(context, 'new-savings',
                        arguments: user);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Você não tem saldo suficiente para criar uma poupança!')));
                  }
                },
                child: const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: Icon(
                          BoxIcons.bx_line_chart,
                          size: 36,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nova poupança',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Crie uma nova poupança, guarda o seu dinheiro e ainda ganha dinheiro.',
                            style: TextStyle(overflow: TextOverflow.visible),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(241, 242, 244, 1),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: Icon(
                        BoxIcons.bx_objects_vertical_bottom,
                        size: 36,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Adicionar gasto',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tenho controle dos seus gastos através da sua conta digital.',
                          style: TextStyle(overflow: TextOverflow.visible),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
