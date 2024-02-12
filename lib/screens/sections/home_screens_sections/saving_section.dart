import 'package:boli/components/list_item.dart';
import 'package:boli/components/show_snackbar.dart';
import 'package:boli/models/savings.dart';
import 'package:flutter/material.dart';
import '../../../models/user.dart';

class SavingSection extends StatelessWidget {
  final User user;
  const SavingSection(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Poupanças',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () {
                if (user.balance > 0) {
                  Navigator.pushNamed(context, 'new-savings', arguments: user);
                } else {
                  showSnackBar(
                    context: context,
                    content:
                        'Você não tem saldo suficiente para criar uma poupança!',
                    isErro: true,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Criar nova',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Theme.of(context).primaryColorDark,
                  )
                ],
              ),
            )
          ],
        ),
        FutureBuilder(
            future: Savings.getSavingsHome(user.fullName),
            builder: (context, snapshot) {
              List<Savings>? savings = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: CircularProgressIndicator(),
                        ),
                        Text(
                          'Carregando...',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  );

                case ConnectionState.waiting:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: CircularProgressIndicator(),
                        ),
                        Text(
                          'Carregando...',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  );

                case ConnectionState.active:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: CircularProgressIndicator(),
                        ),
                        Text(
                          'Carregando...',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  );

                case ConnectionState.done:
                  if (snapshot.hasData && savings != null) {
                    if (savings.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: double.parse("${95 * savings.length}"),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: savings.length,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  onTap: () {
                                    Map<String, dynamic> infoSaving = {};
                                    infoSaving["saving"] = savings[index];
                                    infoSaving["user"] = user;
                                    Navigator.of(context)
                                        .pushNamed('single_savings_screen',
                                            arguments: infoSaving)
                                        .then((value) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          'login-screen',
                                          (Route<dynamic> route) => false);
                                    });
                                  },
                                  child: ListItem(
                                      title: savings[index].title,
                                      subtitle: savings[index].description,
                                      icon: savings[index].icon),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return InkWell(
                      onTap: () {
                        if (user.balance > 0) {
                          Navigator.pushNamed(context, 'new-savings',
                              arguments: user);
                        } else {
                          showSnackBar(
                            context: context,
                            content:
                                'Você não tem saldo suficiente para criar uma poupança!',
                            isErro: true,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).indicatorColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.warning),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nenhuma poupança cadastrada',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .indicatorColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible)),
                                    Text(
                                      'Desja criar uma nova?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.warning,
                            color: Color.fromRGBO(255, 0, 0, 1),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Error ao carregar as contas salvas. Tente novamente mais tarde.',
                            style: TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }),
      ],
    );
  }
}
