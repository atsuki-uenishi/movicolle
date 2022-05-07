import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        TextData.errorText,
        style: Theme.of(context).textTheme.headline3,
      ),
      actionsPadding: EdgeInsets.all(10.0),
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
