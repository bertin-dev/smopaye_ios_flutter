


import 'card_Sender.dart';
import 'card_receiver.dart';

class MessageWithdrawalCard {

  Card_Sender sender;
  String notif;


  MessageWithdrawalCard(this.sender, this.notif);

  MessageWithdrawalCard.fromJson( Map<String, dynamic> jsonObject){
    this.sender = Card_Sender.fromJson(jsonObject['sender']);
    this.notif = jsonObject['notif'] as String;
  }

}