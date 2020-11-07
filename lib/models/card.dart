

import 'dataUserCard.dart';

class Card{

   bool success;
   DataUserCard data;
   String message;

   Card(this.success, this.data, this.message);

   Card.fromJson( Map<String, dynamic> jsonObject){
     this.success = jsonObject['success'] as bool;
     this.data = DataUserCard.fromJson(jsonObject['data']);
     this.message = jsonObject['message'].toString();
   }
}