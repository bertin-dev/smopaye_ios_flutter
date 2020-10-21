import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widgets/appBar.dart';

class FacebookPage extends StatefulWidget {
  @override
  _FacebookPageState createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "E-ZPASS BY SMOPAYE"),
      body: WebView(
        initialUrl: 'https://facebook.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      
    );
  }
}