import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';

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
  var fullName = "";
  var state_compte = "";
  var amount_compte = "";
  var amount_unity = "";
  var amount_deposit = "";
  var phone = "";
  var etat = "";
  var id_card = "";
  var value_text = "";
  var formatter = new DateFormat.MMMM("en-US");
  var dayFormatter = new DateFormat.EEEE();
  String formattedDate = "";
  String formattedDay = "";

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
    //SharedPreferences localStorage = await SharedPreferences.getInstance();
    //localStorage.setString('user_profil', response);

    //var userJson = localStorage.getString('user_profil');
    //var valueResponse = json.decode(userJson);
    setState(() {
      userData = jsonDecode(response.body);
      phone = (userData["phone"]);

      //compte
      num_compte = (userData["compte"]["account_number"]);
      state_compte = (userData["compte"]["account_state"]);
      amount_compte = (userData["compte"]["amount"]).toString();
      //Abonnement
        if(userData["compte"]["compte_subscriptions"].isEmpty){
          abonnement = "Service";
        } else{
          abonnement = (userData["compte"]["compte_subscriptions"][0]["subscription_type"]).toLowerCase();
      }
      //card
      id_card = (userData["cards"][0]["id"]).toString();
      exp_date_card = (userData["cards"][0]["end_date"]);
      DateTime todayDate = DateTime.parse(exp_date_card);
      //print(todayDate);
      //print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
       formattedDate = formatter.format(todayDate);
       formattedDay = dayFormatter.format(todayDate);

      state_card = (userData["cards"][0]["card_state"]);
      //check Etat compte
      if(state_card == "activer"){
        _blockCard = false;
        etat = userData["state"];
      }else{
        _blockCard = true;
        etat = userData["state"];
        value_text = "Votre Carte est vérouillé.";
      }

      type_card = (userData["cards"][0]["type"]);
      num_card = (userData["cards"][0]["code_number"]);
      num_serie_card = (userData["cards"][0]["serial_number"]);
      amount_unity = (userData["cards"][0]["unity"]).toString();
      amount_deposit = (userData["cards"][0]["deposit"]).toString();

      //Particulier
      fullName = (userData["particulier"][0]["firstname"] + " " + userData["particulier"][0]["lastname"]).toUpperCase();

    });
    print("TTTTTTTTTTTTTTTTTTT $jsonDecode(response.body)");
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
    final now = new DateTime.now();
    return ListView(children: <Widget>[
      Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
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
          Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Container(
                      //padding: const EdgeInsets.all(15.0),
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
              )
          ),
          Container(
              //width: wv*50,
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border(left: BorderSide(width: 3.0, color: Colors.black45))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                //Icon(Icons.lock_outline, color: Colors.black45, size: 40),
                Row(
                  children: <Widget>[
                    Text("Mon Abonnement", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),),
                  ]
                ),
                Row(
                    children: <Widget>[
                      Column(
                          children: <Widget>[
                            Text("Service", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(height: 5.0,),
                            Text("+237 $phone", style: TextStyle(color: Color(0xff039BE5), fontSize: 12, fontWeight: FontWeight.bold),),
                          ]
                      ),
                      SizedBox(width: 40.0,),
                      Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: showBottomSheet,
                          textColor: Colors.white,
                          elevation: 5.0,
                          padding: const EdgeInsets.all(0.0),
                          color: Color(0xff039BE5),
                          child: Container(
                            padding: const EdgeInsets.all(0.0),
                            child: const Text(
                                'DETAILS',
                                style: TextStyle(fontSize: 15)
                            ),
                          ),
                        ),
                      ]
                      )
                    ],
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Mise à jour le ${now.day}/${now.month}/${now.year} à ${now.hour}:${now.minute}:${now.second}", style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),),
                  ],
                )
              ],)
          )
          
        ],),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("N°Compte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("$num_compte", style: TextStyle(color: Colors.black45, fontSize: 14)),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("N°Carte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(num_card, style: TextStyle(color: Colors.black45, fontSize: 14)),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("Date d'expiration de la carte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text("$formattedDay, ${now.day} ${formattedDate} ${now.year}", style: TextStyle(color: Colors.black45, fontSize: 14)),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 20,),
        title: Text("Verouiller la carte", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(
            (value_text=="") ? "Balancer ce bouton pour empêcher toute transaction venant d'elle" : value_text,
            style: TextStyle(color: Colors.black45, fontSize: 14)),
        trailing: Container(
          margin: EdgeInsets.only(right: 10),
          color: Color(0xff039BE5),
          child: Switch(
            activeColor: Colors.red,
            value: _blockCard, onChanged: (value){
              setState(() {
                _blockCard = value;
                print(_blockCard);
                //check Etat compte
                if(_blockCard == false){
                  etat = "activer";
                }else{
                  etat = "desactiver";
                }

                checkStateCardSmopayeServer(id_card, etat);
              });
              },
            ),
        ),
      ),
      SizedBox(height: 30)
    ],
    );
  }



  //BOTTOM SHEET MODAL DIALOG
  void showBottomSheet() => showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    barrierColor: Colors.orange.withOpacity(0.2),
    context: context,
    builder: (context) => ListView(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2.0, color: Colors.black12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0, top: 15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Voir les Détails", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        )
                    ),
                  ],),
              ),

              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2.0, color: Colors.black12))),
                child: Row(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            //padding: const EdgeInsets.all(15.0),
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
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(border: Border(left: BorderSide(width: 3.0, color: Colors.black45))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Mon Solde Restant", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                          Text("Compte: $amount_compte Fcfa", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                          Text("Unité: $amount_unity Fcfa", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                          Text("Dépot: $amount_deposit Fcfa", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                          Text("Mise à jour le ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} à ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}", style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                        ],)
                  )

                ],),
              ),

              Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2.0, color: Colors.black12))),
                  child: Column(
                    children: <Widget>[
                      Text("Espace Compte", style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      SizedBox(height: 2.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 50.0),
                        child:Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                  children: <Widget>[
                                    Column(
                                        children: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                Icon(Icons.account_circle, color: Colors.grey.shade400,),
                                                Text("N°COMPTE"),
                                              ]
                                          ),
                                          Text(num_compte, style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
                                        ]
                                    ),
                                    Column(
                                        children: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                Icon(Icons.check_circle, color: Colors.grey.shade400,),
                                                Text("Etat Compte"),
                                              ]
                                          ),
                                          Text(state_compte, style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
                                        ]
                                    ),
                                  ]
                              ),
                              Spacer(),
                              Column(
                                  children: <Widget>[
                                    Row(
                                        children: <Widget>[
                                          Text("Propriétaire"),
                                        ]
                                    ),
                                    Text(fullName, style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
                                  ]
                              )
                            ]
                        ),
                      )
                    ],
                  )
              ),
              Container(
                  child: Column(
                    children: <Widget>[
                      Text("Espace Carte", style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      SizedBox(height: 2.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 50.0),
                        child:Row(
                            children: <Widget>[
                              Column(
                                  children: <Widget>[
                                    Column(
                                        children: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                Icon(Icons.credit_card, color: Colors.grey.shade400,),
                                                Text("N°CARTE"),
                                              ]
                                          ),
                                          Text(num_card, style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
                                        ]
                                    ),
                                    Column(
                                        children: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                Icon(Icons.check_circle, color: Colors.grey.shade400,),
                                                Text("Etat Carte"),
                                              ]
                                          ),
                                          Text(state_card, style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
                                        ]
                                    ),
                                  ]
                              ),
                              Spacer(),
                              Column(
                                  children: <Widget>[
                                    Column(
                                        children: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                Text("N°Série Associé"),
                                              ]
                                          ),
                                          Text(num_serie_card, style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
                                        ]
                                    ),
                                    Column(
                                        children: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                Text("Type de Carte"),
                                              ]
                                          ),
                                          Text('Carte Magnétique $type_card', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
                                        ]
                                    ),
                                  ])
                            ]
                        ),
                      )
                    ],
                  )
              ),
          ],
        )
      ]
    ),
  );

  void checkStateCardSmopayeServer(String id, String etat) async{
    print(id);
    print(etat);
    dynamic response = await AuthService.etat_carte(card_id: id, card_state: etat);
    if(response.statusCode == 200){
      response = json.decode(response.body);
      print(response);
      if(response["message"] == "votre carte est desactiver")
        value_text = "Votre Carte est vérouillé.";
      else
        value_text = "";

    }  else{
      response = json.decode(response.body);
      print(response["message"]);
      _showDialog(response["message"]);
    }
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

//boite de dialog pour les erreurs
  void _showDialog(String response) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Information'),
            content: new Text(response),
            actions: <Widget>[
              new RaisedButton(onPressed: () {
                Navigator.of(context).pop();
              })
            ],
          );
        }
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
