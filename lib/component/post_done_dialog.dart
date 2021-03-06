import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';

class PostDoneDialog extends StatelessWidget {
  const PostDoneDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        TextData.postDoneText,
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
