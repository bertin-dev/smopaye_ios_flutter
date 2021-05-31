import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QRPay extends StatefulWidget {
  @override
  _QRPayState createState() => _QRPayState();
}



class _QRPayState extends State<QRPay> {
  String cardNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("------------------ $cardNumber");
    readCardNumber();
  }

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
            data: "E-ZPASS${cardNumber}56ZS5PQ1RF-eyJsaWNlbnNlSWQiOiI1NlpGVkIjpmYWxzZX0+-==0.8458821873637499",
            version: QrVersions.auto,
            ), width: 200,)
          ),
        ),
      ),
      
    );
  }

  readCardNumber() async{
    final getUserCard = await SharedPreferences.getInstance();
      setState(() {
        cardNumber = getUserCard.get("key_myCompteUser");
        print("------------------ $cardNumber");
      });
  }
}