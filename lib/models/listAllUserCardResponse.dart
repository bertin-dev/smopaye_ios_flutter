

import 'dataAllUserCard.dart';

class ListAllUserCardResponse{

  bool success;
  List<DataAllUserCard> data;
  String message;

  ListAllUserCardResponse(this.success, this.data, this.message);


  ListAllUserCardResponse.fromJson( Map<String, dynamic> jsonObject){

    this.success = jsonObject['success'];
    this.data = [];
    for(var item in jsonObject['cards']){
      this.data.add(DataAllUserCard.fromJson(item));
    }
    this.message = jsonObject['message'].toString();

  }
}