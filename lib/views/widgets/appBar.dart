import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget  with PreferredSizeWidget {
  final String title;

  DefaultAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: TextStyle(fontSize: 19.0),),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == "moncompte") {
                Navigator.pushNamed(context, '/editAccount');
              }
              else if (value == "apropos") {
                Navigator.pushNamed(context, '/about');
              }
              else if (value == "tutoriel") {
                Navigator.pushNamed(context, '/tutorial');
              }
              
            },
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: "apropos",
                  child: Text("A propos"),
                ),
                PopupMenuItem(
                  value: "tutoriel",
                  child: Text("tutoriel"),
                ),
                PopupMenuItem(
                  value: "moncompte",
                  child: Text("Mon compte"),
                ),
              ],
        )
        ],
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}