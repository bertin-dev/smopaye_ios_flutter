import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';

class ManageAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Retrait et Télécollecte"),
      body: ListView(
        children: <Widget>[

          SizedBox(height: 10),

          ListTile(
            onTap: (){Navigator.pushNamed(context, '/manageAcceptor');},
            leading: Icon(MdiIcons.accountTie, color: Colors.black54, size: 35,),
            title: Text("Gestion Accepteur", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

          ListTile(
            onTap: (){Navigator.pushNamed(context, '/manageUser');},
            leading: Icon(MdiIcons.accountMultiple, color: Colors.black54, size: 35),
            title: Text("Gestion Agent et utilisateur", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),



        ],
      ),
    );
  }
}