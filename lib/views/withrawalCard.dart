import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/appBar.dart';
import 'widgets/form/button.dart';
import 'widgets/form/textField.dart';
import 'widgets/instructionCard.dart';

class WithrawalCard extends StatefulWidget {
  @override
  _WithrawalCardState createState() => _WithrawalCardState();
}

class _WithrawalCardState extends State<WithrawalCard> {
  
  final _withrawSmopayeFormKey = GlobalKey<FormState>();
  TextEditingController _accountNumberController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  final _amountFormKey = GlobalKey<FormState>();

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
          InstructionCard(text: "Veuillez insérer votre numéro de carte puis suivre les étapes",),
          SizedBox(height: hv*10,),

          Form(
            key: _withrawSmopayeFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  maxLength: 8,
                  hintText: 'Numéro de carte',
                  controller: _accountNumberController,
                  emptyValidatorText: 'Entrer votre numéro de carte',
                  keyboardType: TextInputType.text,
                  validator: (str) => str.isEmpty ? 'Veuillez inserer votre numéro de carte' : null,
                  labelColor: Color(0xff039BE5)
                ),

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

      if (_withrawSmopayeFormKey.currentState.validate()) {
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
                        _check();
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

  _check () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
          DefaultAlertDialog(
            title: "Information",
            message: "Le Solde de votre compte ${_accountNumberController.text} est insuffisant",
            icon: Icon(Icons.cancel, color: Colors.red, size: 45,),
          );

      },
    );
  }

}