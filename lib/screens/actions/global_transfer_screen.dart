import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GlobalTransferScreen extends StatefulWidget {
  const GlobalTransferScreen({super.key});

  @override
  State<GlobalTransferScreen> createState() => _GlobalTransferScreenState();
}

class _GlobalTransferScreenState extends State<GlobalTransferScreen> {
  late TextEditingController controllerDolar;
  late TextEditingController controllerReal;
  String valueDolar = "";
  String valueReal = "";

  @override
  void initState() {
    controllerDolar = TextEditingController();
    controllerReal = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerDolar.dispose();
    controllerReal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 14,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Transferência Internacional',
                      style: TextStyle(
                          fontSize: 30,
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Text(
                      'Envie e receba dinheiro do exterior com rapidez e taxas mais baratas.',
                      style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(2, 15, 22, 12),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:
                                    Image.asset('assets/images/bandeira.jpg')),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Você envia',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () async{
                                  String? value = await openDialogReal();
                                  if(value == null || value.isEmpty) return;
                                  value = "USD $value,00";
                                  setState(() => valueReal = value!);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      (valueReal == "") ? 'R\$ 15000,00' : valueDolar,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Icon(
                                        BoxIcons.bx_edit_alt,
                                        weight: 2,
                                        size: 28,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(2, 12, 22, 15),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:
                                    Image.asset('assets/images/bandeira2.jpg')),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Convertemos para',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () async{
                                  String? value = await openDialogDolar();
                                  if(value == null || value.isEmpty) return;
                                  value = "USD $value,00";
                                  setState(() => valueDolar = value!);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      (valueReal == "") ? 'USD 2872,06' : valueDolar,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Icon(
                                        BoxIcons.bx_edit_alt,
                                        weight: 2,
                                        size: 28,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Os valores são aproximados',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'A simulação é feita em tempo real e inclui taxas mas o câmbio final só é fechado ao completar a transferência.',
                          style: TextStyle(
                              overflow: TextOverflow.visible, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: 0.2))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Câmbio comercial',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          FutureBuilder(
                            future: getDollarQuote(),
                            builder: ((context, snapshot) {
                              String? dollarQuote = snapshot.data;
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator());

                                case ConnectionState.waiting:
                                  return const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator());

                                case ConnectionState.active:
                                  return const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator());

                                case ConnectionState.done:
                                  if (snapshot.data != null &&
                                      snapshot.data != "") {
                                    dollarQuote =
                                        dollarQuote!.replaceAll('.', ',');
                                    return Text(
                                      'R\$ $dollarQuote',
                                      style: const TextStyle(fontSize: 18),
                                    );
                                  }
                              }
                              return const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator());
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: 0.2))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'IOF',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('0,38%', style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: 0.2))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tarifa externa',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('R\$ 0,00', style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: 0.2))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cotação final (VET)',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          FutureBuilder(
                            future: getDollarQuote(),
                            builder: ((context, snapshot) {
                              String? dollarQuote = snapshot.data;
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator());

                                case ConnectionState.waiting:
                                  return const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator());

                                case ConnectionState.active:
                                  return const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator());

                                case ConnectionState.done:
                                  if (snapshot.data != null &&
                                      snapshot.data != "") {
                                    dollarQuote =
                                        dollarQuote!.replaceAll('.', ',');
                                    return Text(
                                      'R\$ $dollarQuote',
                                      style: const TextStyle(fontSize: 18),
                                    );
                                  }
                              }
                              return const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator());
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, //New
                      blurRadius: 25.0,
                      offset: Offset(0, 23))
                ],
              ),
              child: Container(
                color: const Color.fromRGBO(252, 255, 253, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 14.0, left: 24.0, right: 24.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(26)),
                            child: const Text(
                              'Continuar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Ao continuar, você declara ter lido e concordado com os Termos e Condições',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            overflow: TextOverflow.visible,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> getDollarQuote() async {
    var url = "https://economia.awesomeapi.com.br/json/last/USD-BRL";
    var dolarQuote = '';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      dolarQuote = jsonResponse['USDBRL']['low'];
    }

    return dolarQuote;
  }

  Future<String?> openDialogDolar() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Editar valor'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'R\$'),
            controller: controllerDolar,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(controllerDolar.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
                  return Theme.of(context).primaryColorDark;
                }),
                textStyle: MaterialStateProperty.resolveWith((states) {

                  return const TextStyle(color: Colors.white);
                }),
              ),
              child: const Text('Confirmar', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      );

      Future<String?> openDialogReal() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Editar valor'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'R\$'),
            controller: controllerReal,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(controllerReal.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
                  return Theme.of(context).primaryColorDark;
                }),
                textStyle: MaterialStateProperty.resolveWith((states) {

                  return const TextStyle(color: Colors.white);
                }),
              ),
              child: const Text('Confirmar', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      );
}
