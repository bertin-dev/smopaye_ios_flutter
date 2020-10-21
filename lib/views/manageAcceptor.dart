import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManageAcceptor extends StatefulWidget {
  @override
  _ManageAcceptorState createState() => _ManageAcceptorState();
}

class _ManageAcceptorState extends State<ManageAcceptor> {
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
            title: Center(child: Text("Gestion Accepteur", style: TextStyle(fontSize: 25.0))),
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
                    child: ListView(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height: 80),

                            ListTile(
                              onTap: (){},
                              leading: Icon(MdiIcons.accountTie, color: Colors.black54, size: 35,),
                              title: Text("Liste des Accepteurs", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
                              trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
                            ),

                            Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

                            ListTile(
                              onTap: (){},
                              leading: Icon(Icons.assignment, color: Colors.black54, size: 35),
                              title: Text("Modifier un Accepteur", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
                              trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
                            ),

                            Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

                            ListTile(
                              onTap: (){},
                              leading: Icon(MdiIcons.delete, color: Colors.black54, size: 35),
                              title: Text("Supprimer un Accepteur", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
                              trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
                            ),

                            Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),



                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],),
              Positioned(
                top: hv*10, right: wv*10,
                child: Container(
                  padding: EdgeInsets.all(20), width: wv*80,
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
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Nombre Accepteur", style: TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold)),
                          Container(
                            width: 80,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                            color: Color(0xff039BE5),
                            borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text("100", style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            )
                        ],
                      ),
                      SizedBox(height: 8), 
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Accepteur Actif", style: TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold)),
                          Container(
                            width: 80,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text("100", style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            )
                        ],
                      ),
                      SizedBox(height: 8), 
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Accepteur Inactif", style: TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold)),
                          Container(
                            width: 80,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text("23", style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            )
                        ],
                      ),  
                      
                    ],),
                  ),
              ),
            ],
          ),
        ),
    );
  }
}