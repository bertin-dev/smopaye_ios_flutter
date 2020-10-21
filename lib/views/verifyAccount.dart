import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';

import 'widgets/cardInfo.dart';
import 'widgets/form/button.dart';
import 'widgets/instructionCard.dart';

class VerifyAccount extends StatefulWidget {
  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  bool _cardSwipped = false;
  String _accountNumber = "BDAADA51", _subscriptionType = "service", _expiryDate = "Saturday, 6 November 2020";

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    
    return Scaffold(
      appBar: DefaultAppBar(title: "Numéro de compte"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          SizedBox(height: hv*2,),
          InstructionCard(text: "Insérez votre numéro de carte puis glissez la carte",),
          SizedBox(height: hv*2,),
          _cardSwipped == false ?
          SizedBox(height: hv*15,)
          : Column(
            children: <Widget>[
              SizedBox(height: hv*5,),
              CardInfo(label: "Votre numéro de compte est :", info: _accountNumber,),
              SizedBox(height: hv*3,),
              CardInfo(label: "Votre Abonnement :", info: _subscriptionType,),
              SizedBox(height: hv*3,),
              CardInfo(label: "Date d'expiration de la carte :", info: _expiryDate,),
              SizedBox(height: hv*5,),
            ]
          )
          ,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: CustomButton(
              color: Color(0xff039BE5), text: 'Passer la Carte', textColor: Colors.white,
              onPressed: _getCard,
            ),
          ),

          SizedBox(height: hv*5,)
        ],),
      ),
    );
  }

  _getCard () {
    setState(() {
      _cardSwipped = true;
    });
  }

}