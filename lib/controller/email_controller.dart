import 'package:flutter_email_sender/flutter_email_sender.dart';

const String _sendAddress = 'atukin967@gmail.com';
const String _subject = 'ムビコレ: お問い合わせ';

class EmailController {
  sendMail(contents) async {
    final Email email = Email(
      body: contents,
      subject: _subject,
      recipients: [_sendAddress],
    );

    await FlutterEmailSender.send(email);
  }
}
