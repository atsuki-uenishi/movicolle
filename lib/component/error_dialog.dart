import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('エラー'),
      actions: <Widget>[
        GestureDetector(
          child: Text('OK'),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
