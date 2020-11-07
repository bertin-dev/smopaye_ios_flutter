
class Entreprise{

   String id;
   String raison_social;
   String user_id;
   String principal_id;
   String created_at;
   String updated_at;

   Entreprise(this.id, this.raison_social, this.user_id, this.principal_id,
      this.created_at, this.updated_at);


   Entreprise.fromJson( Map<String, dynamic> jsonObject){
     this.id = jsonObject['id'].toString();
     this.raison_social = jsonObject['raison_social'].toString();
     this.user_id = jsonObject['user_id'].toString();
     this.principal_id = jsonObject['principal_id'].toString();
     this.created_at = jsonObject['created_at'].toString();
     this.updated_at = jsonObject['updated_at'].toString();
   }
}