import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/sellingPointsDetails.dart';

class SellingPoints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("CENTRE", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),),
          ),
        ),

        ListTile(
          dense: true,
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute( builder: (context) => new SellingPointsDetails(
            town: "YAOUNDE",
            address: "Retrouvez nos commerciaux à CAMAIR ou rendez vous dans nos locaux",
            time: "Lundi-Vendredi: de 08h00 à 17h",
          ))),
          title: Text("YAOUNDE", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text("CAMAIR", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

        ListTile(
          dense: true,
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute( builder: (context) => new SellingPointsDetails(
            town: "YAOUNDE",
            address: "Retrouvez nos commerciaux à OMNISPORT ou rendez vous dans nos locaux",
            time: "Lundi-Vendredi: de 08h00 à 17h",
          ))),
          title: Text("YAOUNDE", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text("OMNISPORT", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

        ListTile(
          dense: true,
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute( builder: (context) => new SellingPointsDetails(
            town: "YAOUNDE",
            address: "Retrouvez nos commerciaux à SOA ou rendez vous dans nos locaux",
            time: "Lundi-Vendredi: de 08h00 à 17h",
          ))),
          title: Text("YAOUNDE", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text("SOA", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),


      ],
    );
  }
}