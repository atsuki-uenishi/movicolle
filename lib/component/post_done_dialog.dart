import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';

class PostDoneDialog extends StatelessWidget {
  const PostDoneDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(TextData.postDoneText),
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
