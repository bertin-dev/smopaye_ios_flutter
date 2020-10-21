import 'package:flutter/material.dart';

class Revenue extends StatefulWidget {
  @override
  _RevenueState createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {

  bool _showRevenue = false;

  @override
  Widget build(BuildContext context) {
    
    final hv =MediaQuery.of(context).size.height/100;
    final wv =MediaQuery.of(context).size.width/100;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(child: Text("Recette", style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == "moncompte") {
                Navigator.pushNamed(context, '/editAccount');
              }
              else if (value == "apropos") {
                Navigator.pushNamed(context, '/about');
              }
              else if (value == "tutoriel") {
                Navigator.pushNamed(context, '/tutorial');
              }
              
            },
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: "apropos",
                  child: Text("A propos"),
                ),
                PopupMenuItem(
                  value: "tutoriel",
                  child: Text("tutoriel"),
                ),
                PopupMenuItem(
                  value: "moncompte",
                  child: Text("Mon compte"),
                ),
              ],
        )
        ],
        ),
        body: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              SizedBox(height: hv*30,),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: _showRevenue ? ListView(shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(
                        height: hv*15,
                      ),
                      ListTile(
                        leading: Text("9 Juillet\n2019", style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        title: Center(child: Text("500 FCFA", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold))),
                        trailing: Text("20h30min", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontStyle: FontStyle.italic)),
                        ),
                        Divider(height: 0, thickness: 0.9,),
                      ListTile(
                        leading: Text("23 Juillet\n2019", style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        title: Center(child: Text("1000 FCFA", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold))),
                        trailing: Text("09h30min", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontStyle: FontStyle.italic)),
                        ),
                        Divider(height: 0, thickness: 0.9,),
                      ListTile(
                        leading: Text("9 Juillet\n2019", style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        title: Center(child: Text("500 FCFA", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold))),
                        trailing: Text("20h30min", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontStyle: FontStyle.italic)),
                        ),
                        Divider(height: 0, thickness: 0.9,),
                      ListTile(
                        leading: Text("9 Juillet\n2019", style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        title: Center(child: Text("500 FCFA", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold))),
                        trailing: Text("20h30min", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontStyle: FontStyle.italic)),
                        ),
                        Divider(height: 0, thickness: 0.9,),
                      ListTile(
                        leading: Text("9 Juillet\n2019", style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        title: Center(child: Text("500 FCFA", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold))),
                        trailing: Text("20h30min", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontStyle: FontStyle.italic)),
                        ),
                        Divider(height: 0, thickness: 0.9,),
                      ListTile(
                        leading: Text("9 Juillet\n2019", style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        title: Center(child: Text("500 FCFA", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold))),
                        trailing: Text("20h30min", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontStyle: FontStyle.italic)),
                        ),
                        Divider(height: 0, thickness: 0.9,),
                      ListTile(
                        leading: Text("9 Juillet\n2019", style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        title: Center(child: Text("500 FCFA", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold))),
                        trailing: Text("20h30min", style: TextStyle(fontSize: 18.0, color: Colors.black54, fontStyle: FontStyle.italic)),
                        ),
                        Divider(height: 0, thickness: 0.9,),
                  ],): Container(),
                ),
              )
            ],),
            Positioned(
              top: hv*18, right: wv*15,
              child: Container(
                padding: EdgeInsets.all(15), width: wv*70,
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow( 
                    color: Colors.black45.withOpacity(0.1),
                    offset: new Offset(1.0, 1.0),
                    blurRadius: 5.0,
                    spreadRadius: 5.0)
                ],
                ),
                  child: Column(children: <Widget>[
                    Text("Montant accumulé", style: TextStyle(fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.bold)), 
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                      color: Color(0xff039BE5),
                      borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("20 000 fcfa", style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                  ],),
                ),
            ),
          ],
        ),
         floatingActionButton: FloatingActionButton(onPressed: _show,
        child: Icon(Icons.assignment),
        backgroundColor: Color(0xff039BE5),
        ) ,
      ),
    );
  }

  _show(){
    setState(() {
      _showRevenue = !_showRevenue;
    });
  }
}