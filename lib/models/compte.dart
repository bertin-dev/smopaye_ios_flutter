

import 'abonnement.dart';

class Compte{

   String id;
   String account_number;
   String company;
   String account_state;
   String amount;
   String principal_account_id;
   String created_at;
   String updated_at;
   List<Abonnement> compte_subscriptions;

   Compte(
      this.id,
      this.account_number,
      this.company,
      this.account_state,
      this.amount,
      this.principal_account_id,
      this.created_at,
      this.updated_at,
      this.compte_subscriptions);

   Compte.fromJson( Map<String, dynamic> jsonObject){
     this.id = jsonObject['id'].toString();
     this.account_number = jsonObject['account_number'].toString();
     this.company = jsonObject['company'].toString();
     this.account_state = jsonObject['account_state'].toString();
     this.amount = jsonObject['amount'].toString();
     this.principal_account_id = jsonObject['principal_account_id'].toString();
     this.created_at = jsonObject['created_at'].toString();
     this.updated_at = jsonObject['updated_at'].toString();

     this.compte_subscriptions = [];
     for(var item in jsonObject['compte_subscriptions']){
       this.compte_subscriptions.add(Abonnement.fromJson(item));
     }
   }
}