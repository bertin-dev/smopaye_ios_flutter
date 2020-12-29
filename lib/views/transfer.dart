import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smopaye_mobile/models/allMyHomeResponse.dart';
import 'package:smopaye_mobile/models/errorBody.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/alertDialogs/defaultDialog.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';
import 'package:smopaye_mobile/views/widgets/form/dropdownField.dart';
import 'package:smopaye_mobile/views/widgets/instructionCard.dart';

import 'widgets/form/button.dart';
import 'widgets/form/textField.dart';

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  
  final _transferFormKey = GlobalKey<FormState>();
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  TextEditingController _cardNumberController = new TextEditingController();

  bool _buttonState = true;
  bool _autovalidate = false;
  String _operation = "TRANSFERT_CARTE_A_CARTE";

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          SizedBox(height: hv*3,),
          InstructionCard(text: "Insérez le numero de compte du bénéficiaire et le montant à transférer puis validez",),
          SizedBox(height: hv*10,),

          Form(
            key: _transferFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[

                CustomDropDownField(
                  label: "Type de Transfert",
                  onChangedFunc: (String value) {
                    setState(() {
                      _operation = value;
                    });
                  }, hintText: "Transfert",
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Carte à Carte', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                      value: 'TRANSFERT_CARTE_A_CARTE',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Compte à Compte', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                      value: 'TRANSFERT_COMPTE_A_COMPTE',
                    )
                  ],
                  value: _operation,
                ),

                SizedBox(height: hv*1,),

                (_operation == "TRANSFERT_CARTE_A_CARTE") ?
                CustomTextField(
                  maxLength: 8,
                  hintText: 'N° de carte bénéficiaire',
                  controller: _cardNumberController,
                  emptyValidatorText: 'Entrer numéro de carte',
                  keyboardType: TextInputType.text,
                  validator: _cardNumberFieldValidator,
                  labelColor: Color(0xff039BE5)
                )
                    :
                CustomTextField(
                    maxLength: 9,
                    hintText: 'N° de compte bénéficiaire',
                    controller: _accountNumberController,
                    emptyValidatorText: 'Entrer numéro de compte',
                    keyboardType: TextInputType.number,
                    validator: _accountFieldValidator,
                    labelColor: Color(0xff039BE5)
                ),


                CustomTextField(
                  maxLength: 7,
                  hintText: 'Montant',
                  controller: _amountController,
                  emptyValidatorText: 'Entrer le montant',
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
                    onPressed: () async {
                      if(_operation == "TRANSFERT_CARTE_A_CARTE"){
                        _transferCard(context);
                      } else{
                        _transferAccount(context);
                      }
                      },
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

 // Fonction de transfert carte
  _transferCard (BuildContext context) async {

    print("cardNumber: ${_cardNumberController.text}\namount: ${_amountController.text}\ntype_transfert: ${_operation}");
      setState(() {
       _autovalidate = true;
      });

      if (_transferFormKey.currentState.validate()) {

        //transfertCompteACompteInSmopayeServer(double.parse(_amountController.text), _accountNumberController.text, "", _operation);

        setState(() {
        _buttonState = false;
        });
        
      Timer(Duration(seconds: 3),
      (){
        setState(() {
         _buttonState = true;
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

  // Fonction de transfert compte
  _transferAccount (BuildContext context) async {

    print("accountnber: ${_accountNumberController.text}\namount: ${_amountController.text}\ntype_transfert: ${_operation}");
    setState(() {
      _autovalidate = true;
    });

    if (_transferFormKey.currentState.validate()) {

      setState(() {
        _buttonState = false;
      });

      /*Timer(Duration(seconds: 3),
              (){
            setState(() {
              _buttonState = true;
            });
          }
      );
      setState(() {
        _buttonState = false;
      });*/

      dynamic response = await AuthService.transaction_compte_A_Compte(
          amount: double.parse(_amountController.text),
          account_number_receiver: _accountNumberController.text,
          account_number_sender: "355192758",
          transaction_type: _operation);

      Map<String, dynamic> body = jsonDecode(response.body);

      if(response.statusCode == 200) {
        setState(() {
          _buttonState = true;
        });
        AllMyHomeResponse allMyHomeResponse = AllMyHomeResponse.fromJson(body);
        String msgReceiver = allMyHomeResponse.message.compte_receiver.notif;
        String msgSender = allMyHomeResponse.message.sender.notif;
        _successResponse("", msgReceiver, "", msgSender);
      } else{
        setState(() {
          _buttonState = true;
        });
        ErrorBody errorBody = ErrorBody.fromJson(body);
        _errorResponse(errorBody.message);
      }

      setState(() {
        _autovalidate = true;
      });
    }
  }



  String _amountFieldValidator (String value) {
    if (value.isEmpty) {
      return "Veuillez inserer le montant";
    }
    String p = "^(([1-9]*)|(([1-9]*)\.([0-9]*)))\$" ;
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      // So, the amount is valid
      return null;
    }
    // The pattern of the amount didn't match the regex above.
    return 'Inserer un montant valide';
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


  String _accountFieldValidator(String value) {
    if (value.isEmpty) {
      return "Veuillez inserer votre numéro de compte";
    }
    String p = "^[0-9'.\s]{9}\$";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      // So, the phone nber is valid
      return null;
    }
    // The pattern of the phone nber didn't match the regex above.
    return 'votre numéro de compte est court';
  }


  String _cardNumberFieldValidator(String value) {
    if (value.isEmpty) {
      return "Veuillez inserer votre numero de carte";
    }
    String p = "^[:;,\-@0-9a-zA-Zâéè'.\s]{8}\$";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      // So, the phone nber is valid
      return null;
    }
    // The pattern of the phone nber didn't match the regex above.
    return 'votre numéro de carte est cours';
  }
}