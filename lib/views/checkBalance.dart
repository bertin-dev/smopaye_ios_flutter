import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/form/passwordField.dart';

import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/appBar.dart';
import 'widgets/form/button.dart';
import 'widgets/form/dropdownField.dart';
import 'widgets/form/textField.dart';
import 'widgets/instructionCard.dart';

class CheckBalance extends StatefulWidget {
  @override
  _CheckBalanceState createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {

  final _checkBalanceFormKey = GlobalKey<FormState>();
  final _checkPasswordFormKey = GlobalKey<FormState>();

  TextEditingController _cardNumberController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String _balanceType = "deposit";

  bool _buttonState = true;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    return Scaffold(
      appBar: DefaultAppBar(title: "Vérifier son solde",),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          SizedBox(height: hv*3,),
          InstructionCard(text: "Veuillez insérer le numéro de carte et selectionner le type de solde, puis appuyer sur consulter.",),
          SizedBox(height: hv*10,),

          Form(
            key: _checkBalanceFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  maxLength: 8,
                  hintText: 'Numéro de carte',
                  controller: _cardNumberController,
                  emptyValidatorText: 'Entrer votre numéro de carte',
                  keyboardType: TextInputType.text,
                  validator: (str) => str.isEmpty ? 'Le numéro de carte ne peut-être vide' : null,
                  labelColor: Color(0xff039BE5)
                ),

                SizedBox(height: hv*3,),

                CustomDropDownField(
                  label: "Type de solde:",
                   onChangedFunc: (String value) {
                            setState(() {
                              _balanceType = value;
                            });
                          }, hintText: "solde",
                  items: [
                            DropdownMenuItem<String>(
                              child: Text('DEPOT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'deposit',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('UNITE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'unity',
                            )
                          ],
                          value: _balanceType,
                ),

                SizedBox(height: hv*7,),

          _buttonState ? 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomButton(
                    color: Color(0xff039BE5), text: 'Consulter', textColor: Colors.white,
                    onPressed: () async {_checkBalance(context);},
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

 // Fonction de consultation de solde
 
  _checkBalance (BuildContext context) async {

    print("accountnber: ${_cardNumberController.text}\n\n");
      setState(() {
       _autovalidate = true; 
      });

      if (_checkBalanceFormKey.currentState.validate()) {
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
              title: Text("Mot de Passe"),
              content: Form(
                key: _checkPasswordFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomPasswordField(
                        hintText: 'Mot de passe',
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        emptyValidatorText: 'Entrez votre mot de passe',
                        validator: _passwordFieldValidator,
                        color: Colors.black45,
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
                    if (_checkPasswordFormKey.currentState.validate()) {
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

  _check () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return 
          DefaultAlertDialog(
            title: "Information",
            message: "Le Solde $_balanceType de votre compte ${_cardNumberController.text} est de: 0 fcfa",
            icon: Icon(Icons.check_circle, color: Colors.green, size: 45,),
          );
          
        },
      );
  }

  // Fonction de validation du mot de passe

  String _passwordFieldValidator (String value) {
    if (value.isEmpty) {
    return "Entrez votre mot de passe";
    }
     String p = "^[:;,\-@0-9a-zA-Zâéè'.\s]{5,5}\$" ;
     RegExp regExp = new RegExp(p);
      if (regExp.hasMatch(value)) {
        // So, the password is valid
        return null;
      }
      // The pattern of the password didn't match the regex above.
      return 'Password must be 5 characters long';
  }


}