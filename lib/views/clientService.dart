import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ClientService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assistance"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info), onPressed: (){Navigator.pushNamed(context, '/assistance');})
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Color(0xff039BE5),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("We welcome you 7 days a week, 24 hours a day", style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold))),
                  Image.asset('assets/images/name_carte.jpg', width: 100,)
                ],
              ),
            ),
          ),

          ListTile(
            dense: true,
            onTap: (){Navigator.pushNamed(context, '/generalPublic');},
            leading: Icon(MdiIcons.faceAgent, color: Color(0xff039BE5), size: 40,),
            title: Text("General public", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

          ListTile(
            dense: true,
            onTap: (){Navigator.pushNamed(context, '/facebook');},
            leading: Icon(MdiIcons.facebookBox, color: Color(0xff039BE5), size: 40),
            title: Text("Facebook", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

          ListTile(
            dense: true,
            onTap: (){Navigator.pushNamed(context, '/twitter');},
            leading: Icon(MdiIcons.twitterBox, color: Color(0xff039BE5), size: 40),
            title: Text("Twitter", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),


        ],
      ),
    );
  }
}