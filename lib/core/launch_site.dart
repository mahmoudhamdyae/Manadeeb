import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchSite(String url) async {
  Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}