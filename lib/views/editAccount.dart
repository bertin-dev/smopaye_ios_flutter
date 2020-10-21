import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/form/button.dart';
import 'widgets/form/passwordField.dart';
import 'widgets/form/textField.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  
  final _editAccountFormKey = GlobalKey<FormState>();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _oldPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  bool _buttonState = true;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editer Compte", style: TextStyle(fontSize: 19.0),),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == "moncompte") {
                Navigator.pushNamed(context, '/editAccount');
              }
              
            },
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: "apropos",
                  child: Text("A propos"),
                ),
                PopupMenuItem(
                  value: "tutoriel",
                  child: Text("tutoriel"),
                ),
                PopupMenuItem(
                  value: "moncompte",
                  child: Text("Mon compte"),
                ),
              ],
        )
        ],
      ),
      body: ListView(children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            autovalidate: _autovalidate,
            key: _editAccountFormKey,
            child: Column(children: <Widget>[
            CustomTextField(
            maxLength: 9,
            hintText: 'Téléphone',
            controller: _phoneController,
            emptyValidatorText: 'Entrez un numéro',
            keyboardType: TextInputType.phone,
            validator: _phoneFieldValidator,
            icon: Icons.phone_iphone,
            labelColor: Color(0xff039BE5)
          ),
          
          // Champ de texte du mot de passe

          CustomPasswordField(
            hintText: 'Ancien Mot de passe',
            keyboardType: TextInputType.text,
            controller: _oldPasswordController,
            emptyValidatorText: 'Enter old password',
            validator: _passwordFieldValidator,
            color: Color(0xff039BE5),
          ),

          // Champ de texte du mot de passe

          CustomPasswordField(
            hintText: 'Nouveau Mot de passe',
            keyboardType: TextInputType.text,
            controller: _newPasswordController,
            emptyValidatorText: 'Enter new password',
            validator: _passwordFieldValidator,
            color: Color(0xff039BE5),
          ),

          // Champ de texte du mot de passe

          CustomPasswordField(
            hintText: 'Confirmer Mot de passe',
            keyboardType: TextInputType.text,
            controller: _confirmPasswordController,
            emptyValidatorText: 'Enter confirmed password',
            validator: _passwordFieldValidator,
            color: Color(0xff039BE5),
          ),

          SizedBox(height: hv*5,),

          _buttonState ? 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: CustomButton(
                        color: Color(0xff039BE5), text: 'Suivant', textColor: Colors.white,
                        onPressed: () async {_editAccount(context);},
                      ),
                    )
                    : CircularProgressIndicator(),
          ],)),
        )
        
      ],),
    );
  }

 // Fonction d'édition de compte
 
  _editAccount (BuildContext context) async {

    print("Name: ${_phoneController.text}\nSurName: ${_oldPasswordController.text}\nPhone: ${_newPasswordController.text}\ntypeID: $_confirmPasswordController\n");
      setState(() {
       _autovalidate = true; 
      });

      if (_editAccountFormKey.currentState.validate()) {
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

  String _phoneFieldValidator (String value) {
    if (value.isEmpty) {
    return "Entrez un numéro";
    }
     String p = "^[:;,\-@0-9a-zA-Zâéè'.\s]{9}\$" ;
     RegExp regExp = new RegExp(p);
      if (regExp.hasMatch(value)) {
        // So, the password is valid
        return null;
      }
      // The pattern of the password didn't match the regex above.
      return 'Phone number must be 9 characters long';
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