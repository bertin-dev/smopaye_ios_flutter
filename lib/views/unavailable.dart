import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';

class ServiceUnavailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Service Unavailable",),
      body: Center(
        child: Text("Service Unavailable", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))
      ),
    );
  }
}