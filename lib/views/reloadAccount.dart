import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/appBar.dart';
import 'widgets/form/button.dart';
import 'widgets/form/textField.dart';
import 'widgets/instructionCard.dart';

class ReloadAccount extends StatefulWidget {
  @override
  _ReloadAccountState createState() => _ReloadAccountState();
}

class _ReloadAccountState extends State<ReloadAccount> {
  
  final _reloadFormKey = GlobalKey<FormState>();
  TextEditingController _phoneController = new TextEditingController();
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
          InstructionCard(text: "Veuillez Insérer votre numéro de téléphone et le montant de recharge, puis valider",),
          SizedBox(height: hv*10,),

          Form(
            key: _reloadFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[

                CustomTextField(
                  maxLength: 9,
                  hintText: 'Téléphone',
                  controller: _phoneController,
                  emptyValidatorText: 'Entrez un numéro',
                  keyboardType: TextInputType.phone,
                  validator: _phoneFieldValidator,
                  labelColor: Color(0xff039BE5),
                ),

                CustomTextField(
                  maxLength: 7,
                  hintText: 'Montant',
                  controller: _amountController,
                  emptyValidatorText: 'Enter amount',
                  keyboardType: TextInputType.number,
                  validator: _amountFieldValidator,
                  labelColor: Color(0xff039BE5)
                ),

                SizedBox(height: hv*7,),

          _buttonState ? 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomButton(
                    color: Color(0xff039BE5), text: 'Récharger', textColor: Colors.white,
                    onPressed: () async {_reload(context);},
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

 // Fonction de transfert
 
  _reload (BuildContext context) async {

    print("phone: ${_phoneController.text}\namount: ${_amountController.text}\n");
      setState(() {
       _autovalidate = true; 
      });

      if (_reloadFormKey.currentState.validate()) {
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

  //Fonction de validation du numéro de téléphone

  String _phoneFieldValidator(String value) {
    if (value.isEmpty) {
      return "Entrez un numéro";
    }
    String p = "^[:;,\-@0-9a-zA-Zâéè'.\s]{9}\$";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      // So, the phone nber is valid
      return null;
    }
    // The pattern of the phone nber didn't match the regex above.
    return 'Phone number must be 9 characters long';
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

}