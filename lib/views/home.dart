import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/services/authService2.dart';
import 'package:smopaye_mobile/views/widgets/homeCommands.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var userData;
  var role = "";
  var etat = "";
  var _isVisible;
  AuthService2 authService2;

  @override
  void initState() {
    _isVisible = false;
    authService2 = AuthService2();
    authService2.fetchAllProfilUser();

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
    var value = json.decode(userJson);
    setState(() {
      userData = value;
      role = (userData["role"]["name"]).toLowerCase();
      etat = (userData["state"]).toLowerCase();

      if(role == "administrateur" || role == "agent"){
        _isVisible = true;
      }

    });
    print("TTTTTTTTTTTTTTTTTTT $value");
  }

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final now = new DateTime.now();
    var formatter = new DateFormat.MMMM("en-US");
    var dayFormatter = new DateFormat.EEEE();
    String formattedDate = formatter.format(now);
    String formattedDay = dayFormatter.format(now);

    return Scaffold(
      
      body: ListView(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            )
          ),
          child: SizedBox(height: hv*25,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        userData != null ? '${userData["role"]["name"]}' : '',
                        style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(
                        userData != null ? '${userData["categorie"]["name"]}' : '',
                        style: TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0, right: 25.0),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${now.day}", style: TextStyle(fontSize: 90.0, color: Colors.white, fontWeight: FontWeight.bold)),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text("$formattedDay", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold)),
                        Text("$formattedDate ${now.year}", style: TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              )
            ],),
          )
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow( 
                color: Colors.black45.withOpacity(0.1),
                offset: new Offset(1.0, 1.0),
                blurRadius: 5.0,
                spreadRadius: 5.0)
            ],
            ),
          margin: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0, right: 10.0, bottom: 15.0),
              child: Container(padding: EdgeInsets.only(right: 30.0, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 3.0, color: Colors.black45))
                ),
                child: Image.asset('assets/images/search.png', width: 50,)),
            ),
            //SizedBox(width: 2.0, height: hv,),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text("Consulter l'Historique de vos transactions effectueés."),
                ),
                SizedBox(height: 10.0,),
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: (){Navigator.pushNamed(context, '/historic');}, color: Color(0xff039BE5), 
                  child: Text("CONSULTER", style: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold)))
              ],),
            )
          ],),
        ),


        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            if(role != null)...{
              if (role == "accepteur")...{

            if(etat == "activer")...{
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Retrait",
                      function: () {
                        Navigator.pushNamed(context, '/withraw');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "Payer vos Factures",
                      function: () {
                        Navigator.pushNamed(context, '/payInvoice');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "Verification",
                      function: () {
                        Navigator.pushNamed(context, '/verifyAccount');
                      },
                      icon: Icon(MdiIcons.creditCard, color: Color(
                          0xff039BE5), size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Recharge Comptes",
                      function: () {
                        Navigator.pushNamed(context, '/reload');
                      },
                      icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                        size: 35.0,)
                  ),
                ],),
              ),
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Debit Carte",
                      function: () {
                        Navigator.pushNamed(context, '/debit');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/debit_carte_icon.png', width: 35.0,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "QR Code",
                      function: () {
                        Navigator.pushNamed(context, '/qr');
                      },
                      icon: Icon(MdiIcons.qrcodeScan, color: Color(
                          0xff039BE5), size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Consulter Solde",
                      function: () {
                        Navigator.pushNamed(context, '/check');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/layer11.png', width: 35,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "Consulter Recette",
                      function: () {
                        Navigator.pushNamed(context, '/revenue');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/recette.png', width: 35,
                        height: 35.0,))
                  ),
                ],),
              ),
            } else...{
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Recharge Comptes",
                      function: () {
                        Navigator.pushNamed(context, '/reload');
                      },
                      icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                        size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Payer vos Factures",
                      function: () {
                        Navigator.pushNamed(context, '/payInvoice');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                ],),
              ),
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Consulter Solde",
                      function: () {
                        Navigator.pushNamed(context, '/check');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/layer11.png', width: 35,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "QR Code",
                      function: () {
                        Navigator.pushNamed(context, '/qr');
                      },
                      icon: Icon(MdiIcons.qrcodeScan, color: Color(
                          0xff039BE5), size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Faire un Retrait",
                      function: () {
                        Navigator.pushNamed(context, '/withraw');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                ],),
              ),
            }

              }
              else if(role == "agent")...{

            if(etat == "activer")...{
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Verification",
                      function: () {
                        Navigator.pushNamed(context, '/verifyAccount');
                      },
                      icon: Icon(MdiIcons.creditCard, color: Color(
                          0xff039BE5), size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Payer vos Factures",
                      function: () {
                        Navigator.pushNamed(context, '/payInvoice');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "Consulter Solde",
                      function: () {
                        Navigator.pushNamed(context, '/check');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/layer11.png', width: 35,
                        height: 35.0,))
                  ),
                ],),
              ),
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Recharge Comptes",
                      function: () {
                        Navigator.pushNamed(context, '/reload');
                      },
                      icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                        size: 35.0,)
                  ),
                  HomeCommands(
                      label: "QR Code",
                      function: () {
                        Navigator.pushNamed(context, '/qr');
                      },
                      icon: Icon(MdiIcons.qrcodeScan, color: Color(
                          0xff039BE5), size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Faire un Retrait",
                      function: () {
                        Navigator.pushNamed(context, '/withraw');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                ],),
              ),
            }else...{
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Recharge Comptes",
                      function: () {
                        Navigator.pushNamed(context, '/reload');
                      },
                      icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                        size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Payer vos Factures",
                      function: () {
                        Navigator.pushNamed(context, '/payInvoice');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                ],),
              ),
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Consulter Solde",
                      function: () {
                        Navigator.pushNamed(context, '/check');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/layer11.png', width: 35,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "QR Code",
                      function: () {
                        Navigator.pushNamed(context, '/qr');
                      },
                      icon: Icon(MdiIcons.qrcodeScan, color: Color(
                          0xff039BE5), size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Faire un Retrait",
                      function: () {
                        Navigator.pushNamed(context, '/withraw');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                ],),
              ),
            }
                }
              else if(role == "utilisateur")...{
                  Expanded(
                    child: Column(children: <Widget>[
                      HomeCommands(
                          label: "Recharge Comptes",
                          function: () {
                            Navigator.pushNamed(context, '/reload');
                          },
                          icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                            size: 35.0,)
                      ),
                      HomeCommands(
                          label: "Payer vos Factures",
                          function: () {
                            Navigator.pushNamed(context, '/payInvoice');
                          },
                          icon: SizedBox(child: Image.asset(
                            'assets/images/reception.png', width: 35.0,
                            height: 35.0,))
                      ),
                    ],),
                  ),
                  Expanded(
                    child: Column(children: <Widget>[
                      HomeCommands(
                          label: "Consulter Solde",
                          function: () {
                            Navigator.pushNamed(context, '/check');
                          },
                          icon: SizedBox(child: Image.asset(
                            'assets/images/layer11.png', width: 35,
                            height: 35.0,))
                      ),
                      HomeCommands(
                          label: "QR Code",
                          function: () {
                            Navigator.pushNamed(context, '/qr');
                          },
                          icon: Icon(MdiIcons.qrcodeScan, color: Color(
                              0xff039BE5), size: 35.0,)
                      ),
                      HomeCommands(
                          label: "Faire un Retrait",
                          function: () {
                            Navigator.pushNamed(context, '/withraw');
                          },
                          icon: SizedBox(child: Image.asset(
                            'assets/images/reception.png', width: 35.0,
                            height: 35.0,))
                      ),
                    ],),
                  ),
                }
              else if(role == "administrateur")...{

                if(etat == "activer")...{
                    Expanded(
                      child: Column(children: <Widget>[

                        HomeCommands(
                            label: "Recharge Comptes",
                            function: () {
                              Navigator.pushNamed(context, '/reload');
                            },
                            icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                              size: 35.0,)
                        ),
                        HomeCommands(
                            label: "Payer vos Factures",
                            function: () {
                              Navigator.pushNamed(context, '/payInvoice');
                            },
                            icon: SizedBox(child: Image.asset(
                              'assets/images/reception.png', width: 35.0,
                              height: 35.0,))
                        ),
                        HomeCommands(
                            label: "Verification",
                            function: () {
                              Navigator.pushNamed(context, '/verifyAccount');
                            },
                            icon: Icon(MdiIcons.creditCard, color: Color(
                                0xff039BE5), size: 35.0,)
                        ),
                      ],),
                    ),
                    Expanded(
                      child: Column(children: <Widget>[
                        HomeCommands(
                            label: "Gestion comptes",
                            function: () {
                              Navigator.pushNamed(context, '/manageAccounts');
                            },
                            icon: SizedBox(child: Image.asset(
                              'assets/images/gestion_compte.png', width: 35.0,
                              height: 35.0,))
                        ),
                        HomeCommands(
                            label: "QR Code",
                            function: () {
                              Navigator.pushNamed(context, '/qr');
                            },
                            icon: Icon(MdiIcons.qrcodeScan, color: Color(
                                0xff039BE5), size: 35.0,)
                        ),
                        HomeCommands(
                            label: "Consulter Solde",
                            function: () {
                              Navigator.pushNamed(context, '/check');
                            },
                            icon: SizedBox(child: Image.asset(
                              'assets/images/layer11.png', width: 35,
                              height: 35.0,))
                        ),
                      ],),
                    ),
                } else...{
                  Expanded(
                    child: Column(children: <Widget>[
                      HomeCommands(
                          label: "Recharge Comptes",
                          function: () {
                            Navigator.pushNamed(context, '/reload');
                          },
                          icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                            size: 35.0,)
                      ),
                      HomeCommands(
                          label: "Payer vos Factures",
                          function: () {
                            Navigator.pushNamed(context, '/payInvoice');
                          },
                          icon: SizedBox(child: Image.asset(
                            'assets/images/reception.png', width: 35.0,
                            height: 35.0,))
                      ),
                    ],),
                  ),
                  Expanded(
                    child: Column(children: <Widget>[
                      HomeCommands(
                          label: "Consulter Solde",
                          function: () {
                            Navigator.pushNamed(context, '/check');
                          },
                          icon: SizedBox(child: Image.asset(
                            'assets/images/layer11.png', width: 35,
                            height: 35.0,))
                      ),
                      HomeCommands(
                          label: "QR Code",
                          function: () {
                            Navigator.pushNamed(context, '/qr');
                          },
                          icon: Icon(MdiIcons.qrcodeScan, color: Color(
                              0xff039BE5), size: 35.0,)
                      ),
                      HomeCommands(
                          label: "Faire un Retrait",
                          function: () {
                            Navigator.pushNamed(context, '/withraw');
                          },
                          icon: SizedBox(child: Image.asset(
                            'assets/images/reception.png', width: 35.0,
                            height: 35.0,))
                      ),
                    ],),
                  ),
                }
                  }
            } else...{
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Recharge Comptes",
                      function: () {
                        Navigator.pushNamed(context, '/reload');
                      },
                      icon: Icon(MdiIcons.login, color: Color(0xff039BE5),
                        size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Payer vos Factures",
                      function: () {
                        Navigator.pushNamed(context, '/payInvoice');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                ],),
              ),
              Expanded(
                child: Column(children: <Widget>[
                  HomeCommands(
                      label: "Consulter Solde",
                      function: () {
                        Navigator.pushNamed(context, '/check');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/layer11.png', width: 35,
                        height: 35.0,))
                  ),
                  HomeCommands(
                      label: "QR Code",
                      function: () {
                        Navigator.pushNamed(context, '/qr');
                      },
                      icon: Icon(MdiIcons.qrcodeScan, color: Color(
                          0xff039BE5), size: 35.0,)
                  ),
                  HomeCommands(
                      label: "Faire un Retrait",
                      function: () {
                        Navigator.pushNamed(context, '/withraw');
                      },
                      icon: SizedBox(child: Image.asset(
                        'assets/images/reception.png', width: 35.0,
                        height: 35.0,))
                  ),
                ],),
              ),
            },


        ],),

        SizedBox(height: 30.0)

      ],),

      floatingActionButton: new Visibility(
        visible: _isVisible,
        child: new FloatingActionButton(
          onPressed: (){Navigator.pushNamed(context, '/register');},
          tooltip: 'Souscription',
          child: new Icon(Icons.add),
        ),
      ),


     /* floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pushNamed(context, '/register');},
        child: Icon(Icons.add),) ,*/
      
    );
  }


}