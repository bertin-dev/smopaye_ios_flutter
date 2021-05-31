


import 'package:smopaye_mobile/models/myData.dart';
import 'allMyMessages.dart';

class AllMyResponse {

  bool success;
  String message;

  AllMyResponse(this.success, this.message);

  AllMyResponse.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.message = jsonObject['message'].toString();
  }

}