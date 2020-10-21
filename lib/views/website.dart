import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Website extends StatefulWidget {
  @override
  _WebsiteState createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "SMOPAYE Website"),
      body: WebView(
        initialUrl: 'https://www.smopaye.cm/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      
    );
  }
}