import 'dart:async';

import 'package:flutter/material.dart';

//Page de chargement

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() { 
    super.initState();
    Timer(Duration(seconds: 5),
    (){
      Navigator.pushNamed(context, '/intro');
    }
    )
    ;
  }

  Widget build(BuildContext context) {
    final hv =MediaQuery.of(context).size.height/100;
    final wv =MediaQuery.of(context).size.width/100;
    return Container(
      decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg3.png'),
                  fit: BoxFit.cover,
                )
              ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(child: Image.asset('assets/images/logo.png'), width: wv*60,),
                SizedBox(height: hv*3,),
                Theme(child: CircularProgressIndicator(backgroundColor: Colors.white.withOpacity(0.1),), data: ThemeData(accentColor: Colors.white.withOpacity(0.6)),),
                SizedBox(height: 10.0),
                Text('Chargement En Cours...', style:TextStyle(fontSize: 17.0, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600))
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}