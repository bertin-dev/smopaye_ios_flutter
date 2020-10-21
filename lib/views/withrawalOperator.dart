import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/appBar.dart';
import 'widgets/form/button.dart';
import 'widgets/form/textField.dart';
import 'widgets/instructionCard.dart';

class WithrawalOperator extends StatefulWidget {
  @override
  _WithrawalOperatorState createState() => _WithrawalOperatorState();
}

class _WithrawalOperatorState extends State<WithrawalOperator> {
  
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
      appBar: DefaultAppBar(title: "Faire un Retrait",),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          SizedBox(height: hv*3,),
          InstructionCard(text: "Insérez votre numero de compte et poursuivez les étapes",),
          SizedBox(height: hv*10,),

          Form(
            key: _withrawOperatorFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  hintText: 'Numéro de compte',
                  controller: _accountNumberController,
                  emptyValidatorText: 'Enter account number',
                  keyboardType: TextInputType.text,
                  validator: (str) => str.isEmpty ? 'account number Field cannot be empty' : null,
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