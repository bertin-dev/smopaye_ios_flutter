import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {

  final String title;
  final Function onTap;
  final Icon icon;

  const CustomListTile({Key key, this.title, this.onTap, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: icon,
          title: Text(title, style: TextStyle(color: Color(0xff039BE5), fontSize: 20, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),
      ],
    );
  }
}