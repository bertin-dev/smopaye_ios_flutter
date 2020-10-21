import 'package:flutter/material.dart';

import 'widgets/chatDiscussion.dart';

class OnlineSupport extends StatefulWidget {
  @override
  _OnlineSupportState createState() => _OnlineSupportState();
}

class _OnlineSupportState extends State<OnlineSupport> {

  TextEditingController searchController = new TextEditingController();

  var discussions = [
    {
      "name": "Silinga",
      "message": "Aidez moi svp !",
      "active": false
    },
    {
      "name": "Andrey",
      "message": "Aidez moi svp !",
      "active": false
    },
    {
      "name": "Charles",
      "message": "Aidez moi svp !",
      "active": true
    },
    {
      "name": "Kingue",
      "message": "Aidez moi svp !",
      "active": false
    },
    {
      "name": "Nsong",
      "message": "Aidez moi svp !",
      "active": true
    },
    {
      "name": "Atangana",
      "message": "Aidez moi svp !",
      "active": false
    },
  ];

  var filteredDiscussions = List();

  @override
  void initState() {
    filteredDiscussions.addAll(discussions);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final hv =MediaQuery.of(context).size.height/100;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff039BE5),
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
            bottom: TabBar(
              indicatorColor: Colors.red,
              labelColor: Colors.white,
              tabs: [
                Tab(text: "CHATS"),
                Tab(text: "UTILISATEUR"),
                Tab(text: "PROFILE")
              ],
            ),
            title: Row(
              children: <Widget>[
                CircleAvatar(backgroundImage: AssetImage('assets/images/carte.png'), radius: 15,),
                SizedBox(width: 5,),
                Expanded(child: Text('Remi Ghislain Dongmo Tsague', style: TextStyle(fontSize: 14))),
              ],
            ),
          ),
          body: TabBarView(
            children: [

              //CHATS

              ListView(children: <Widget>[
                ChatDiscussion(
                  name: "Silinga",
                  message: "Aidez moi !",
                  active: false,
                  open: (){},
                ),
                ChatDiscussion(
                  name: "Matomba",
                  message: "Besoin d'aide !",
                  active: true,
                  open: (){},
                ),
                ChatDiscussion(
                  name: "Souké Ibrahim",
                  message: "Ya quelqu'un ?",
                  active: false,
                  open: (){},
                ),
              ]),

              //UTILISATEUR

              Container(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value){filterSearchResults(value);},
                      decoration: InputDecoration(
                        hintText: "Rechercher"
                      ),
                      controller: searchController,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredDiscussions.length,
                      itemBuilder: (BuildContext context, int index){
                        return ChatDiscussion(
                          name: filteredDiscussions[index]["name"],
                          message: filteredDiscussions[index]["message"],
                          active: filteredDiscussions[index]["active"],
                          open: (){}
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 10)
                ],),
              ),

              //PROFILE

              ListView(
                children: <Widget>[
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("Profile", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Column(children: <Widget>[
                        CircleAvatar(backgroundImage: AssetImage('assets/images/carte.png'), radius: 50,),
                        SizedBox(height: hv*2),
                        Text("Prénom & Nom", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: hv*0.5),
                        Text("Remi Ghislain Dongmo Tsague", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontStyle: FontStyle.italic)),
                        SizedBox(height: hv*5),
                        Text("Téléphone", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: hv*0.5),
                        Text("698783117", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontStyle: FontStyle.italic)),
                        SizedBox(height: hv*5),
                        Text("No Compte", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: hv*0.5),
                        Text("FBBDCDBE", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontStyle: FontStyle.italic)),
                        SizedBox(height: hv*10), 
                      ],),
                    )
                  ],),
                ],
              ),
            ],
          ),
        ),
      );
  }
  void filterSearchResults(String query){
    var list = List();
    list.addAll(discussions);
    if (query.isNotEmpty){
      var listData = List();
      list.forEach((item) {
        if(item["name"].toLowerCase().contains(query.toLowerCase())){
          listData.add(item);
        }
      });
      setState(() {
        filteredDiscussions.clear();
        filteredDiscussions.addAll(listData);
      });
      return;
    }
    else {
      setState(() {
        filteredDiscussions.clear();
        filteredDiscussions.addAll(discussions);
      });
    }
  }
}