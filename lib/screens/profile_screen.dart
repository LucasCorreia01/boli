import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(241, 242, 244, 1),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Icon(
                    Icons.person_2,
                    size: 30,
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lucas',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            'ID: c99e57e0-20ae-11ee-9a53-332097d095ae',
                            style: TextStyle(
                                fontSize: 15, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Text(
                          'Visto em 05/08/23 às 14:44',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
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
                  child: Icon(Icons.settings_outlined),
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
                      child: const Row(
                        children: [
                          Expanded(
                              flex: 9,
                              child: Text(
                                'Geral',
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
                  child: Icon(Icons.settings_outlined),
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
                      child: const Row(
                        children: [
                          Expanded(
                              flex: 9,
                              child: Text(
                                'Cadastro',
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
              ],
            ),
          ),
        )
      ],
    );
  }
}
