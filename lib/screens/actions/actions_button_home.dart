import 'package:boli/components/camera_page.dart';
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
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('receive_money', arguments: user)
                      .then((value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home-screen', (Route<dynamic> route) => false,
                        arguments: user);
                  });
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).cardColor),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
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
                onTap: () {
                  if (user.balance > 0.0) {
                    Navigator.of(context)
                        .pushNamed('send_money', arguments: user);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Você não tem saldo para fazer uma tranferência.'),
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).cardColor),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
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
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'extract-screen',
                      arguments: user);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).cardColor),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
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
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const CameraPage();
                      },
                      fullscreenDialog: true));
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).cardColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
