import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SmopayeShops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SMOPAYE SHOPS"),),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("Find all the products, offers and services in your nearest store", style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold))),
                  Image.asset('assets/images/name_carte.jpg', width: 100,)
                ],
              ),
            ),
          ),

          SizedBox(height: 3),

          ListTile(
            dense: true,
            onTap: (){Navigator.pushNamed(context, '/google_map');},
            leading: Icon(MdiIcons.navigation, color: Color(0xff039BE5), size: 40,),
            title: Text("Near", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Container(
            padding: EdgeInsets.only(left: 30, top: 5, bottom: 3),
            color: Color(0xff039BE5),
            child: SizedBox(child: Text("By Area", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), width: double.infinity)
          ),

          ListTile(
            dense: true,
            onTap: (){Navigator.pushNamed(context, '/agencies');},
            leading: Icon(Icons.location_on, color: Color(0xff039BE5), size: 40),
            title: Text("SMOPAYE agency", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
          ),

          Divider(color: Color(0xff039BE5), thickness: 2, height: 0,)



        ],
      ),
    );
  }
}