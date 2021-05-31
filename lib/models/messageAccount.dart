

import 'package:smopaye_mobile/models/senderAccount.dart';

class MessageAccount {

  SenderAccount sender;
  String notif;


  MessageAccount(this.sender, this.notif);

  MessageAccount.fromJson( Map<String, dynamic> jsonObject){
    this.sender = SenderAccount.fromJson(jsonObject['sender']);
    this.notif = jsonObject['notif'] as String;
  }

}