import 'package:flutter/material.dart';

import '../../../models/user.dart';

class ChooseEditInformationsScreen extends StatelessWidget {
  final User user;
  const ChooseEditInformationsScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = {};
    map['user'] = user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColorLight),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(24, 30, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EDITAR',
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Qual informação você deseja alterar em sua conta?',
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
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Icon(Icons.edit),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )),
                        child: InkWell(
                          onTap: () {
                            map['information'] = 1;
                            Navigator.of(context).pushNamed('edit-form-screen', arguments: map);
                          },
                          child: const Row(
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: Text(
                                    'Nome',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Icon(
                                      Icons.keyboard_arrow_right_outlined)),
                            ],
                          ),
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
                    child: Icon(Icons.edit),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )),
                        child: InkWell(
                          onTap: () {
                            map['information'] = 2;
                            Navigator.of(context).pushNamed('edit-form-screen', arguments: map);
                          },
                          child: const Row(
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: Text(
                                    'E-mail',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Icon(
                                      Icons.keyboard_arrow_right_outlined)),
                            ],
                          ),
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
                    child: Icon(Icons.edit),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )),
                        child: InkWell(
                          onTap: (){
                            map['information'] = 3;
                            Navigator.of(context).pushNamed('edit-form-screen', arguments: map);
                          },
                          child: const Row(
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: Text(
                                    'Senha',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Icon(
                                      Icons.keyboard_arrow_right_outlined)),
                            ],
                          ),
                        ),
                      ),
                    ),
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
