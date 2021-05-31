import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/errorBody.dart';
import 'package:smopaye_mobile/models/homeResponse.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/form/button.dart';
import 'package:toast/toast.dart';
import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/form/textField.dart';
import 'package:smopaye_mobile/models/responsePaiementQRCodeReceiver.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  String result = "";
  QRViewController controller;
  var nomComplet = "";
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
    controller.scannedDataStream.listen((scanData) async {
      print(scanData);
      setState(() {
        qrText = scanData;
      });
      if (scanData != ""){

        if(scanData.contains("E-ZPASS") != null){
          //_checkCodeQRUser("BDAADA51");
          setState(() {
            result = scanData.substring(7, 15).toUpperCase();
          });
          nomComplet = await _checkCodeQRUser(result);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return   AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  titlePadding: EdgeInsets.all(0),
                  title: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Text(
                      "Paiement Par Code QR", textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),),
                    color: Colors.blue,
                  ),
                  content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(width: 500,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ListView(shrinkWrap: true,
                              children: <Widget>[
                                Form(
                                  key: _amountFormKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                'Vous êtes sur le point de débiter votre compte et créditer le compte de $nomComplet.\nEntrez le montant.',
                                                style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: CustomTextField(
                                            hintText: 'Montant à payer',
                                            controller: _amountController,
                                            emptyValidatorText: 'Enter amount',
                                            keyboardType: TextInputType.number,
                                            validator: _amountFieldValidator,
                                            labelColor: Color(0xff039BE5),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60.0, right: 60.0),
                                        child: CustomButton(
                                          color: Color(0xff039BE5),
                                          text: 'VALIDER',
                                          textColor: Colors.white,
                                          onPressed: () async {
                                            if (_amountFormKey.currentState.validate()) {
                                              Navigator.of(context).pop();
                                              paiementQrCodeInServerSmopaye(context);
                                            }
                                          },
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
          dispose();
        }

      }
    });
  }

  // Fonction de transfert carte
  paiementQrCodeInServerSmopaye (BuildContext context1) async {


    final getCardSender = await SharedPreferences.getInstance();

      dynamic response = await AuthService.transaction(
          amount: double.parse(_amountController.text),
          code_number_sender: getCardSender.get("key_myCompteUser"),
          code_number_receiver: result,
          transaction_type: "PAYEMENT_VIA_QRCODE");

      Map<String, dynamic> body = jsonDecode(response.body);
    print("code_number_sender: ${getCardSender.get("key_myCompteUser")}\namount: ${_amountController.text}\n code_number_receiver: ${result}\n status: ${response.statusCode}\n");

    if(response.statusCode == 200) {
        HomeResponse homeResponse = HomeResponse.fromJson(body);
        String idCardReceiver = homeResponse.message.card_receiver.code_number;
        String msgReceiver = homeResponse.message.card_receiver.notif;
        String idCardSender = homeResponse.message.card_sender.code_number;
        String msgSender = homeResponse.message.card_sender.notif;
        //_successResponse(idCardReceiver, msgReceiver, idCardSender, msgSender);
        Toast.show(msgSender, context, duration: Toast.LENGTH_SHORT , gravity:  Toast.BOTTOM, backgroundColor: Colors.green, textColor: Colors.white);
      } else{
        ErrorBody errorBody = ErrorBody.fromJson(body);
        print(errorBody.message);
        Toast.show(errorBody.message, context, duration: Toast.LENGTH_SHORT , gravity:  Toast.BOTTOM, backgroundColor: Colors.red, textColor: Colors.white);
      }


  }


  _successResponse (String id_cardReceiver, String msgReceiver, String id_cardSender, String msgSender) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
          DefaultAlertDialog(
            title: "Information",
            message: "$msgSender",
            icon: Icon(Icons.check_circle, color: Colors.green, size: 45,),
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

   Future<dynamic> _checkCodeQRUser(String result) async {
    dynamic response = await AuthService.profil_userQRCode(card_number: result);
   ResponsePaiementQRCodeReceiver responsePaiementQRCodeReceiver;

    Map<String, dynamic> body = jsonDecode(response.body);
    print(body);
    print(response.statusCode );
    if(response.statusCode == 200) {
      responsePaiementQRCodeReceiver = ResponsePaiementQRCodeReceiver.fromJson(body);
    }
    return "${responsePaiementQRCodeReceiver.data[0].user.particulier[0].lastname} ${responsePaiementQRCodeReceiver.data[0].user.particulier[0].firstname}";
  }


}
