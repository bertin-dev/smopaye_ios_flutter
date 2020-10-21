import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {

  final String label;
  final String info;

  const CardInfo({Key key, this.label, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wv =MediaQuery.of(context).size.width/100;
    return Column(
      children: <Widget>[
        Text(label, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18.0), textAlign: TextAlign.center,),
        Container(
          width: wv*55,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.red),
          child: Text(info, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16.0), textAlign: TextAlign.center,),
        ),
      ],
    );
  }
}