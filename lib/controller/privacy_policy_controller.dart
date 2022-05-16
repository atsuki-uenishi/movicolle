import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyController {
  Future<void> openUrl() async {
    final Uri url = Uri.parse('https://movicolle.netlify.app/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'このURLにはアクセスできません';
    }
  }
}
