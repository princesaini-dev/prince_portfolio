import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtills {
  static Future<void> loadUrl(String url) async {
    debugPrint('URL launched ::: $url');
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('URL launched error...');
    }
  }
}
