import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/form/button.dart';
import 'widgets/form/dropdownField.dart';
import 'widgets/form/textField.dart';

// Page d'authentification

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final _registerFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _accountNberController = new TextEditingController();
  TextEditingController _idNumberController = new TextEditingController();
  

  bool _autovalidate = false;
  bool isChecked = true;
  bool _buttonState = true;
  String _genderValue = "male";
  String _statusValue = "utilisateur";
  String _categoryValue = "petit_commerce";
  String _idNumberValue = "cni";
  String appBarMenuValue;

  bool _monthlySubscriptionState = false;
  bool _weeklySubscriptionState = false;
  bool _serviceSubscriptionState = false;
  String suscriptionType = 'service';

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final wv =MediaQuery.of(context).size.width/100;
    return Scaffold(
      appBar: AppBar(
        title: Text("Enregistrement"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                appBarMenuValue = value;
              });
              Navigator.pushNamed(context, '/register');
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
      body: ListView(
        children: <Widget>[
          /*Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg3.png'),
                fit: BoxFit.cover,
              )
            ),
            child: SizedBox(
              height: hv*10,
              child: SizedBox(child: 
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset('assets/images/logo.png', width: wv*15, height: hv*10,),
              ),
               width: wv*25,),
              )
          ),*/
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              autovalidate: _autovalidate,
              key: _registerFormKey,
              child: Column(
                children: <Widget>[

                  // Champ de texte du nom

                  CustomTextField(
                    hintText: 'Nom',
                    controller: _nameController,
                    emptyValidatorText: 'Enter name',
                    keyboardType: TextInputType.text,
                    validator: (str) => str.isEmpty ? 'Name Field cannot be empty' : null,
                    labelColor: Color(0xff039BE5)
                  ),
                  
                  SizedBox(height: 5.0),
                  
                  // Champ de texte du prénom

                  CustomTextField(
                    hintText: 'Prénom',
                    controller: _surnameController,
                    emptyValidatorText: 'Enter surname',
                    keyboardType: TextInputType.text,
                    validator: (str) => str.isEmpty ? 'Surname Field cannot be empty' : null,
                    labelColor: Color(0xff039BE5)
                  ),
                  
                  SizedBox(height: 5.0),


                  // Champ de texte du téléphone

                  CustomTextField(
                    hintText: 'Téléphone',
                    controller: _phoneController,
                    emptyValidatorText: 'Entrez un numéro',
                    keyboardType: TextInputType.phone,
                    validator: _phoneFieldValidator,
                    labelColor: Color(0xff039BE5)
                  ),

                  SizedBox(height: 10.0),

                  CustomDropDownField(
                  label: "Type d'ID",
                   onChangedFunc: (String value) {
                            setState(() {
                              _idNumberValue = value;
                            });
                          }, hintText: "Type de pièce", 
                  items: [
                            DropdownMenuItem<String>(
                              child: Text('CNI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'cni',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Passeport', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'passport',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Reçu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'receipt',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Permis de résidence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'residence_permit',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Carte d\'étudiant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'student_card',
                            ),
                          ],
                          value: _idNumberValue,
                  ),

                  SizedBox(height: 5.0),
                  
                  // Champ de texte de la CNI

                  CustomTextField(
                    hintText: 'N° Pièce Justificative',
                    controller: _idNumberController,
                    emptyValidatorText: 'Enter CNI number',
                    validator: (str) => str.isEmpty ? 'Room nber Field cannot be empty' : null,
                    keyboardType: TextInputType.text,
                    labelColor: Color(0xff039BE5)
                  ),

                  SizedBox(height: 5.0),
                  
                  // Champ de texte de la CNI

                  CustomTextField(
                    hintText: 'Addresse',
                    controller: _addressController,
                    emptyValidatorText: 'Enter address',
                    validator: (str) => str.isEmpty ? 'Address Field cannot be empty' : null,
                    keyboardType: TextInputType.text,
                    labelColor: Color(0xff039BE5)
                  ),
                  
                  
                  
                  SizedBox(height: 5.0),


                  CustomDropDownField(
                  label: "Genre",
                   onChangedFunc: (String value) {
                            setState(() {
                              _genderValue = value;
                            });
                          }, hintText: "Votre sexe", 
                  items: [
                            DropdownMenuItem<String>(
                              child: Text('Male', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'male',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Female', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'female',
                            )
                          ],
                          value: _genderValue,
                ),

                  SizedBox(height: 5.0),
                  
                CustomDropDownField(
                  label: "Statut",
                   onChangedFunc: (String value) {
                            setState(() {
                              _statusValue = value;
                            });
                          }, hintText: "Votre statut", 
                  items: [
                            DropdownMenuItem<String>(
                              child: Text('Utilisateur', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'utilisateur',
                            ),
                          ],
                          value: _statusValue,
                ),

                SizedBox(height: 5.0),

                CustomDropDownField(
                  label: "Catégorie",
                   onChangedFunc: (String value) {
                            setState(() {
                              _categoryValue = value;
                            });
                          }, hintText: "Votre catégorie", 
                  items: [
                            DropdownMenuItem<String>(
                              child: Text('Petit Commerce', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'petit_commerce',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Secrétariat bureautique', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'secretariat_bureatique',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Particulier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'particulier',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Etudiant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'etudiant',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Utilisateur', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'utilisateur',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Taxi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'taxi',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Moto taxi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'moto_taxi',
                            ),
                            
                          ],
                          value: _categoryValue,
                  ),

                  SizedBox(height: 5.0),
                  
                  // Champ de texte de la CNI

                  CustomTextField(
                    hintText: 'Numéro de compte',
                    controller: _accountNberController,
                    emptyValidatorText: 'Enter account number',
                    validator: (str) => str.isEmpty ? 'Account nber Field cannot be empty' : null,
                    keyboardType: TextInputType.text,
                    labelColor: Color(0xff039BE5)
                  ),

                  /*Row(children: <Widget>[
                    Text("Souscription"),
                    Column(children: <Widget>[
                      CheckboxListTile(
                        title: Text("Monthly"),
                        value: _monthlySubscriptionState,
                        onChanged: (value) {
                            setState(() {
                              _monthlySubscriptionState = value;
                            });
                          },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Weekly"),
                        value: _weeklySubscriptionState,
                        onChanged: (value) {
                            setState(() {
                              _weeklySubscriptionState = value;
                            });
                          },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Service"),
                        value: _serviceSubscriptionState,
                        onChanged: (value) {
                            setState(() {
                              _serviceSubscriptionState = value;
                            });
                          },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],)
                  ],),*/
                  SizedBox(height: hv*5),

                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Abonnement", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                      SizedBox(width: wv*10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(onTap: (){_suscriptionChoice("monthly");}, enableFeedback: false,
                            child: Row(
                              children: <Widget>[
                                SizedBox(height: 24.0,
                                  child: Checkbox(focusColor: Color(0xff039BE5),
                                    value: _monthlySubscriptionState,
                                    onChanged: (value) { _suscriptionChoice("monthly");}
                                  ),
                                ),
                                Text("Mensuel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              ],
                            ),
                          ),
                          InkWell(onTap: (){_suscriptionChoice("weekly");},
                            child: Row(
                              children: <Widget>[
                                SizedBox(height: 24.0,
                                  child: Checkbox(
                                    value: _weeklySubscriptionState,
                                    onChanged: (value) { _suscriptionChoice("weekly");}
                                  ),
                                ),
                                Text("Hebdomadaire", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              ],
                            ),
                          ),
                          InkWell(onTap: (){_suscriptionChoice("service");},
                            child: Row(
                              children: <Widget>[
                                SizedBox(height: 24.0,
                                  child: Checkbox(
                                    value: _serviceSubscriptionState,
                                    onChanged: (value) { _suscriptionChoice("service");}
                                  ),
                                ),
                                Text("Service", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              ],
                            ),
                          ),
                          
                          
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: hv*6.3),

                  Text("En appuyant sur Inscription, vous acceptez nos conditions générales d'utilisation, notre politique de confidentialité. Vous recevrez peut-être des notifications par texto (SMS) de notre part.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Color(0xff039BE5))
                  ),

                  SizedBox(height: hv*5),


                  // Bouton de soumission
                  
                  _buttonState ? 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: CustomButton(
                      color: Color(0xff039BE5), text: 'Suivant', textColor: Colors.white,
                      onPressed: () async {_register(context);},
                    ),
                  )
                  : CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  SizedBox(height: 35.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

   
  // Fonction d'authentification 
 
  _register (BuildContext context) async {

    print("Name: ${_nameController.text}\nSurName: ${_surnameController.text}\nPhone: ${_phoneController.text}\ntypeID: $_idNumberValue\nGenre: $_genderValue\nCategorie: $_categoryValue\nStatut: $_statusValue\nNumero de compte: ${_accountNberController.text}\n");
      setState(() {
       _autovalidate = true; 
      });

      if (_registerFormKey.currentState.validate()) {
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

  //Fonction de gestion des checkbox

  _suscriptionChoice (String choice) {

    if (choice == "monthly"){
      suscriptionType = "monthly";
      setState(() {
        suscriptionType = "service";_monthlySubscriptionState = true; _weeklySubscriptionState = false; _serviceSubscriptionState = false;
      });
    }
    if (choice == "weekly"){
      suscriptionType = "weekly";
      setState(() {
        suscriptionType = "service";_monthlySubscriptionState = false; _weeklySubscriptionState = true; _serviceSubscriptionState = false;
      });
    }
    if (choice == "service"){
      suscriptionType = "service";
      setState(() {
        suscriptionType = "service"; _monthlySubscriptionState = false; _weeklySubscriptionState = false; _serviceSubscriptionState = true;
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
}