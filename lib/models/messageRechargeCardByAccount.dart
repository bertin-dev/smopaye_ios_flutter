

import 'package:smopaye_mobile/models/card_receiver.dart';

class MessageRechargeCardByAccount {

  bool success;
  Card_receiver message;


  MessageRechargeCardByAccount(this.success, this.message);

  MessageRechargeCardByAccount.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.message = Card_receiver.fromJson(jsonObject['message']);
  }

}