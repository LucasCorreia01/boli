import 'package:boli/models/savings.dart';
import 'package:boli/models/user.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/add_balance_savings.dart';
import 'package:boli/screens/sections/new_savings_spending_screen/savings/recover_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../income_single_sections/selectors_income.dart';

class SingleSavingsScreen extends StatefulWidget {
  Map<String, dynamic> infoSaving;
  SingleSavingsScreen(this.infoSaving, {super.key});

  @override
  State<SingleSavingsScreen> createState() => _SingleSavingsScreenState();
}

class _SingleSavingsScreenState extends State<SingleSavingsScreen> {
  @override
  Widget build(BuildContext context) {
    Savings savings = widget.infoSaving["saving"];
    User user = widget.infoSaving["user"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          savings.title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        toolbarHeight: 80,
        centerTitle: true,
        actions: [_offsetPopup(context)],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Text(
                      'Saldo total:',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      '\$${savings.balance}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Theme.of(context).primaryColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SelectorsIncome(user),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 12.0, left: 24.0, right: 24.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(PageTransition(
                    child: AddBalanceSavingsScreen(savings, user),
                    type: PageTransitionType.bottomToTop,
                    fullscreenDialog: true,
                  ))
                      .then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(26)),
                  child: Text(
                    'Adicionar mais dinheiro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 12.0, left: 24.0, right: 24.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                    child: RecoverBalanceScreen(savings, user),
                    type: PageTransitionType.bottomToTop,
                    fullscreenDialog: true,
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(26)),
                  child: const Text(
                    'Regastar dinheiro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
              child: InkWell(
                onTap: () {
                  savings.deleteSaving();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Poupança apagada com sucesso!')));
                  user.balance = user.balance + savings.balance;
                  Navigator.popAndPushNamed(context, "home-screen",
                      arguments: user);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(26)),
                  child: const Text(
                    'Exluir poupança',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _offsetPopup(BuildContext context) => PopupMenuButton<int>(
      color: Theme.of(context).primaryColorDark,
      itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text(
                "Exluir poupança",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18, ),
              ),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text(
                "Voltar",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
          ],
      onSelected: (value) {
        Savings savings = widget.infoSaving["saving"];
        User user = widget.infoSaving["user"];
        if (value == 1) {
          savings.deleteSaving();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Poupança apagada com sucesso!')));
          user.balance = user.balance + savings.balance;
          Navigator.popAndPushNamed(context, "home-screen", arguments: user);
        } else if (value == 2) {
          Navigator.pop(context);
        }
      },
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 4.5,
            height: 4.5,
            decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor,
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: 4.5,
              height: 4.5,
              decoration: BoxDecoration(
                color: Theme.of(context).indicatorColor,
                borderRadius: BorderRadius.circular(4.5),
              ),
            ),
          ),
          Container(
            width: 4.5,
            height: 4.5,
            decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor,
              borderRadius: BorderRadius.circular(5),
            ),
          )
        ],
      )
      //child: Icon(Icons.menu, color: Colors.white), <-- You can give your icon here
      );
}
