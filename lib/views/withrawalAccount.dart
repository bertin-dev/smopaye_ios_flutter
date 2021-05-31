import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/errorBody.dart';
import 'package:smopaye_mobile/services/authService.dart';

import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/appBar.dart';
import 'widgets/form/button.dart';
import 'widgets/form/textField.dart';
import 'widgets/instructionCard.dart';
import 'package:smopaye_mobile/models/homeRetraitAccount.dart';

class WithrawalAccount extends StatefulWidget {
  @override
  _WithrawalAccountState createState() => _WithrawalAccountState();
}

class _WithrawalAccountState extends State<WithrawalAccount> {
  
  final _withrawOperatorFormKey = GlobalKey<FormState>();
  final _amountFormKey = GlobalKey<FormState>();
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();

  bool _buttonState = true;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          SizedBox(height: hv*3,),
          InstructionCard(text: "Veuillez insérez votre numéro de compte puis suivre les étapes",),
          SizedBox(height: hv*10,),

          Form(
            key: _withrawOperatorFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  maxLength: 9,
                  hintText: 'Numéro de compte',
                  controller: _accountNumberController,
                  emptyValidatorText: 'Entre votre numéro de compte',
                  keyboardType: TextInputType.text,
                  validator: (str) => str.isEmpty ? 'Veuillez inserer votre numéro de compte' : null,
                  labelColor: Color(0xff039BE5)
                ),

                SizedBox(height: hv*3,),

                

                SizedBox(height: hv*7,),

          _buttonState ? 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomButton(
                    color: Color(0xff039BE5), text: 'Effectuer', textColor: Colors.white,
                    onPressed: () async {_withraw(context);},
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

 // Fonction de retrait smopaye
 
  _withraw (BuildContext context) async {

    print("accountnber: ${_accountNumberController.text}\namount: ${_amountController.text}\n");
      setState(() {
       _autovalidate = true; 
      });

      if (_withrawOperatorFormKey.currentState.validate()) {
        setState(() {
        _buttonState = false;
        });
        
      Timer(Duration(seconds: 1),
      (){
        setState(() {
         _buttonState = true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(top: 15, left: 20),
              content: Form(
                key: _amountFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        hintText: 'Montant',
                        controller: _amountController,
                        emptyValidatorText: 'Entrer le montant',
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
                  child: Text("ANNULER", style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("OK", style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    if (_amountFormKey.currentState.validate()) {
                      Navigator.of(context).pop();
                      RetraitAccepteurInSmopayeServer();
                    }
                  },
                ),
              ],
            );
          });
        }
      );
      setState(() {
         _buttonState = false;
        });

      setState(() {
       _autovalidate = true; 
      });
      }
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

  //Retrait (Compte à Compte) chez operateur
  RetraitAccepteurInSmopayeServer () async {
    final getPhoneNumber = await SharedPreferences.getInstance();
    print("accountnber: ${_accountNumberController.text}\namount: ${_amountController.text}\n");

      dynamic response = await AuthService.retraitCompteOperator(
          account_number: _accountNumberController.text,
          withDrawalAmount: double.parse(_amountController.text),
          phoneNumber: getPhoneNumber.get("key_myPhoneUser"));

      Map<String, dynamic> body = jsonDecode(response.body);

      if(response.statusCode == 200) {
        HomeRetraitAccount homeRetraitAccount = HomeRetraitAccount.fromJson(body);
        String msg = homeRetraitAccount.message.sender.notif;
        _successResponse("", msg);
      } else{

        ErrorBody errorBody = ErrorBody.fromJson(body);
        _errorResponse(errorBody.message);
      }
  }


  _successResponse (String id_card, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
          DefaultAlertDialog(
            title: "Information",
            message: "$msg",
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