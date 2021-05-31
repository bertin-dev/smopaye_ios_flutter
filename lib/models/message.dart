


import 'card_Sender.dart';
import 'card_receiver.dart';

class Message {

  Card_Sender card_sender;
  Card_receiver card_receiver;
  String status;


  Message(this.card_sender, this.card_receiver, this.status);

  Message.fromJson( Map<String, dynamic> jsonObject){
    this.card_sender = Card_Sender.fromJson(jsonObject['card_sender']);
    this.card_receiver = Card_receiver.fromJson(jsonObject['card_receiver']);
    this.status = jsonObject['status'] as String;
  }

}