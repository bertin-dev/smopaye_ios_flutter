import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/qrPay.dart';
import 'package:smopaye_mobile/views/qrScan.dart';

import 'widgets/appBar.dart';

class QrCode extends StatelessWidget {
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
                if (value == "moncompte") {
                  Navigator.pushNamed(context, '/editAccount');
                }
                else if (value == "apropos") {
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
                  PopupMenuItem(
                    value: "moncompte",
                    child: Text("Mon compte"),
                  ),
                ],
          )
          ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: [
                  Tab(text: "SCANNER"),
                  Tab(text: "MON CODE")
                ],
              ),
              title: Text('Accueil QR Code'),
            ),
            body: TabBarView(children: [
              QRScan(),
              QRPay(),
            ]),
          ),
        );
  }
}