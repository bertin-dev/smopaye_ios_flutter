import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/abonnement.dart';
import 'package:smopaye_mobile/services/authService.dart';
import 'package:smopaye_mobile/views/widgets/instructionCard.dart';



class ListSubscription extends StatefulWidget {
  @override
  _ListSubscriptionState createState() => _ListSubscriptionState();
}


class _ListSubscriptionState extends State<ListSubscription> {
  String tel = "";

  @override
  void initState() {
    super.initState();
    readPhone();
  }

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final wv =MediaQuery.of(context).size.width/100;

    AuthService authService = new AuthService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(

          children: <Widget>[
            Expanded(
              child:  ListView(children: <Widget>[
                SizedBox(height: hv*3,),
                InstructionCard(text: "Dans cette section, vous avez la liste des abonnements en attente auquels vous avez souscrits."),
                SizedBox(height: hv*15,),
              ]),
            ),
            Expanded(
              child: Container(
                //color: Colors.red,
                padding: EdgeInsets.all(1.0),
                child: FutureBuilder(
                  future: authService.userProfilSubscription(tel),
                  builder: (BuildContext context, AsyncSnapshot<List<Abonnement>> snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.active:
                      //STILL WORKING
                        return _loading();
                        break;
                      case ConnectionState.waiting:
                      //STILL WORKING
                        return _loading();
                        break;
                      case ConnectionState.none:
                      //ERROR
                        return _error('No Connection has been made');
                        break;
                      case ConnectionState.done:
                      //COMPLETED
                        if(snapshot.hasError){
                          return _error(snapshot.error.toString());
                        }
                        if((snapshot.data).length==0){
                          return drawEmptySubscriptionList();
                        } else{
                          if(snapshot.hasData){
                            return drawSubscriptionList(snapshot.data);
                          }
                        }
                        break;
                    }
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text('Votre abonnement est au service')
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Widget drawSubscriptionList(List<Abonnement> abonnement){
    return ListView.builder(
      itemCount: abonnement.length,
      itemBuilder: (BuildContext context, int position){
        return InkWell(
          child: Card(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Souscription ${(abonnement[position].starting_date).substring(0,10)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
                        Text("Expiration ${(abonnement[position].end_date).substring(0,10)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
                      ]
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.subscriptions,
                          color: Colors.grey,
                          size: 60.0,
                        ),
                        Text("${abonnement[position].subscription_type}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                        Column(
                            children: <Widget>[
                              Text("${abonnement[position].subscriptionCharge} FCFA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
                              SizedBox(height: 10.0,),
                              Text("Etat :  ${abonnement[position].validate}"),
                            ]
                        )
                      ]
                  ),
                  SizedBox(height: 15.0,),
                ],
              ),
            )
          ),
          onTap: (){

          },
        );
      },
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  readPhone() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.getString(key) ?? 0;
    if(value != null){
      setState(() {
        tel = value.toString();
      });
    }
  }

  Widget drawEmptySubscriptionList() {
    return Container(
      child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Votre abonnement est au service", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xff039BE5),)),
                  SizedBox(height: 5.0,),
                ]
            ),
          )
    );
  }
}
