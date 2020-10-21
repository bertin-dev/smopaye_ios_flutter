import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';

import 'widgets/CustomListTile.dart';

class Historic extends StatefulWidget {
  @override
  _HistoricState createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Historique de Transactions"),
      body: Column(
        children: <Widget>[

          CustomListTile(
            title: "Recharge",
            icon: Icon(Icons.arrow_forward, color: Color(0xff039BE5), size: 30,),
            onTap: (){Navigator.pushNamed(context, '/refillHistory');},
          ),

          CustomListTile(
            title: "Télécollecte",
            icon: Icon(Icons.arrow_forward, color: Color(0xff039BE5), size: 30,),
            onTap: (){Navigator.pushNamed(context, '/telecollectHistory');},
          ),

          CustomListTile(
            title: "Débit",
            icon: Icon(Icons.arrow_forward, color: Color(0xff039BE5), size: 30,),
            onTap: (){Navigator.pushNamed(context, '/debitHistory');},
          ),

          CustomListTile(
            title: "Transfert",
            icon: Icon(Icons.arrow_forward, color: Color(0xff039BE5), size: 30,),
            onTap: (){Navigator.pushNamed(context, '/transferHistory');},
          ),


        ],
      ),
    );
  }
}