


class Abonnement{
  
   String id;
   String subscriptionCharge;
   String subscription_id;
   String subscription_type;
   String compte_id;
   String starting_date;
   String end_date;
   String validate;
   String transaction_number;
   String created_at;
   String updated_at;

   Abonnement(
      this.id,
      this.subscriptionCharge,
      this.subscription_id,
      this.subscription_type,
      this.compte_id,
      this.starting_date,
      this.end_date,
      this.validate,
      this.transaction_number,
      this.created_at,
      this.updated_at);

   Abonnement.fromJson( Map<String, dynamic> jsonObject){
     this.id = jsonObject['id'].toString();
     this.subscriptionCharge = jsonObject['subscriptionCharge'].toString();
     this.subscription_id = jsonObject['subscription_id'].toString();
     this.subscription_type = jsonObject['subscription_type'].toString();
     this.compte_id = jsonObject['compte_id'].toString();
     this.starting_date = jsonObject['starting_date'].toString();
     this.end_date = jsonObject['end_date'].toString();
     this.validate = jsonObject['validate'].toString();
     this.transaction_number = jsonObject['transaction_number'].toString();
     this.created_at = jsonObject['created_at'].toString();
     this.updated_at = jsonObject['updated_at'].toString();
   }

}