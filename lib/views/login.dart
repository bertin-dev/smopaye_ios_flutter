import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/services/secureStorage.dart';
import 'widgets/alertDialogs/forgotPasswordDialog.dart';
import 'widgets/form/button.dart';
import 'widgets/form/passwordField.dart';
import 'widgets/form/textField.dart';

// Page d'authentification

void main(){
  runApp(myLogin());
}

class myLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff039BE5),
      ),
      home: Login(),
    );
  }
}
////////////////////////////////////////////////////////////////

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _loginFormKey = GlobalKey<FormState>();
  final _passwordRecoveryFormKey = GlobalKey<FormState>();

  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _idNumberController = new TextEditingController();

  TextEditingController _phoneDialogController = new TextEditingController();

  String _idNumberValue = "cni";

  String userPassword;
  bool _autovalidate = false;
  bool _autovalidate2 = false;
  bool isChecked = true;
  bool _buttonState = true;
  bool _button2State = true;
  String _language = 'default';

  @override
  void initState() {
    super.initState();
  }

  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    }
    on SocketException catch (_) {
      print('not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hv = MediaQuery
        .of(context)
        .size
        .height / 100;
    final wv = MediaQuery
        .of(context)
        .size
        .width / 100;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //SizedBox(height: hv*10),
          Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/images/bg3.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: SizedBox(
                    height: hv * 30,
                    child: SizedBox(child:
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 90),
                      child: Image.asset('assets/images/logo.png',
                        width: wv * 5, /* height: hv*10,*/),
                    ),
                      width: wv * 25,),
                  )
              ),
              /*Column(
                children: <Widget>[
                  SizedBox(child: Image.asset('assets/images/logo.png'), width: wv*30,),
                ],
              ),*/
            ],
          ),


          SizedBox(height: hv * 5),
          Center(child: Column(
            children: <Widget>[
              Text("Authentification", style: TextStyle(fontSize: 22.0,
                  color: Color(0xff039BE5),
                  fontWeight: FontWeight.w800)),
              SizedBox(
                  child: Divider(color: Color(0xff039BE5), thickness: 2.5,),
                  width: wv * 45)
            ],
          )),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Form(
              autovalidate: _autovalidate,
              key: _loginFormKey,
              child: Column(
                children: <Widget>[

                  // Champ de texte du numéro

                  CustomTextField(
                    maxLength: 9,
                    hintText: 'Téléphone',
                    controller: _phoneController,
                    emptyValidatorText: 'Entrez un numéro',
                    keyboardType: TextInputType.phone,
                    validator: _phoneFieldValidator,
                    icon: Icons.phone_iphone,
                    labelColor: Colors.black45,
                  ),

                  // Champ de texte du mot de passe

                  CustomPasswordField(
                    hintText: 'Mot de passe',
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
                    onSavedFunc: (value) => userPassword = value,
                    emptyValidatorText: 'Entrez votre mot de passe',
                    validator: _passwordFieldValidator,
                    color: Colors.black45,
                  ),

                  SizedBox(height: hv * 2.0,),

                  // Bouton de soumission

                  _buttonState ?

                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: CustomButton(
                          color: Color(0xff039BE5),
                          text: 'CONNEXION',
                          textColor: Colors.white,
                          onPressed: () async {
                            authentication(context);
                          },
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: CustomButton(
                          color: Color(0xff039BE5),
                          text: 'SOUSCRIPTION',
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/autoRegister');
                            //Navigator.pushNamed(context, '/renewSubscription');
                          },
                        ),
                      ),
                    ],
                  )

                      : Theme(child: CircularProgressIndicator(
                    backgroundColor: Color(0xff039BE5).withOpacity(0.1),),
                    data: ThemeData(
                        accentColor: Color(0xff039BE5).withOpacity(0.6)),),
                  SizedBox(height: 25.0),
                  Center(
                    child: InkWell(onTap: _forgotPassword,
                        child: Text("Mot de passe oublié ?",
                          style: TextStyle(color: Color(0xff039BE5),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0),)),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  // Fonction d'authentification 

  authentication(BuildContext context) async {
    setState(() {
      _autovalidate = true;
    });


    //REDIRECTION VERS LA PAGE D'ACCUEIL
    if (_loginFormKey.currentState.validate()) {

      setState(() {
        _buttonState = false;
      });

      // Test pour m'assurer que les valeurs sont bien recupérées
      print("Phone number: ${_phoneController
          .text} \nPassword: ${_passwordController.text}");

      // Processus d'authentification à l'aide du service d'authentification

      dynamic response = await AuthService.login(
          phone: _phoneController.text, password: _passwordController.text, secret: "Cnqactz7vnCGKBB7E12yN+17a+2Q/+d7PTkv1jOgcus=");

      if(response.statusCode == 200){
        response = json.decode(response.body);
        print(response);
        // Sauvegarde des tokens dans le secure storage à l'aide du service de sauvegarde sécurisée
       AuthService.saveToken(response["access_token"].toString());
        AuthService.savePhone(_phoneController.text);

        //SecureStorage.tokenStorage(access: response["access_token"].toString(), refresh: response["refresh_token"].toString());

        //redirection vers la HomePage
        Navigator.pushNamed(context, '/home', arguments: _phoneController.text);

      } else if(response.statusCode == 500){
        response = json.decode(response.body);
        print(response);
        _showDialog(response["exception"]+ " " + response["message"]);
      }
      else{
        response = json.decode(response.body);
        print(response["message"]);
        _showDialog(response["message"]);
      }

      setState(() {
        _buttonState = true;
      });

    }
  }

  //Fonction aui gère les Mot de passe oublié

  _forgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          AlertDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                "Récupérer votre mot de passe", textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17),),
              color: Colors.blue,
            ),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView(shrinkWrap: true,
                        children: <Widget>[
                          Form(
                              key: _passwordRecoveryFormKey,
                              autovalidate: _autovalidate2,
                              child: Column(
                                  children: <Widget>[
                                    CustomTextField(
                                      maxLength: 9,
                                      hintText: 'Téléphone',
                                      controller: _phoneDialogController,
                                      emptyValidatorText: 'Entrez un numéro',
                                      keyboardType: TextInputType.phone,
                                      validator: _phoneFieldValidator,
                                      icon: Icons.phone_iphone,
                                      labelColor: Color(0xff039BE5),
                                    ),
                                    Row(crossAxisAlignment: CrossAxisAlignment
                                        .end, children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, bottom: 12),
                                        child: SizedBox(child:
                                        DropdownButton<String>(
                                            isExpanded: true,
                                            underline: Container( //margin: EdgeInsets.only(bottom: 10.0, top: 5),
                                              decoration: BoxDecoration(
                                                color: Color(0xff039BE5),
                                              ),
                                              child: SizedBox(height: 2.3,),
                                            ),
                                            icon: Icon(Icons.arrow_drop_down,
                                                color: Color(0xff039BE5)),
                                            items: [
                                              DropdownMenuItem<String>(
                                                child: Text('CNI',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 18.0,
                                                        color: Color(
                                                            0xff039BE5))),
                                                value: 'cni',
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Passeport',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 15.0,
                                                        color: Color(
                                                            0xff039BE5))),
                                                value: 'passport',
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Reçu',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 18.0,
                                                        color: Color(
                                                            0xff039BE5))),
                                                value: 'receipt',
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text(
                                                    'Permis de résidence',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 13.0,
                                                        color: Color(
                                                            0xff039BE5))),
                                                value: 'residence_permit',
                                              ),
                                              DropdownMenuItem<String>(
                                                child: Text('Carte d\'étudiant',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 13.0,
                                                        color: Color(
                                                            0xff039BE5))),
                                                value: 'student_card',
                                              ),
                                            ],
                                            onChanged: (String value) {
                                              setState(() {
                                                _idNumberValue = value;
                                              });
                                              print(_idNumberValue);
                                            },
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Text("Identification"),
                                            ),
                                            value: _idNumberValue
                                        ),
                                          width: 80,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: CustomTextField(
                                            maxLength: 9,
                                            hintText: 'N° CNI',
                                            controller: _idNumberController,
                                            emptyValidatorText: 'Entrer votre numéro de CNI',
                                            validator: (str) =>
                                            str.isEmpty
                                                ? 'Votre numéro de pièce d\'idientite est vide'
                                                : null,
                                            keyboardType: TextInputType.text,
                                            icon: Icons.credit_card,
                                            labelColor: Colors.black45
                                        ),
                                      ),


                                    ],
                                    ),

                                    SizedBox(height: 8),

                                    _button2State ?

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 60.0, right: 60.0),
                                      child: CustomButton(
                                        color: Color(0xff039BE5),
                                        text: 'VALIDER',
                                        textColor: Colors.white,
                                        onPressed: () async {
                                          _passwordRecovery(context);
                                        },
                                      ),
                                    )

                                        : Theme(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Color(0xff039BE5)
                                            .withOpacity(0.1),),
                                      data: ThemeData(
                                          accentColor: Color(0xff039BE5)
                                              .withOpacity(0.6)),),

                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

