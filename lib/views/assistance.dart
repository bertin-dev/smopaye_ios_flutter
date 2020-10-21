import 'package:flutter/material.dart';

class Assistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Assistance"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 20,),
              ListTile(
                title: Text("Chatter avec un expert SMOPAYE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: FlatButton(
                    child: Text("ASSISTANCE EN LIGNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), 
                    color: Color(0xff039BE5),
                    onPressed: (){Navigator.pushNamed(context, '/clientService');},),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.asset('assets/images/name_carte.jpg', width: 100,),
                ),
              ),

              SizedBox(height: 50),

              ListTile(

                title: Text("Contactez Nous", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: FlatButton(
                    splashColor: Color(0xff039BE5),
                    child: Text("SERVICE CLIENT SMOPAYE", style: TextStyle(fontWeight: FontWeight.bold),), 
                    color: Colors.white,
                    shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                    onPressed: (){Navigator.pushNamed(context, '/clientService');},),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.asset('assets/images/name_carte.jpg', width: 100,),
                ),
              ),

              SizedBox(height: 50),

              ListTile(
                title: Text("Retrouvez tous les produits, offres et services dans les boutiques Smopaye", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: FlatButton(
                    splashColor: Color(0xff039BE5),
                    child: Text("BOUTIQUES SMOPAYE", style: TextStyle(fontWeight: FontWeight.bold),), 
                    color: Colors.white,
                    shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                    onPressed: (){Navigator.pushNamed(context, '/shops');},),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.asset('assets/images/name_carte.jpg', width: 100,),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}