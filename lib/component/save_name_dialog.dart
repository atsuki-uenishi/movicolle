import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';

class SaveNameDialog extends StatelessWidget {
  const SaveNameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(TextData.saveNameText),
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
