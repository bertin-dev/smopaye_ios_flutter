


import 'package:smopaye_mobile/models/myData.dart';
import 'allMyMessages.dart';

class AllMyHomeResponse {

  bool success;
  MyData data;
  AllMyMessages message;

  AllMyHomeResponse(this.success, this.data, this.message);

  AllMyHomeResponse.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.data = MyData.fromJson(jsonObject['data']);
    this.message = AllMyMessages.fromJson(jsonObject['message']);
  }

}