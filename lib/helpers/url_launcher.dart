import 'package:url_launcher/url_launcher.dart';

Future<void> urlLuncher(String? urlPath) async {
  final Uri url = Uri.parse(urlPath!);
  try {
    if (!await launchUrl(url,
        mode: LaunchMode.platformDefault,
        browserConfiguration: const BrowserConfiguration(showTitle: true),
        webViewConfiguration:
            const WebViewConfiguration(enableJavaScript: true))) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    print(e);
  }
}
