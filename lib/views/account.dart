import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool _blockCard = false;
  var userData;
  var abonnement = "";
  var num_compte = "";
  var exp_date_card = "";
  var state_card = "";
  var num_card = "";
  var type_card = "";
  var num_serie_card = "";

  @override
  void initState() {
    readPhone();
    super.initState();
  }

  readPhone() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.get(key) ?? 0;
    if(value != null){
      _getUserProfil(value);
    }

  }

  void _getUserProfil(String telephone) async {
    var response = await AuthService.profilUser(phone: telephone);
    response = json.encode(response);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user_profil', response);

    var userJson = localStorage.getString('user_profil');
    var valueResponse = json.decode(userJson);
    setState(() {
      userData = valueResponse;
      abonnement = (userData["role"]["name"]).toLowerCase();
      num_compte = (userData["compte"]["account_number"]);
      //card
      exp_date_card = (userData["cards"][0]["end_date"]);
      state_card = (userData["cards"][0]["card_state"]);
      type_card = (userData["cards"][0]["type"]);
      num_card = (userData["cards"][0]["code_number"]);
      num_serie_card = (userData["cards"][0]["serial_number"]);

    });
    print("TTTTTTTTTTTTTTTTTTT $valueResponse");
  }


  int _currentIndex=0;
  List cardList=[
    Item1(),
    Item2(),
    Item3(),
    Item4(),
    Item5()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final wv =MediaQuery.of(context).size.width/100;
    return ListView(children: <Widget>[
      Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: cardList.map((card){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        //color: Colors.blueAccent,
                        child: card,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(cardList, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }),
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 15.0, color: Colors.black12))),
        child: Row(children: <Widget>[
          Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              //image: NetworkImage("https://i.imgur.com/BoN9kdC.png")
                            image: AssetImage('assets/images/pub_ezpass.jpg'),
                          )
                      )),
                ],
              )),
          Container(
            padding: EdgeInsets.all(10),
            width: wv*50,
            decoration: BoxDecoration(border: Border(left: BorderSide(width: 3.0, color: Colors.black45))),
            child: Column(children: <Widget>[
              Icon(Icons.lock_outline, color: Colors.black45, size: 40),
              Text("Utiliser un autre Compte")
            ],)
          ),
          
        ],),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("N Compte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("$num_compte", style: TextStyle(color: Colors.black45, fontSize: 14)),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("Type de carte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Carte magnétique $type_card", style: TextStyle(color: Colors.black45, fontSize: 14)),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("Abonnement choisis", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("service", style: TextStyle(color: Colors.black45, fontSize: 14)),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("Date d'expiration de la carte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("$exp_date_card", style: TextStyle(color: Colors.black45, fontSize: 14)),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("Verouiller la carte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("Balancer ce bouton pour empêcher toute transaction venant d'elle", style: TextStyle(color: Colors.black45, fontSize: 14)),
        trailing: Container(
          margin: EdgeInsets.only(right: 10),
          color: Color(0xff039BE5),
          child: Switch(
            activeColor: Colors.red,
            value: _blockCard, onChanged: (value){setState(() {_blockCard = value;});},
            ),
        ),
      ),
      SizedBox(height: 30)
    ],
    );
  }
}




class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),*/
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pub_distributor.jpg',
            height: 180.0,
            fit: BoxFit.cover,
          ),
          /*Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),*/
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),*/
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pub_qrcode.jpg',
            height: 180.0,
            fit: BoxFit.cover,
          ),
         /* Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),*/
        ],
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),*/
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/card.png',
            height: 180.0,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pub_kiosk.jpg',
            height: 180.0,
            fit: BoxFit.cover,
          ),
          /*Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),*/
        ],
      ),
    );
  }
}

class Item5 extends StatelessWidget {
  const Item5({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pub_parasol.jpg',
            height: 180.0,
            fit: BoxFit.cover,
          ),
          /*Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),*/
        ],
      ),
    );
  }
}