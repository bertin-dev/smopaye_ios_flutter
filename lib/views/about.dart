import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A propos de SMOPAYE"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info), onPressed: (){Navigator.pushNamed(context, '/assistance');})
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset("assets/images/bg_propos.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("SMOPAYE MOBILE", style: TextStyle(color: Colors.black87, fontSize: 23, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("1.2.6", style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600)),

                    Text("propriété SMOPAYE. Tous droits réservés.", style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    

                  ],
                ),
              ),
              InkWell(onTap: (){Navigator.pushNamed(context, '/legal');},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Text("Information légales", style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600))
                  ),
              ),
              Divider(height: 0, thickness: 1)
          ],),
        ],
      ),
    );
  }
}