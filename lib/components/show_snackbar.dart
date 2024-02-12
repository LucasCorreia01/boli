import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String content,
    bool isErro = false}) {
      
  SnackBar snackBar = SnackBar(
    content: Text(content),
    backgroundColor: (isErro) ? Colors.red : Colors.green,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
