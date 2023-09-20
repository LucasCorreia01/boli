import 'package:boli/components/list_item.dart';
import 'package:boli/models/savings.dart';
import 'package:flutter/material.dart';
import '../../../models/user.dart';

class SavingSection extends StatelessWidget {
  final User user;
  const SavingSection(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Savings.getSavingsHome(user.fullname),
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
                              onTap: (){
                                Map<String, dynamic> infoSavings = {};
                                infoSavings["title"] = savings[index].title;
                                infoSavings["description"] = savings[index].description;
                                infoSavings["icon"] = savings[index].icon;
                                infoSavings["fullName"] = savings[index].fullName;
                                infoSavings["date"] = savings[index].date;
                                infoSavings["balance"] = savings[index].balance;
                                Navigator.of(context).pushNamed('single_savings_screen', arguments: infoSavings);
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

                return Padding(
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
                                  color: Theme.of(context).primaryColorDark,
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
                              Text(
                                'Nenhuma poupança cadastrada',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium,
                              ),
                              Text(
                                'Desja criar uma nova?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
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
        });

    return Container();
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             'Poupanças',
    //             style: Theme.of(context).textTheme.titleMedium,
    //           ),
    //           TextButton(
    //             onPressed: () {},
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Text(
    //                   'Ver mais',
    //                   style: Theme.of(context).textTheme.headlineMedium,
    //                 ),
    //                 Icon(
    //                   Icons.keyboard_arrow_right_outlined,
    //                   color: Theme.of(context).primaryColorDark,
    //                 )
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //       ListItem(
    //         title: 'Viagens',
    //         subtitle: 'Viagem para Cartagena, Colombia.',
    //         icon: Icon(
    //           Icons.airplanemode_active_outlined,
    //           color: Theme.of(context).primaryColorDark,
    //           size: 20,
    //         ),
    //       ),
    //       ListItem(
    //         title: 'Festa de aniversário!',
    //         subtitle: 'Dinheiro para a festa surpresa.',
    //         icon: Icon(
    //           Icons.cake_sharp,
    //           color: Theme.of(context).primaryColorDark,
    //           size: 20,
    //         ),
    //       ),
    //       ListItem(
    //         title: 'Para emergências',
    //         subtitle: 'Usar só quando necessário.',
    //         icon: Icon(
    //           Icons.report_gmailerrorred_outlined,
    //           color: Theme.of(context).primaryColorDark,
    //           size: 20,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
