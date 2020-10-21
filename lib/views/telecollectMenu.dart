import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'widgets/alertDialogs/defaultDialog.dart';
import 'widgets/appBar.dart';

class TeleCollectMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Menu des retraits",),
      body: Column(
        children: <Widget>[
          SizedBox(height: 7,),
          ListTile(
            onTap: (){Navigator.pushNamed(context, '/withraw');},
            leading: Icon(MdiIcons.codeGreaterThan, color: Colors.black54, size: 30,),
            title: Text("Faire un retrait", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0),

          ListTile(
            onTap: () async {_telecollect(context);},
            leading: Icon(MdiIcons.codeLessThan, color: Colors.black54, size: 30,),
            title: Text("Faire une télécollecte", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0),
        ],
      ),
    );
  }

  _telecollect (BuildContext context) async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return 
            DefaultAlertDialog(
              title: "Information",
              message: "Désolé votre recette accumulée doit dépasser 300 fcfa pour effectuer cette opération.",
              icon: Icon(Icons.cancel, color: Colors.red, size: 45,),
            );
            
          },
        );
      }
}