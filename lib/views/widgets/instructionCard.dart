import 'package:flutter/material.dart';

class InstructionCard extends StatelessWidget {
  
  final String text;

  const InstructionCard({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
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
      child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Color(0xff039BE5)))
    );
  }
}