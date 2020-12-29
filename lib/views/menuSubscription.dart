
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/renewSubscription.dart';

import 'listSubscription.dart';

class MenuSubscription extends StatelessWidget {



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
              Tab(text: "ABONNEMENT ENCOURS"),
              Tab(text: "RENOUVELER ABONNEMENT")
            ],
          ),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Abonnement", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Text("E-ZPASS by SMOPAYE", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.left,),
              ]
          ),
        ),
        body: TabBarView(children: [
          ListSubscription(),
          RenewSubscription(),
        ]),
      ),
    );
  }
}
