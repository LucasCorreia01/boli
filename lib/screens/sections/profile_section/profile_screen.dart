import 'package:flutter/material.dart';
import '../../../components/showDialogConfirmation.dart';
import '../../../models/user.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({required this.user, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.fullname,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          child: Text(
                            'ID: ${widget.user.id}',
                            style: const TextStyle(
                                fontSize: 15, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Text(
                          DateFormat("'Visto em:' dd/MM/yyyy 'às' HH:mm")
                              .format(widget.user.lastSeen),
                          style: const TextStyle(fontSize: 15),
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
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed('general-settings'),
                        child: const Row(
                          children: [
                            Expanded(
                                flex: 9,
                                child: Text(
                                  'Geral',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 2,
                                child:
                                    Icon(Icons.keyboard_arrow_right_outlined)),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              'choose-edit-informations',
                              arguments: widget.user);
                        },
                        child: const Row(
                          children: [
                            Expanded(
                                flex: 9,
                                child: Text(
                                  'Cadastro',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 2,
                                child:
                                    Icon(Icons.keyboard_arrow_right_outlined)),
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
            decoration:
                const BoxDecoration(color: Color.fromRGBO(241, 242, 244, 1)),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 10, 20),
              child: Text(
                'AVANÇADO',
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
                  child: Icon(Icons.delete),
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
                      child: InkWell(
                        onTap: () {
                          showConfirmationDialog(
                                  context: context,
                                  title: 'Apagar conta',
                                  content:
                                      'Tem certeza que deseja apagar sua conta?\n\nEssa ação não pode ser desfeita.')
                              .then((value) {
                            if (value) {
                              User.deleteUser(widget.user.fullname)
                                  .then((value) {
                                Navigator. pushNamedAndRemoveUntil(
                                    context, 'login-screen', (Route<dynamic> route) => false);
                              });
                            }
                          });
                        },
                        child: const Row(
                          children: [
                            Expanded(
                                flex: 9,
                                child: Text(
                                  'Apagar conta atual',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 2,
                                child:
                                    Icon(Icons.keyboard_arrow_right_outlined)),
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
                  child: Icon(Icons.person_2_outlined,),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'all-users-screen');
                        },
                        child: const Row(
                          children: [
                            Expanded(
                                flex: 9,
                                child: Text(
                                  'Ver todas as contas',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 2,
                                child:
                                    Icon(Icons.keyboard_arrow_right_outlined)),
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
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('VERSÃO', style: TextStyle(fontSize: 14,)),
                Text('1.0.0', style: TextStyle(fontSize: 14),)
              ],
            ),
          ),
        )
      ],
    );
  }
}
