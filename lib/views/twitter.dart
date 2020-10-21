import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widgets/appBar.dart';

class TwitterPage extends StatefulWidget {
  @override
  _TwitterPageState createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "E-ZPASS BY SMOPAYE"),
      body: WebView(
        initialUrl: 'https://twitter.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      
    );
  }
}