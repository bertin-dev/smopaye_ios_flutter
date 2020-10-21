import 'package:flutter/material.dart';

class LegalInformations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informations légales"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info), onPressed: (){Navigator.pushNamed(context, '/assistance');})
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 15),
              child: Text("Editeur", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            Text("SYSTEME MULTI-SERVICES D'OFFRES DE PAIEMENT ELECTRONIQUE Société A responsabilité Limité au capital de 5 000 000 FCFA dont le siège Social est situé au Centre Commercial, Rue 1.075 Montée Anne Rouge, B.P. 14736 Yaoundé inscrite au régistre du commerce et de credit Mobilier (RCCM) du tribunal de premier instance de la ville de Yaoundé sous le numéro RC/YAO/2018/B/820, Numéro de contribuable M121812732687J",
              style: TextStyle(fontSize: 14, color: Colors.black45)),
            
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text("Hebergeur", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            Text("Google\nPlay Store",style: TextStyle(fontSize: 14, color: Colors.black45)),

            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text("Nous Contacter", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            Text("Pour toute information sur l'application E-ZPASS by SMOPAYE, contactez le service client à l'adresse suivante: Support@smopaye.cm",
              style: TextStyle(fontSize: 14, color: Colors.black45)),
          ]
        ),
      ),
    );
  }
}