

import 'Data.dart';
import 'message.dart';
import 'messageRechargeAccount.dart';

class RechargeResponse {

  bool success;
  Data data;
  MessageRechargeAccount message;

  RechargeResponse(this.success, this.data, this.message);

  RechargeResponse.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.data = Data.fromJson(jsonObject['data']);
    this.message = MessageRechargeAccount.fromJson(jsonObject['message']);
  }

}