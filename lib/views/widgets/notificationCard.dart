import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  
  final String title;
  final String message;
  final String time;
  final bool success;

  const NotificationCard({Key key, this.title, this.message, this.time, this.success}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(5),
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
      child: Row(children: <Widget>[
        Icon(Icons.notifications, size: 90, color: success ? Colors.green : Colors.redAccent),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
              Text(message, style: TextStyle(color: Colors.black45, fontSize: 12)),
              SizedBox(height: 8),
              Text(time, style: TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.bold))
            ]
          ),
        ),
      ],
      ),

    );
  }
}