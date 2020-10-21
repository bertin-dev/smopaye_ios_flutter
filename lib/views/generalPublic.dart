import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralPublic extends StatelessWidget {
  final String phone = 'tel:+237698783117';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SMOPAYE Customer Service")),
      body: ListView(
        children: <Widget>[
          Container(
            color: Color(0xff039BE5),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  SizedBox(width:20),
                  Icon(Icons.home, color: Colors.white, size: 40,),
                  SizedBox(width: 20),
                  Expanded(child: Text("General Public", style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("The Call Center can be reached 27/7. From a landline you can call +237 222 231 744 or +237 698 768 351", style: TextStyle(color: Colors.grey)),
          ),

          SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:80),
            child: FlatButton(
                  splashColor: Color(0xff039BE5),
                  child: Text("FROM CAMEROON", style: TextStyle(fontWeight: FontWeight.bold),), 
                  color: Colors.white,
                  shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
                  onPressed: _callPhone,),
          ),



        ],
      ),
    );
  }
  
    _callPhone() async {
      if (await canLaunch(phone)) {
        await launch(phone);
      } else {
        throw 'Could not Call Phone';
      }
    }


}