import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/user.dart';

class ActionsButtonsHome extends StatelessWidget {
  final User user;
  const ActionsButtonsHome({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('receive_money', arguments: user);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(BoxIcons.bx_arrow_from_top, size: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Receber',
                        style: TextStyle(
                            fontSize: 14, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('send_money', arguments: user);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(BoxIcons.bx_arrow_from_bottom, size: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Enviar',
                        style: TextStyle(
                            fontSize: 14, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(BoxIcons.bx_list_ul, size: 20),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Extrato',
                      style: TextStyle(
                          fontSize: 14, overflow: TextOverflow.ellipsis),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(BoxIcons.bx_qr_scan, size: 20),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Escanear',
                      style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
