import 'package:flutter/material.dart';
import 'package:movicolle/text_data.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(TextData.errorText),
      actions: <Widget>[
        GestureDetector(
          child: Text(TextData.okText),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
