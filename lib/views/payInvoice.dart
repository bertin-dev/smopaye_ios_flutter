import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/errorBody.dart';
import 'package:smopaye_mobile/models/homeResponse.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/alertDialogs/defaultDialog.dart';

import 'widgets/appBar.dart';
import 'widgets/form/button.dart';
import 'widgets/form/textField.dart';
import 'widgets/instructionCard.dart';

class PayInvoice extends StatefulWidget {
  @override
  _PayInvoiceState createState() => _PayInvoiceState();
}

class _PayInvoiceState extends State<PayInvoice> {
  
  final _transferFormKey = GlobalKey<FormState>();
  //Receiver
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();

  bool _buttonState = true;
  bool _autovalidate = false;

  //Sender
  final String _typeTransaction = "PAYEMENT_FACTURE";

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    return Scaffold(
      appBar: DefaultAppBar(title: "Payer votre facture",),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          SizedBox(height: hv*3,),
          InstructionCard(text: "Insérez le numero de carte du bénéficiaire et le montant à payer puis valider",),
          SizedBox(height: hv*10,),

          Form(
            key: _transferFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  hintText: 'Numéro de carte',
                  controller: _accountNumberController,
                  emptyValidatorText: 'Entrez un Numéro de Carte',
                  keyboardType: TextInputType.text,
                  validator: (str) => str.isEmpty ? 'Veuillez entrer un Numéro de Carte' : null,
                  labelColor: Color(0xff039BE5)
                ),

                SizedBox(height: hv*3,),

                CustomTextField(
                  hintText: 'Montant à payer',
                  controller: _amountController,
                  emptyValidatorText: 'Entrer un Montant',
                  keyboardType: TextInputType.number,
                  validator: _amountFieldValidator,
                  labelColor: Color(0xff039BE5)
                ),

                SizedBox(height: hv*7,),

          _buttonState ? 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomButton(
                    color: Color(0xff039BE5), text: 'Effectuer', textColor: Colors.white,
                    onPressed: () async {_payerFacture(context);},
                  ),
                )
                : CircularProgressIndicator(),
            ],)
         )

          // Champ de texte du numéro de compte du bénéficiaire

          

        ],),
      ),
      
    );
  }


 // Fonction de paiement des factures

  _payerFacture (BuildContext context) async {
    final getCodeNumberSender = await SharedPreferences.getInstance();
    print("accountNberReceiver: ${_accountNumberController.text}\namount: ${_amountController.text}\n _codeNumberSender: ${getCodeNumberSender.get("key_myCompteUser")}\n");
      setState(() {
       _autovalidate = true; 
      });

      if (_transferFormKey.currentState.validate()) {
        setState(() {
        _buttonState = false;
        });

        //connexion au web service
        dynamic response = await AuthService.transaction(
            amount: double.parse(_amountController.text),
            code_number_sender: getCodeNumberSender.get("key_myCompteUser"),
            code_number_receiver: _accountNumberController.text,
            transaction_type: _typeTransaction);

        Map<String, dynamic> body = jsonDecode(response.body);

        if(response.statusCode == 200) {
          setState(() {
            _buttonState = true;
          });
          HomeResponse homeResponse = HomeResponse.fromJson(body);
          String idReceiver = homeResponse.message.card_receiver.code_number;
          String msgReceiver = homeResponse.message.card_receiver.notif;
          String idSender = homeResponse.message.card_sender.code_number;
          String msgSender = homeResponse.message.card_sender.notif;
          _successResponse(idReceiver, msgReceiver, idSender, msgSender);
        } else{
          setState(() {
            _buttonState = true;
          });
          ErrorBody errorBody = ErrorBody.fromJson(body);
          _errorResponse(errorBody.message);
        }


       /* if (response.statusCode == 200) {

          //Navigator.pop(context);
          response = json.decode(response.body);
          _success_showDialog(response["message"]);
        }
        else if(response.statusCode == 500){
          response = json.decode(response.body);
          print(response);
          _error_showDialog(response["exception"]+ " " + response["message"]);

        }
        else if(response.statusCode == 404){
          response = json.decode(response.body);
          print(response);
          _error_showDialog(response["exception"]+ " " + response["message"]);
        }
        else{
          response = json.decode(response.body);
          print(response["data"]["error"]);
          _error_showDialog(response["data"]["error"]);
        }*/


        }
      }


  String _amountFieldValidator (String value) {
    if (value.isEmpty) {
      return "Veuillez entrer un montant";
    }
    String p = "^(([1-9]*)|(([1-9]*)\.([0-9]*)))\$" ;
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      // So, the amount is valid
      return null;
    }
    // The pattern of the amount didn't match the regex above.
    return 'Montant entré invalid';
  }


  //boite de dialog pour les erreurs
  void _error_showDialog(String response) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Information", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),), color: Colors.blue,
            ),
            content: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Icon(Icons.cancel, color: Colors.red, size: 45,),
                  SizedBox(width: 10),
                  Expanded(child: Text(response))
                ],),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK", style: TextStyle(color: Colors.red),),
                onPressed: () {
                  Navigator.of(context).pop();

                  setState(() {
                    _buttonState = false;
                  });

                  setState(() {
                    _autovalidate = true;
                  });

                },
              ),
            ],
          );
        }
    );
  }

  //boite de dialog pour les erreurs
  void _success_showDialog(String response) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Information", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),), color: Colors.blue,
            ),
            content: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.check_circle, color: Colors.green, size: 45,),
                  SizedBox(width: 10),
                  Expanded(child: Text(response))
                ],),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK", style: TextStyle(color: Colors.red),),
                onPressed: () {
                  Navigator.of(context).pop();

                  setState(() {
                    _buttonState = false;
                  });

                  setState(() {
                    _autovalidate = true;
                  });

                },
              ),
            ],
          );
        }
    );
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

  _errorResponse (String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
          DefaultAlertDialog(
            title: "Information",
            message: "$message",
            icon: Icon(Icons.cancel, color: Colors.red, size: 45,),
          );

      },
    );
  }

  }
