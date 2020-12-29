
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/renewSubscription.dart';
import 'package:smopaye_mobile/views/transfer.dart';

import 'toggleUnitDeposit.dart';
import 'listSubscription.dart';

class MenuTransfer extends StatelessWidget {



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
                  Navigator.pushNamed(context, '/editAccount');
                }
                else if (value == "apropos") {
                  Navigator.pushNamed(context, '/about');
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
              Tab(icon: Icon(Icons.import_export), text: "TRANSFERT"),
              Tab(icon: Icon(Icons.autorenew), text: "BASCULER")
            ],
          ),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Transfert", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Text("E-ZPASS by SMOPAYE", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.left,),
              ]
          ),
        ),
        body: TabBarView(children: [
          Transfer(),
          ToggleUnitDeposit(),
        ]),
      ),
    );
  }
}
