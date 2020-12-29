


import 'compteReceiver.dart';
import 'compteSender.dart';

class AllMyMessages {

  bool success;
  CompteSender sender;
  CompteReceiver compte_receiver;

  AllMyMessages(this.success, this.sender, this.compte_receiver);

  AllMyMessages.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.sender = CompteSender.fromJson(jsonObject['sender']);
    this.compte_receiver = CompteReceiver.fromJson(jsonObject['compte_receiver']);
  }
}