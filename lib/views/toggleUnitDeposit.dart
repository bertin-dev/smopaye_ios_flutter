

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/form/button.dart';
import 'package:smopaye_mobile/views/widgets/form/dropdownField.dart';
import 'package:smopaye_mobile/views/widgets/form/textField.dart';
import 'package:smopaye_mobile/views/widgets/instructionCard.dart';

class ToggleUnitDeposit extends StatefulWidget {
  @override
  _ToggleUnitDepositState createState() => _ToggleUnitDepositState();
}

class _ToggleUnitDepositState extends State<ToggleUnitDeposit> {

  final _transferFormKey = GlobalKey<FormState>();
  TextEditingController _amountController = new TextEditingController();

  bool _buttonState = true;
  bool _autovalidate = false;
  String _balanceType = "deposit";

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
                    label: "Basculer votre solde",
                    onChangedFunc: (String value) {
                      setState(() {
                        _balanceType = value;
                      });
                    }, hintText: "basculer",
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

                  SizedBox(height: hv*3,),

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
                      onPressed: () async {_toggle(context);},
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

  _toggle (BuildContext context) async {

    print("type_solde: ${_balanceType}\namount: ${_amountController.text}\n");
    setState(() {
      _autovalidate = true;
    });

    if (_transferFormKey.currentState.validate()) {
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
}

