
import 'package:smopaye_mobile/models/Data.dart';
import 'package:smopaye_mobile/models/MessageWithdrawalCard.dart';

class HomeRetrait {

  bool success;
  Data data;
  MessageWithdrawalCard message;

  HomeRetrait(this.success, this.data, this.message);

  HomeRetrait.fromJson( Map<String, dynamic> jsonObject){
  this.success = jsonObject['success'] as bool;
  this.data = Data.fromJson(jsonObject['data']);
  this.message = MessageWithdrawalCard.fromJson(jsonObject['message']);
  }



}