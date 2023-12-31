import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ReceiverSection extends StatelessWidget {
  final String userReceiver;
  const ReceiverSection(this.userReceiver, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String> name = userReceiver.trim().split(" ");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 2))),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Icon(BoxIcons.bx_arrow_from_top),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Destino',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Nome',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${name.first} ${name.last}",
                        style: const TextStyle(
                            fontSize: 18, overflow: TextOverflow.visible,),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Instituição',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Boli - Banco digital S.A.',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tipo de conta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Conta corrente',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
