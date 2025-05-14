import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<void> launchPhone(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch phone dialer for $number';
    }
  }

  static Future<void> launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch email for $email';
    }
  }

  static Future<void> launchWhatsApp(String number) async {
    final Uri uri = Uri.parse("https://wa.me/$number");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch WhatsApp for $number';
    }
  }
}
