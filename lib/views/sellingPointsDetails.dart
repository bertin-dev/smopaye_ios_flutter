import 'package:flutter/material.dart';

class SellingPointsDetails extends StatelessWidget {
  final String town;
  final String address;
  final String time;

  const SellingPointsDetails({Key key, this.town, this.address, this.time}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15,),
                  Image.asset("assets/images/logo_smopaye2.png", width: 100),
                  SizedBox(width: 15,),
                  Text(town, style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25, top: 10),
            title: Text("Adresse", style: TextStyle(color: Colors.black87, fontSize: 21, fontWeight: FontWeight.bold)),
            subtitle: Text(address, style: TextStyle(color: Colors.black45, fontSize: 16)),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25, top: 5),
            title: Text("Horaires d'ouverture", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(time, style: TextStyle(color: Colors.black45, fontSize: 16))
          ),
        ],
      ),
    );
  }
}