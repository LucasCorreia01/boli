import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PaymentQrScreen extends StatelessWidget {
  const PaymentQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Pagar um QR Code',
              style: TextStyle(
                  fontSize: 30,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Row(
                  children: [
                    const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(BoxIcons.bx_qr, size: 32,),
                    ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ler QR code',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            'Use a câmera do seu celular',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        child: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(BoxIcons.bx_copy, size: 32,),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pix Copia e Cola',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            'Insira um código que você copi',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        child: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
