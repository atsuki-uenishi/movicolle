import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailController {
  final String _sendAddress = 'atukin967@gmail.com';
  final String _subject = 'ムビコレ: お問い合わせ';

  sendMail(contents) async {
    final Email email = Email(
      body: contents,
      subject: _subject,
      recipients: [_sendAddress],
    );

    await FlutterEmailSender.send(email);
  }
}
