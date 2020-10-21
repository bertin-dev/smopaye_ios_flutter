import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/dataUser.dart';
import 'package:smopaye_mobile/models/particulier.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/services/secureStorage.dart';
import 'package:smopaye_mobile/views/account.dart';
import 'package:smopaye_mobile/views/introViews.dart';
import 'package:smopaye_mobile/views/notifications.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';
import 'home.dart';
import 'sellingPoints.dart';


class AppBottomNavigation extends StatefulWidget {

  final String tel;

  AppBottomNavigation(this.tel);

  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState(this.tel);
}

dynamic getUserProfil({ @required String phone}) async{
  var response = await AuthService.profilUser(phone: phone);

  //fullname = "pipo";
  //role = response["role"]["name"];
  //categorie = response["categorie"]["name"];
  //telephone = response["phone"];

  //print(response);
  Map<String, dynamic> map = response;
  List<dynamic> data = map["particulier"];
  //print(data[0]["lastname"]);

  //AuthService.saveProfilUser(json.encode(response));
  //print(AuthService.readProfilUser());


  //return jsonResponse.map((datauser) => new DataUser.fromJson(datauser)).toList();
  return response;

  /*List<DataUser> users = [];
    for(var user in response){
      DataUser dataUser = DataUser(
          user["id"],
          user["phone"],
          user["address"],
          user["category_id"],
          user["state"],
          user["parent_id"],
          user["created_by"],
          user["compte_id"],
          user["role_id"],
          user["created_at"],
          user["updated_at"]);
      users.add(dataUser);
    }
    return users;*/
}


class _AppBottomNavigationState extends State<AppBottomNavigation> {
  String appBarMenuValue;
  String _appBarText = "Accueil";
  int selectedIndex = 0;

  /* élements à utiliser */
  String myTel = "";
  String fullname = "";

  /*String fullname = "pipo";
  String role = responses["role"]["name"];
  String categorie = responses["categorie"]["name"];
  String telephone = responses["phone"];*/

  _AppBottomNavigationState(String tel){
    myTel = tel;
    print("00000000000000000000000000 " + myTel);
  }


  /* ---------FIN ----------------*/

  final widgetOptions = [
    Home(),
    AccountDetails(),
    SellingPoints(),
    Notifications()
  ];

  get goToLogin => null;

  Future<String> readToken() async {
    final _storage = new FlutterSecureStorage();
    var value = await _storage.read(key: "access");
    return value;
  }

  @override
  Widget build(BuildContext context) {

    /*dynamic resp = getUserProfil(phone: "694048924");
    print(resp["categorie"]["name"].toString());
    print("111111111111111" + categorie);*/

    final wv =MediaQuery.of(context).size.width/100;
    return Scaffold(
      appBar: DefaultAppBar(title:_appBarText),

      drawer: Container(width: wv*70,
        child: Drawer(
          child: FutureBuilder(
            future: getUserProfil(phone: myTel),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(child: Center(child: Text("Chargement..."),),);
              } else{
                return ListView(children: <Widget>[
                  DrawerHeader(
                      padding: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(color: Color(0xff039BE5)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 12.0),
                          leading: Icon(Icons.account_circle, size: 70, color: Colors.white,),
                          title: Text(snapshot.data["role"]["name"], style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),),
                          subtitle: Text(snapshot.data["particulier"][0]["lastname"]+ " " + snapshot.data["particulier"][0]["firstname"], style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.w600),),
                        ),
                      )
                  ),
                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/offers');},
                    dense: true,contentPadding: EdgeInsets.only(left: 16.0, right: 0.0),
                    leading: Icon(Icons.work),
                    title: Text('Offres SMOPAYE'),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/website');},
                    dense: true,
                    leading: Icon(Icons.public),
                    title: Text('Site Web'),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/transfer');},
                    dense: true,
                    leading: Icon(Icons.swap_vert),
                    title: Text('Transfert'),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/renewSubscription');},
                    dense: true,
                    leading: Icon(Icons.play_circle_filled),
                    title: Text('Renouveler Abonnement'),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/online');},
                    dense: true,
                    leading: Icon(Icons.chat),
                    title: Text('Assistance en Ligne'),
                  ),

                  Divider(thickness: 1,),

                  ListTile(
                    dense: true,
                    leading: Text('Provisoires', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/revenue');},
                    dense: true,
                    leading: Icon(Icons.chat),
                    title: Text('Recette'),
                  ),
                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/manageAccounts');},
                    dense: true,
                    leading: Icon(Icons.chat),
                    title: Text('Gestion comptes'),
                  ),
                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/telecollectMenu');},
                    dense: true,
                    leading: Icon(Icons.chat),
                    title: Text('Retraît et télécollecte'),
                  ),

                  Divider(thickness: 1,),

                  ListTile(
                    dense: true,
                    leading: Text('Autres', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                  ),

                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: Icon(Icons.settings),
                    title: Text('Paramètres'),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/home');},
                    dense: true,
                    leading: Icon(Icons.share),
                    title: Text('Inviter des amis'),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/home');},
                    dense: true,
                    leading: Icon(Icons.star_border),
                    title: Text('Notez l\'application E-ZPASS'),
                  ),

                  ListTile(
                    onTap: (){Navigator.pushNamed(context, '/home');},
                    dense: true,
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Déconnexion'),
                  ),
                  SizedBox(height: 10)
                ],

                );
              }
            },
          ),
        ),
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.1),
                offset: new Offset(1.0, 1.0),
                blurRadius: 5.0,
                spreadRadius: 5.0)
            ],
            ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Accueil', style: TextStyle(fontSize: 12.0),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card), title: Text('Mon compte', style: TextStyle(fontSize: 12.0))),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), title: Text('Point Smopaye', style: TextStyle(fontSize: 12.0))),
            BottomNavigationBarItem(
            icon: Icon(Icons.notifications), title: Text('Notifications', style: TextStyle(fontSize: 12.0))),
          ],
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Color(0xff039BE5),
          unselectedItemColor: Colors.black45,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if(index == 0) {
      setState(() {
        _appBarText = "Accueil";
      });
    }
    else if(index == 1) {
      setState(() {
        _appBarText = "Ma carte Smopaye";
      });
    }
    else if(index == 2) {
      setState(() {
        _appBarText = "Points de vente Smopaye";
      });
    }
    else if(index == 3) {
      setState(() {
        _appBarText = "Notifications";
      });
    }

  }



  /*loadingProfilUser(String tel) async {
    dynamic response = await AuthService.profilUser(phone: tel);
    response = json.decode(response.data);
    print(response["categorie"]["name"]);

     fullname = "pipo";
     role = response["role"]["name"];
     categorie = response["categorie"]["name"];
     telephone = response["phone"];

     print("1----- $role");
    List<DataUser> users = [];

    for(var user in json.decode(response)){
      DataUser dataUser = DataUser(
          user["id"],
          user["phone"],
          user["address"],
          user["category_id"],
          user["state"],
          user["parent_id"],
          user["created_by"],
          user["compte_id"],
          user["role_id"],
          user["created_at"],
          user["updated_at"],
          user["categorie"]);
      users.add(dataUser);
    }
    print(users);
  }*/
  
}