import 'package:flutter/material.dart';

class HomeCommands extends StatelessWidget {

  final String label;
  final Widget icon;
  final Function function;

  const HomeCommands({Key key, this.label, this.icon, this.function}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 15.0),
      child: Column(
        children: <Widget>[
          Container(
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
            
            margin: EdgeInsets.only(bottom: 10),
            child: InkWell(onTap: function, highlightColor: Color(0xff039BE5).withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 25.0, left: 45.0, right: 45.0),
                child: icon,
              ),
            ),
          ),
          Text(label, style: TextStyle(fontSize: 12.0, color: Colors.black87, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}