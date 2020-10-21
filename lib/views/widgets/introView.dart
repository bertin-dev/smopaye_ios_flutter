import 'package:flutter/material.dart';
import 'form/button.dart';

class IntroView extends StatelessWidget {

  final String imageLink;
  final String title;
  final String message;
  final String buttonLabel;
  final Function buttonAction;

  const IntroView({Key key, this.imageLink, this.title, this.message, this.buttonLabel, this.buttonAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    return ListView(
      children: <Widget>[
        Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(padding: EdgeInsets.only(top: 40.0, bottom: 0, right: 40, left: 40),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  SizedBox(child: Image.asset(imageLink), height: hv*30,),
                  SizedBox(height: hv*5,),
                  Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7))),

                  SizedBox(height: hv*1.3,),

                  Container(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12, left: 18, right: 12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.12)
                    ),
                    child: Text(message,
                    style: TextStyle()),
                  ),
                  SizedBox(height: hv*2,),
                  CustomButton(
                    color: Colors.red, text: buttonLabel, textColor: Colors.white,
                    onPressed: buttonAction,
                  ),

                ],),
              ),
            ],
          ),
        ),
      ],
    );
  }
}