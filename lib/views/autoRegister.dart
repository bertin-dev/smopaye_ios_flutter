import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'widgets/form/button.dart';
import 'widgets/form/dropdownField.dart';
import 'widgets/form/textField.dart';

// Page d'authentification

class AutoRegister extends StatefulWidget {
  @override
  _AutoRegisterState createState() => _AutoRegisterState();
}

class _AutoRegisterState extends State<AutoRegister> {
  
  final _autoRegisterFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _idNumberController = new TextEditingController();
  

  bool _autovalidate = false;
  bool isChecked = true;
  bool _buttonState = true;
  String _genderValue = "masculin";
  String _idNumberValue = "cni";
  String appBarMenuValue;

  //web service pour charger les roles
  List<dynamic> _dataRoleAndCategory = List();
  String myRole;
  String _categoryValue;

  Map<String, String> allRole;
  Map allcategorie = new HashMap<String, String>();

  List<_StringWithTag> itemList = new List();

  void getAllCategories() async {
    var listData = await AuthService.roleAndCategory();
    setState(() {

      //allRole.clear();
      allcategorie.clear();


      _dataRoleAndCategory = listData;
      _dataRoleAndCategory.map((item) {

        allRole = {'${item["role"]["id"]}': item["role"]["name"]};
        allcategorie = {'${item["id"]}': item["name"]};

        allRole.forEach((k, v) {

            itemList.add(_StringWithTag(v, k));
            print('{ key: $k, value: $v }');

        });



        /*allRole.entries.forEach((e) {
          print('{ keyyyyyyyyy: ${e.key}, valueeeeeeee: ${e.value} }');
        });*/

        print("-------------${item["role"]["name"]}");
      }).toList();
    });

    print("data : $listData");
  }


  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final wv =MediaQuery.of(context).size.width/100;
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription - Step 1"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                appBarMenuValue = value;
              });
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
              key: _autoRegisterFormKey,
              child: Column(
                children: <Widget>[

                  // Champ de texte du nom

                  CustomTextField(
                    hintText: 'Nom',
                    controller: _nameController,
                    emptyValidatorText: 'Enter name',
                    keyboardType: TextInputType.text,
                    labelColor: Color(0xff039BE5)
                  ),

                  SizedBox(height: 5.0),

                  // Champ de texte du prénom

                  CustomTextField(
                    hintText: 'Prénom',
                    controller: _surnameController,
                    emptyValidatorText: 'Enter surname',
                    keyboardType: TextInputType.text,
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
                              child: Text('Masculin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'masculin',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Feminin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: 'feminin',
                            )
                          ],
                          value: _genderValue,
                ),

                  SizedBox(height: 5.0),


                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButton(
                        hint: Text("Select Province"),
                        value: myRole,
                        items: _dataRoleAndCategory.map((item) {
                          return DropdownMenuItem(
                            child: Text(item['name']),
                            value: item['name'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            myRole = value;
                          });
                        },
                      ),
                      Text(
                        "Kamu memilih provinsi $myRole",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),*/


              Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(child: Text("statut", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5)),), width: wv*22,),
                ),
                Expanded(
                  child: ButtonTheme(alignedDropdown: true,
                    child: DropdownButton(
                      isExpanded: true,
                      underline: Container(margin: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xff039BE5),
                        ),
                        child: SizedBox(height: 2.3,),
                      ),
                      icon: Icon(Icons.arrow_drop_down, color: Color(0xff039BE5)),

                      hint: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("Utilisateur", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                      ),
                      value: myRole,
                      items:itemList.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.string, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                          value: (item.tag).toString(),
                        );
                      }).toSet().toList(),
                      onChanged: (value) {
                        setState(() {
                          myRole = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
              ),

                SizedBox(height: 5.0),


                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(child: Text("Catégorie", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5)),), width: wv*22,),
                    ),
                    Expanded(
                      child: ButtonTheme(alignedDropdown: true,
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(margin: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xff039BE5),
                            ),
                            child: SizedBox(height: 2.3,),
                          ),
                          icon: Icon(Icons.arrow_drop_down, color: Color(0xff039BE5)),

                          /*hint: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("Selectionner votre Role"),
                      ),*/
                          value: _categoryValue,
                          items: _dataRoleAndCategory.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5))),
                              value: item['name'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _categoryValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                  ),

                /*CustomDropDownField(
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
                  ),*/
                  

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
                      onPressed: () async {_autoRegister(context);},
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
 
  authentication (BuildContext context) async {
      setState(() {
       _autovalidate = true; 
      });

      if (_autoRegisterFormKey.currentState.validate()) {
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

  _autoRegister (BuildContext context) async {

    if (_autoRegisterFormKey.currentState.validate()) {
      print("phone: ${_phoneController.text} \n name and surname: ${_nameController.text} ${_surnameController.text} \n");
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

class _StringWithTag {
   String string;
   Object tag;

   _StringWithTag(String string, Object tag) {
    this.string = string;
    this.tag = tag;
  }

   String toString() {
    return string;
  }
}