import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/form/passwordField.dart';
import 'package:smopaye_mobile/views/widgets/instructionCard.dart';

import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/appBar.dart';
import 'widgets/form/button.dart';
import 'widgets/form/textField.dart';

class RenewSubscription extends StatefulWidget {
  @override
  _RenewSubscriptionState createState() => _RenewSubscriptionState();
}

class _RenewSubscriptionState extends State<RenewSubscription> {

  final _checkPasswordFormKey = GlobalKey<FormState>();
  TextEditingController _passwordController = new TextEditingController();
  
  final _renewFormKey = GlobalKey<FormState>();
  TextEditingController _accountNumberController = new TextEditingController();

  bool _buttonState = true;
  bool _autovalidate = false;

  bool _monthlySubscriptionState = false;
  bool _weeklySubscriptionState = false;
  String _suscriptionType = "none";

  //Account Number
  final String account_id = "123456789";

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final wv =MediaQuery.of(context).size.width/100;
    return Scaffold(
      appBar: DefaultAppBar(title: "Renouveller Abonnement",),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          SizedBox(height: hv*3,),
          InstructionCard(text: "Insérez votre numero de carte, choisissez un type d'abonnement puis valider"),
          SizedBox(height: hv*15,),

          Form(
            key: _renewFormKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                /*CustomTextField(
                  hintText: 'Numéro de carte',
                  controller: _accountNumberController,
                  emptyValidatorText: 'Entrer un Numéro de carte',
                  keyboardType: TextInputType.text,
                  validator: (str) => str.isEmpty ? 'Veuillez insérer le numéro de carte' : null,
                  labelColor: Color(0xff039BE5)
                ),*/

                SizedBox(height: hv*5,),

                Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Abonnement", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                      SizedBox(width: wv*10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(onTap: (){_suscriptionChoice("mensuel");}, enableFeedback: false,
                            child: Row(
                              children: <Widget>[
                                SizedBox(height: 24.0,
                                  child: Checkbox(focusColor: Color(0xff039BE5),
                                    value: _monthlySubscriptionState,
                                    onChanged: (value) { _suscriptionChoice("mensuel");}
                                  ),
                                ),
                                Text("Mensuel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              ],
                            ),
                          ),
                          InkWell(onTap: (){_suscriptionChoice("semaine");},
                            child: Row(
                              children: <Widget>[
                                SizedBox(height: 24.0,
                                  child: Checkbox(
                                    value: _weeklySubscriptionState,
                                    onChanged: (value) { _suscriptionChoice("semaine");}
                                  ),
                                ),
                                Text("Hebdomadaire", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              ],
                            ),
                          ),
                          
                          
                        ],
                      ),
                    ],
                  ),

                SizedBox(height: hv*7,),

          _buttonState ? 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomButton(
                    color: Color(0xff039BE5), text: 'Effectuer', textColor: Colors.white,
                    onPressed: () async {_renew(context);},
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

 // Fonction de re-abonnement
   _renew (BuildContext context) async {

    print("accountnber: ${_accountNumberController.text}, subscription: $_suscriptionType\n");
      setState(() {
       _autovalidate = true; 
      });

      if (_renewFormKey.currentState.validate() && _suscriptionType != "none") {
        setState(() {
        _buttonState = false;
        });
        
      /*Timer(Duration(seconds: 1),
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
      );*/


        setState(() {
          _buttonState = true;
        });
        Navigator.of(context).pop();
        _check();



      setState(() {
         _buttonState = false;
        });

      setState(() {
       _autovalidate = true; 
      });
      }
      else if (_suscriptionType == "none"){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return 
            DefaultAlertDialog(
              title: "Error",
              message: "Choisissez un type d'abonnement",
              icon: Icon(Icons.cancel, color: Colors.red, size: 45,),
            );
            
          },
        );
      }
  }

  _suscriptionChoice (String choice) {

    if (choice == "mensuel"){
      _suscriptionType = "mensuel";
      setState(() {
        _suscriptionType = "mensuel";
        _monthlySubscriptionState = true;
        _weeklySubscriptionState = false;
      });
    }
    if (choice == "semaine"){
      _suscriptionType = "semaine";
      setState(() {
        _suscriptionType = "semaine";
        _monthlySubscriptionState = false;
        _weeklySubscriptionState = true;
      });
    }

  }

   _check () async  {


    //connexion au web service
    dynamic response = await AuthService.abonnement(account_id: int.parse(account_id), typeAbonnement: _suscriptionType);

    print(response.statusCode);
    print(response.body);

    /*if (response.statusCode == 200) {
      //Navigator.pop(context);
      response = json.decode(response.body);
      _success_showDialog(response["message"]);
    } else if(response.statusCode == 500){
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

}