// Fonction d'authentification 

  _passwordRecovery(BuildContext context) async {
    setState(() {
      _autovalidate2 = true;
    });

    if (_passwordRecoveryFormKey.currentState.validate()) {
      print("Phone number: ${_phoneDialogController
          .text} \nNumber: ${_idNumberController
          .text}\nId Type: $_idNumberValue");

      //connexion au web service
      dynamic response = await AuthService.reset_password(
          phone: _phoneDialogController.text, pIdentite: _idNumberController.text);

      print(response.body);
      if(response.statusCode == 200){
        setState(() {
          _button2State = true;
        });
        Navigator.pop(context);
        response = json.decode(response.body);
        _showDialogForgotPassword(response["message"]);
      }
      /*if(response.statusCode == 200) {
        response = json.decode(response.body);
        _showDialog(response);

      } else if(response.statusCode == 500){
        response = json.decode(response.body);
        print(response);
        _showDialog(response["exception"]+ " " + response["message"]);
      }
      else{
        response = json.decode(response.body);
        print(response["data"]["error"]);
        _showDialog(response["data"]["error"]);
      }*/













      /*setState(() {
        _button2State = false;
      });

      Timer(Duration(seconds: 1),
              () {
            setState(() {
              _button2State = true;
            });
            Navigator.pop(context);
          }
      );*/

      setState(() {
        _button2State = true;
      });
    }
    else {
      setState(() {
        _autovalidate2 = true;
      });
    }
  }

  // Fonction de validation du mot de passe

  String _passwordFieldValidator(String value) {
    if (value.isEmpty) {
      return "Entrez votre mot de passe";
    }
    String p = "^[:;,\-@0-9a-zA-Zâéè'.\s]{5,5}\$";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      // So, the password is valid
      return null;
    }
    // The pattern of the password didn't match the regex above.
    return 'Password must be 5 characters long';
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


  //boite de dialog pour les erreurs
  void _showDialog(String response) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Information'),
            content: new Text(response),
            actions: <Widget>[
              new RaisedButton(onPressed: () {
                Navigator.of(context).pop();
              })
            ],
          );
        }
    );
  }

  //boite de dialog pour les erreurs
  void _showDialogForgotPassword(String response) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Information'),
            content: new Text(response),
            actions: <Widget>[
              new RaisedButton(onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/login');

              })
            ],
          );
        }
    );
  }


}