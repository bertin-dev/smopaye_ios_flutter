import 'package:flutter/material.dart';

class DefaultAlertDialog extends StatelessWidget {

  final String title;
  final String message;
  final Icon icon;

  const DefaultAlertDialog({Key key, this.title, this.message, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),), color: Colors.blue,
        ),
      content: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          icon, 
          SizedBox(width: 10),
          Expanded(child: Text(message))
        ],),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("OK", style: TextStyle(color: Colors.red),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}