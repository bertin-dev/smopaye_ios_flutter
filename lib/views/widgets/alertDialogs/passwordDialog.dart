import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/form/passwordField.dart';

class PasswordDialog extends StatefulWidget {

  final Key passwordFormKey;
  final TextEditingController passwordController;
  final Function confirmFunction;
  final Function validationFunction;

  const PasswordDialog({Key key, this.passwordFormKey, this.passwordController, this.confirmFunction, this.validationFunction}) : super(key: key);

  @override
  _PasswordDialogState createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              titlePadding: EdgeInsets.only(top: 15, left: 20),
              title: Text("Mot de Passe"),
              content: Form(
                key: widget.passwordFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomPasswordField(
                        hintText: 'Mot de passe',
                        keyboardType: TextInputType.text,
                        controller: widget.passwordController,
                        emptyValidatorText: 'Entrez votre mot de passe',
                        validator: widget.validationFunction,
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
                  onPressed: widget.confirmFunction,
                ),
              ],
            );
  }

}