import 'package:flutter/material.dart';

class ChatDiscussion extends StatelessWidget {
  final String name;
  final String message;
  final String avatarUrl;
  final bool active;
  final Function open;

  const ChatDiscussion({Key key, this.name, this.message, this.avatarUrl, this.active, this.open}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: open,
      leading: Stack(
        children: <Widget>[
          avatarUrl == null ? Icon(Icons.account_circle, size: 45, color: Color(0xff039BE5),) : CircleAvatar(backgroundImage: NetworkImage(avatarUrl), radius: 45,),
          Positioned(child: CircleAvatar(radius: 6, backgroundColor: active ? Colors.green : Colors.grey,), top: 30, left: 30)
        ],
      ),
      title: Text(name),  
      subtitle: Text(message, style: TextStyle(color: Color(0xff039BE5))),
    );
  }
}