import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/reloadAccount.dart';
import 'listAllCards.dart';

class MenuReloadAccount extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff039BE5),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == "apropos") {
                  Navigator.pushNamed(context, '/about');
                }
                else if (value == "tutoriel") {
                  Navigator.pushNamed(context, '/tutorial');
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
              ],
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.account_balance), text: "MON COMPTE"),
              Tab(icon: Icon(Icons.credit_card_outlined), text: "MES CARTES")
            ],
          ),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recharge", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Text("E-ZPASS by SMOPAYE", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.left,),
              ]
          ),
        ),
        body: TabBarView(children: [
          ReloadAccount(),
          ListAllCards(),
        ]),
      ),
    );
  }
}