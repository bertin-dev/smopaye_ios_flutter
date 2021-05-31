


import 'package:smopaye_mobile/models/message.dart';

import 'myData.dart';

class HomeResponse {

  bool success;
  MyData data;
  Message message;

  HomeResponse(this.success, this.data, this.message);

  HomeResponse.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.data = MyData.fromJson(jsonObject['data']);
    this.message = Message.fromJson(jsonObject['message']);
  }

}