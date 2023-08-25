import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherHeaderSection extends StatelessWidget {
  final String valueToTransfer;
  const VoucherHeaderSection(this.valueToTransfer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              width: 70,
              child: Image.asset('assets/images/logo-boli.png'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Comprovante de transferência',
              style: TextStyle(
                  fontSize: 30,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.bold,
                  height: 1.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              DateFormat("dd/MM/yyyy 'às' HH:mm").format(DateTime.now()),
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Valor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  valueToTransfer,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tipo de transferência',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'TED',
                style: TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}
