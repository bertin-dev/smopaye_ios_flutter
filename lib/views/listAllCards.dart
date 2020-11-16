import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/abonnement.dart';
import 'package:smopaye_mobile/models/dataAllUserCard.dart';
import 'package:smopaye_mobile/models/dataUser.dart';
import 'package:smopaye_mobile/models/dataUserCard.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/alertDialogs/defaultDialog.dart';
import 'package:smopaye_mobile/views/widgets/form/textField.dart';
import 'package:smopaye_mobile/views/widgets/instructionCard.dart';

class ListAllCards extends StatefulWidget {
  @override
  _ListAllCardsState createState() => _ListAllCardsState();
}


class _ListAllCardsState extends State<ListAllCards> {
  String tel = "";
  bool rememberMe = false;
  bool rememberMe1 = false;
  final _amountFormKey = GlobalKey<FormState>();
  TextEditingController _amountController = new TextEditingController();
  String cardOwner = "";

  @override
  void initState() {
    super.initState();
    readPhone();
  }

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final wv =MediaQuery.of(context).size.width/100;

    AuthService authService = new AuthService();
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(

            children: <Widget>[
              SizedBox(height: hv*3,),
              InstructionCard(text: "Dans cette section, vous verez la liste de toutes les cartes de votre compte. Pour recharger une carte, il suffit de là cocher entrez le montant puis valider."),
              SizedBox(height: hv*3,),
              Text("Carte Principale", style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              Expanded(
                child: Container(
                  //color: Colors.red,
                  padding: EdgeInsets.all(1.0),
                  child: FutureBuilder(
                    future: authService.userProfilOwnerCard(tel),
                    builder: (BuildContext context, AsyncSnapshot<DataAllUserCard> snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.active:
                        //STILL WORKING
                          return _loading();
                          break;
                        case ConnectionState.waiting:
                        //STILL WORKING
                          return _loading();
                          break;
                        case ConnectionState.none:
                        //ERROR
                          return _error('No Connection has been made');
                          break;
                        case ConnectionState.done:
                        //COMPLETED
                          if(snapshot.hasError){
                            return _error(snapshot.error.toString());
                          }
                          if((snapshot.data.cards).length==0){
                            return drawEmptySubscriptionList();
                          } else{
                            if(snapshot.hasData){
                              return showOwnerCard(snapshot.data);
                            }
                          }
                          break;
                      }
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Text('Vous ne possédez pas de carte principale')
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text("Liste des sous-cartes", style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              Expanded(
                child: Container(
                  //color: Colors.red,
                  padding: EdgeInsets.all(1.0),
                  child: FutureBuilder(
                    future: authService.findAllUserCards(user_id: 14),
                    builder: (BuildContext context, AsyncSnapshot<List<DataAllUserCard>> snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.active:
                        //STILL WORKING
                          return _loading();
                          break;
                        case ConnectionState.waiting:
                        //STILL WORKING
                          return _loading();
                          break;
                        case ConnectionState.none:
                        //ERROR
                          return _error('No Connection has been made');
                          break;
                        case ConnectionState.done:
                          print(snapshot.data);
                        //COMPLETED
                          if((snapshot.data)==null){
                            print("///////////////////");
                            return drawEmptySubscriptionList();
                          } else{
                            if(snapshot.hasData){
                              return drawOwnerCardList(snapshot.data);
                            }
                          }

                          if(snapshot.hasError){
                            print("22222222222222222222");
                            return _error(snapshot.error.toString());
                          }
                          break;
                      }
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Text('Vous ne possedez pas de sous-carte')
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget showOwnerCard(DataAllUserCard dataAllUserCard){
      cardOwner = dataAllUserCard.cards[0].code_number;

    return ListView.builder(
      itemCount: dataAllUserCard.cards.length,
      itemBuilder: (BuildContext context, int position){
        return InkWell(
          child: Card(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0,),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image(
                              image: AssetImage('assets/images/card.png'),
                            width: 60,
                          ),
                          Column(
                              children: <Widget>[
                                Text("N°${dataAllUserCard.cards[position].code_number}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                SizedBox(height: 10.0,),
                                Text("Tel: ${dataAllUserCard.phone}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0, fontStyle: FontStyle.italic, color: Colors.grey)),
                              ]
                          ),
                          Column(
                              children: <Widget>[
                                Text("${dataAllUserCard.cards[position].serial_number}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                SizedBox(height: 10.0,),
                                Text("Etat: ${dataAllUserCard.cards[position].card_state}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0, fontStyle: FontStyle.italic, color: Colors.grey)),
                              ]
                          ),
                          Column(
                              children: <Widget>[
                                Checkbox(
                                    value: rememberMe,
                                    onChanged: _OwnerCardChanged
                                )
                              ]
                          )
                        ]
                    ),
                    SizedBox(height: 15.0,),
                  ],
                ),
              )
          ),
          onTap: (){

          },
        );
      },
    );
  }

  Widget drawOwnerCardList(List<DataAllUserCard> allUserCard){
    return ListView.builder(
      itemCount: allUserCard.length,
      itemBuilder: (BuildContext context, int position){
        return InkWell(
          child: Card(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0,),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.subscriptions,
                            color: Colors.grey,
                            size: 60.0,
                          ),
                          Column(
                              children: <Widget>[
                                Text("N° ${allUserCard[position].cards[position].code_number}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                SizedBox(height: 10.0,),
                                Text("Tel :  ${allUserCard[position].phone}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0, fontStyle: FontStyle.italic, color: Colors.grey)),
                              ]
                          ),
                          Column(
                              children: <Widget>[
                                Text("${allUserCard[position].cards[position].serial_number}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                SizedBox(height: 10.0,),
                                Text("Etat :  ${allUserCard[position].cards[position].card_state}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0, fontStyle: FontStyle.italic, color: Colors.grey)),
                              ]
                          ),
                          Column(
                              children: <Widget>[
                              Checkbox(
                              value: rememberMe1,
                              onChanged: _OwnerCardListChanged
                              )
                              ]
                          )
                        ]
                    ),
                    SizedBox(height: 15.0,),
                  ],
                ),
              )
          ),
          onTap: (){

          },
        );
      },
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  readPhone() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.getString(key) ?? 0;
    if(value != null){
      setState(() {
        tel = value.toString();
      });
    }
  }

  Widget drawEmptySubscriptionList() {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0,),
                  Text("Vous ne possedez pas de sous-cartes.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xff039BE5),)),
                  SizedBox(height: 5.0,),
                ]
            ),
          )
        )
    );
  }

  void _OwnerCardChanged(bool newValue) => setState(() {
    rememberMe = newValue;

    if (rememberMe) {
      print('vrai');

      Timer(Duration(seconds: 1),
              (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: EdgeInsets.only(top: 15, left: 20),
                    title: Text("Vous êtes sur le point de recharger la carte N°${cardOwner} Entrez le montant s'il vous plait", style: TextStyle(color: Colors.grey, fontSize: 15.0), ),
                    content: Form(
                      key: _amountFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: CustomTextField(
                                maxLength: 7,
                                hintText: 'Montant',
                                controller: _amountController,
                                emptyValidatorText: 'Entrer le montant',
                                keyboardType: TextInputType.number,
                                validator: _amountFieldValidator,
                                labelColor: Color(0xff039BE5)
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("ANNULER", style: TextStyle(color: Colors.red),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text("OK", style: TextStyle(color: Colors.red),),
                        onPressed: () {
                          if (_amountFormKey.currentState.validate()) {
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
      
      
    } else {
      print('faux');
      // TODO: Forget the user
    }
  });

  void _OwnerCardListChanged(bool newValue1) => setState(() {
    rememberMe1 = newValue1;

    if (rememberMe1) {
      print('vrai');

      Timer(Duration(seconds: 1),
              (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: EdgeInsets.only(top: 15, left: 20),
                    title: Text("Vous êtes sur le point de recharger la carte N°${cardOwner} Entrez le montant s'il vous plait", style: TextStyle(color: Colors.grey, fontSize: 15.0), ),
                    content: Form(
                      key: _amountFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: CustomTextField(
                                maxLength: 7,
                                hintText: 'Montant',
                                controller: _amountController,
                                emptyValidatorText: 'Entrer le montant',
                                keyboardType: TextInputType.number,
                                validator: _amountFieldValidator,
                                labelColor: Color(0xff039BE5)
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("ANNULER", style: TextStyle(color: Colors.red),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text("OK", style: TextStyle(color: Colors.red),),
                        onPressed: () {
                          if (_amountFormKey.currentState.validate()) {
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


    } else {
      print('faux');
      // TODO: Forget the user
    }
  });



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


  _check () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return
          DefaultAlertDialog(
            title: "Information",
            message: "Le Solde de votre compte ${cardOwner} est insuffisant",
            icon: Icon(Icons.cancel, color: Colors.red, size: 45,),
          );

      },
    );
  }

}