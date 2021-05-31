import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/allMyResponse.dart';
import 'package:smopaye_mobile/models/errorBody.dart';
import 'package:smopaye_mobile/models/rechargeResponse.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/alertDialogs/defaultDialog.dart';

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
  String accountNumber = "";
  String telephone = "";
  String payment = "";

  @override
  Widget build(BuildContext context) {
    final hv = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: hv * 3,
            ),
            InstructionCard(
              text:
                  "Veuillez Insérer votre numéro de téléphone et le montant de recharge, puis valider",
            ),
            SizedBox(
              height: hv * 10,
            ),

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
                        labelColor: Color(0xff039BE5)),
                    SizedBox(
                      height: hv * 7,
                    ),
                    _buttonState
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100.0),
                            child: CustomButton(
                              color: Color(0xff039BE5),
                              text: 'Récharger',
                              textColor: Colors.white,
                              onPressed: () async {
                                _reload(context);
                              },
                            ),
                          )
                        : CircularProgressIndicator(),
                  ],
                ))

            // Champ de texte du numéro de compte du bénéficiaire
          ],
        ),
      ),
    );
  }

  // Fonction de transfert

  _reload(BuildContext context) async {
    print(
        "phone: ${_phoneController.text}\namount: ${_amountController.text}\n");
    setState(() {
      _autovalidate = true;
    });

    if (_reloadFormKey.currentState.validate()) {
      setState(() {
        _buttonState = false;
      });

      _recharge_step1();

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

  String _amountFieldValidator(String value) {
    if (value.isEmpty) {
      return "Entrez votre mot de passe";
    }
    String p = "^(([1-9]*)|(([1-9]*)\.([0-9]*)))\$";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      // So, the amount is valid
      return null;
    }
    // The pattern of the amount didn't match the regex above.
    return 'Enter a valid amount';
  }

  // Fonction de recharge des comptes step 1
  _recharge_step1() async {
    final getInfoUser = await SharedPreferences.getInstance();

    dynamic response = await AuthService.recharge_step1(
        account_number: getInfoUser.get("key_myPersonalAccountNumberUser"),
        amount: double.parse(_amountController.text),
        phoneNumber: _phoneController.text);

    Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      RechargeResponse homeResponse = RechargeResponse.fromJson(body);
      setState(() {
        _buttonState = true;
        payment = homeResponse.message.paymentId;
      });

      if (payment != "") {
        _validateRecharge(
            "S\'il vous plait veuillez valider la recharge de votre Compte ${homeResponse.data.company} N°${homeResponse.data.account_number} en tapant ${homeResponse.message.channel_ussd} du service ${homeResponse.message.channel_name}");
      }
    } else {
      setState(() {
        _buttonState = true;
      });
      ErrorBody errorBody = ErrorBody.fromJson(body);
      _errorResponse(errorBody.message);
    }
  }

  _validateRecharge(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titlePadding: EdgeInsets.only(top: 15, left: 20),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Recharge en Attente de validation"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Valider",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                //Navigator.of(context).pop();
                _recharge_step2();
              },
            ),
          ],
        );
      },
    );
  }

  _successResponse(String id_cardSender, String msgSender) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return DefaultAlertDialog(
          title: "Information",
          message: "$msgSender",
          icon: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 45,
          ),
        );
      },
    );
  }

  _errorResponse(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return DefaultAlertDialog(
          title: "Information",
          message: "$message",
          icon: Icon(
            Icons.cancel,
            color: Colors.red,
            size: 45,
          ),
        );
      },
    );
  }

  _recharge_step2() async {
    final getInfoUser = await SharedPreferences.getInstance();

    dynamic response = await AuthService.recharge_step2(
        account_number: getInfoUser.get("key_myPersonalAccountNumberUser"),
        paymentId: payment);

    Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AllMyResponse allMyResponse = AllMyResponse.fromJson(body);
      _successResponse("", allMyResponse.message);
    } else {
      ErrorBody errorBody = ErrorBody.fromJson(body);
      if (errorBody.message.contains("payment pending")) {
        _errorResponse("Opération Encours…");
      } else {
        _errorResponse(errorBody.message);
      }
    }
  }
}
