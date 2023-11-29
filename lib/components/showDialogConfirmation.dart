import 'package:flutter/material.dart';

showConfirmationDialog({
  String title = 'Atenção',
  String content = 'Tem certeza que deseja confirmar sua escolha?',
  String affirmationChoice = 'Confirmar',
  String negattiveChoice = 'Cancelar',
  bool twoOptions = true,
  required BuildContext context,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.warning,
                color: Color.fromRGBO(255, 0, 0, 1),
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20, color: Theme.of(context).indicatorColor),
            ),
          ],
        ),
        content: Text(
          content,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              color: Theme.of(context).indicatorColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              affirmationChoice,
              style: TextStyle(color: Theme.of(context).indicatorColor),
            ),
          ),
          (twoOptions) ? TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              negattiveChoice,
              style: TextStyle(color: Theme.of(context).indicatorColor),
            ),
          ) : Container(),
        ],
      );
    },
  );
}
