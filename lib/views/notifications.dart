import 'package:flutter/material.dart';

import 'widgets/notificationCard.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  bool _notificationsExist = true;
  var notification_list = [
    {
      "title": "Paiement de Facture",
      "message": "Numéro de compte FFJJNSJS pas enrégistré ou non utilisé",
      "time": "4/9/20 2:10 AM",
      "success": false,
    },
    {
      "title": "Paiement aléatoire",
      "message": "Numéro de compte FFJJNSJS pas enrégistré ou non utilisé",
      "time": "4/9/20 2:10 AM",
      "success": true,
    },
    {
      "title": "Paiement de Facture",
      "message": "Numéro de compte FFJJNSJS pas enrégistré ou non utilisé",
      "time": "4/9/20 2:10 AM",
      "success": false,
    },
    {
      "title": "Paiement de Facture",
      "message": "Numéro de compte FFJJNSJS pas enrégistré ou non utilisé",
      "time": "4/9/20 2:10 AM",
      "success": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final wv =MediaQuery.of(context).size.width/100;
    return Scaffold(
      body: _notificationsExist ? 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: notification_list.length,
            itemBuilder: (BuildContext context, int index){
              final item = notification_list[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                setState(() {
                  notification_list.removeAt(index);
                });
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Notification du ${item["time"]} supprimée")));
              },
              background: Container(padding: EdgeInsets.only(left: wv*80),color: Colors.red, child: Icon(Icons.delete, color: Colors.white, size: 30)),
                child: NotificationCard(
                  title: notification_list[index]["title"],
                  message: notification_list[index]["message"],
                  time: notification_list[index]["time"],
                  success: notification_list[index]["success"],
                ),
              );
            }
            
          ),
        )
        :
        Center(child: Text("Notifications vides", style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold))),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          _notificationsExist = false;
        });
      },
        child: Icon(Icons.delete), backgroundColor: Colors.red,),
    );
  }
}