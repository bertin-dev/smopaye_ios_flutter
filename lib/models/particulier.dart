
class Particulier {

   String id;
   String lastname;
   String firstname;
   String cni;
   String gender;
   String user_id;
   String created_at;
   String updated_at;

  Particulier(this.id, this.lastname, this.firstname, this.cni, this.gender,
      this.user_id, this.created_at, this.updated_at);

  Particulier.fromJson( Map<String, dynamic> jsonObject){
    this.id = jsonObject['id'].toString();
    this.lastname = jsonObject['lastname'].toString();
    this.firstname = jsonObject['firstname'].toString();
    this.cni = jsonObject['cni'].toString();
    this.gender = jsonObject['gender'].toString();
    this.user_id = jsonObject['user_id'].toString();
    this.created_at = jsonObject['created_at'].toString();
    this.updated_at = jsonObject['updated_at'].toString();
  }
}