import 'dart:io';

import 'package:boli/services/user_auth_service.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: UserAuthService().getUserLoggedData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
            print(snapshot);
              if (snapshot.hasData) {
                var result = snapshot.data;
                if (result!['error'] == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    'home-screen',
                    arguments: result['user'],
                    (Route<dynamic> route) => false,
                  );
                } else {
                  return Center(
                    child: Text(
                      'Um erro inesperado aconteceu: \n${result['error']}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
              }

              return const Center(
                child: Text(
                  'Um erro inesperado aconteceu:',
                  style: const TextStyle(color: Colors.red),
                ),
              );
          }
        },
      ),
    );
  }
}
