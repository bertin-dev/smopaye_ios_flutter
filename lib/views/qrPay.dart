import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.withOpacity(0.7), width: 5),
            ),
            child: SizedBox(child: QrImage(
              embeddedImage: AssetImage('assets/images/name_carte.jpg'),
              embeddedImageStyle: QrEmbeddedImageStyle(size: Size(60, 20)),
            data: "E-ZPASSfbbdcdbe56ZS5PQ1RF-eyJsaWNlbnNlSWQiOiI1NlpGVkIjpmYWxzZX0+-==0.8458821873637499",
            version: QrVersions.auto,
            ), width: 200,)
          ),
        ),
      ),
      
    );
  }
}