import 'package:flutter/material.dart';

import '../../income_single_sections/selectors_income.dart';

class SingleSavingsScreen extends StatelessWidget {
  Map<String, dynamic> infoSavings;
  SingleSavingsScreen(this.infoSavings, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          infoSavings["title"],
          style: Theme.of(context).textTheme.displayMedium,
        ),
        toolbarHeight: 80,
        centerTitle: true,
        actions: [_offsetPopup(context)],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Text(
                      'Saldo total:',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      '\$${infoSavings["balance"]}',
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
            child: SelectorsIncome(),
          ),
          SliverToBoxAdapter(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 24.0, right: 24.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(26)),
                        child: const Text(
                          'Adicionar mais dinheiro',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 24.0, left: 24.0, right: 24.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(10),
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
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _offsetPopup(BuildContext context) => PopupMenuButton<int>(
      itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text(
                "Exluir poupança",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text(
                "Voltar",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ],
      onSelected: (value) {
        if (value == 1) {
          //TODO::: Implementar o método de apagar poupanças
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
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: 4.5,
              height: 4.5,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(4.5),
              ),
            ),
          ),
          Container(
            width: 4.5,
            height: 4.5,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(5),
            ),
          )
        ],
      )
      //child: Icon(Icons.menu, color: Colors.white), <-- You can give your icon here
      );
}
