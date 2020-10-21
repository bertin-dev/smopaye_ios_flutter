import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/form/textField.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;

  final _amountFormKey = GlobalKey<FormState>();
  TextEditingController _amountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: QRView(
                  key: qrKey,
                  overlay: QrScannerOverlayShape(
                    cutOutSize: 250,
                  ),
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan result: $qrText'),
                ),
              )
            ],
          ),
          
        ],
      ),
    );
  }
   void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData);
      setState(() {
        qrText = scanData;
      });
      if (scanData != ""){
        
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(top: 15, left: 20),
              title: Text("Insérer Montant"),
              content: Form(
                key: _amountFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        hintText: 'Montant à payer',
                        controller: _amountController,
                        emptyValidatorText: 'Enter amount',
                        keyboardType: TextInputType.number,
                        validator: _amountFieldValidator,
                        labelColor: Color(0xff039BE5)
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("CANCEL", style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("CONFIRM", style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    if (_amountFormKey.currentState.validate()) {
                      //Navigator.of(context).pop();
                            _check();
                    }
                  },
                ),
              ],
            );
          });
          dispose();
      }
    });
  }

    _check () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return 
          DefaultAlertDialog(
            title: "Information",
            message: "Le Solde de votre compte $qrText est insuffisant",
            icon: Icon(Icons.cancel, color: Colors.red, size: 45,),
          );
          
        },
      );
  }

    String _amountFieldValidator (String value) {
    if (value.isEmpty) {
    return "Entrez votre mot de passe";
    }
     String p = "^(([1-9]*)|(([1-9]*)\.([0-9]*)))\$" ;
     RegExp regExp = new RegExp(p);
      if (regExp.hasMatch(value)) {
        // So, the amount is valid
        return null;
      }
      // The pattern of the amount didn't match the regex above.
      return 'Enter a valid amount';
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
