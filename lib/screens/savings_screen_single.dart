import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SavingScreenSingle extends StatefulWidget {
  const SavingScreenSingle({super.key});

  @override
  State<SavingScreenSingle> createState() => _SavingScreenSingleState();
}

class _SavingScreenSingleState extends State<SavingScreenSingle> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Valor da Carteira',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const Text(
              'R\$200,00',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
              ),
            ),
            loadGraphic(context)
          ],
        ),
      ),
    );
  }

  loadGraphic(context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 5,
              centerSpaceRadius: 110,
              // sections: loadWallet(),
              // pieTouchData: PieTouchData(
              //   touchCallback: (touch) => setState(() {
              //     index = touch.touc
              //   });
              // )
            ),
          ),
        ),
      ],
    );

    // Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 200,
    //   child: Center(child: CircularProgressIndicator(),),
    // );
  }


  loadWallet(){}
}
