

import 'package:smopaye_mobile/models/Data.dart';
import 'package:smopaye_mobile/models/MessageAccount.dart';

class HomeRetraitAccount {

  bool success;
  Data data;
  MessageAccount message;

  HomeRetraitAccount(this.success, this.data, this.message);

  HomeRetraitAccount.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.data = Data.fromJson(jsonObject['data']);
    this.message = MessageAccount.fromJson(jsonObject['message']);
  }

}