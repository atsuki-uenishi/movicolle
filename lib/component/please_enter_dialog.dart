import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';

class PleaseEnterDialog extends StatelessWidget {
  const PleaseEnterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        TextData.pleaseEnterContentsText,
        style: Theme.of(context).textTheme.headline3,
      ),
      actionsPadding: const EdgeInsets.all(10.0),
      actions: <Widget>[
        GestureDetector(
          child: const Text(TextData.okText),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
