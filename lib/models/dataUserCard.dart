

import 'abonnement.dart';

class DataUserCard {

   String id;
   String code_number;
   String serial_number;
   String user_id;
   String type;
   String company;
   String unity;
   String deposit;
   String starting_date;
   String end_date;
   String card_state;
   String created_at;
   String user_created;

   DataUserCard(
      this.id,
      this.code_number,
      this.serial_number,
      this.user_id,
      this.type,
      this.company,
      this.unity,
      this.deposit,
      this.starting_date,
      this.end_date,
      this.card_state,
      this.created_at,
      this.user_created);


   DataUserCard.fromJson( Map<String, dynamic> jsonObject){
     this.id = jsonObject['id'].toString();
     this.code_number = jsonObject['code_number'].toString();
     this.serial_number = jsonObject['serial_number'].toString();
     this.user_id = jsonObject['user_id'].toString();
     this.type = jsonObject['type'].toString();
     this.company = jsonObject['company'].toString();
     this.unity = jsonObject['unity'].toString();
     this.deposit = jsonObject['deposit'].toString();
     this.starting_date = jsonObject['starting_date'].toString();
     this.end_date = jsonObject['end_date'].toString();
     this.card_state = jsonObject['card_state'].toString();
     this.created_at = jsonObject['created_at'].toString();
     this.user_created = jsonObject['user_created'].toString();
   }

}