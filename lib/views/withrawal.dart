import 'package:flutter/material.dart';

import 'widgets/CustomListTile.dart';
import 'widgets/appBar.dart';

class Withrawal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Menu des retraits",),
      body: Column(
        children: <Widget>[
          
          CustomListTile(
            title: "Retrait à Smopaye",
            icon: Icon(Icons.arrow_forward, color: Color(0xff039BE5), size: 30,),
            onTap: (){Navigator.pushNamed(context, '/withrawSmopaye');},
          ),

          CustomListTile(
            title: "Retrait par un opérateur",
            icon: Icon(Icons.arrow_forward, color: Color(0xff039BE5), size: 30,),
            onTap: (){Navigator.pushNamed(context, '/withrawOperator');},
          ),

        ],
      ),
    );
  }
}