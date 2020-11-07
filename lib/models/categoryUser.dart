

class CategoryUser{

   String id;
   String name;
   String role_id;
   String created_at;
   String updated_at;

   CategoryUser(
      this.id, this.name, this.role_id, this.created_at, this.updated_at);

   CategoryUser.fromJson( Map<String, dynamic> jsonObject){
     this.id = jsonObject['id'].toString();
     this.name = jsonObject['name'].toString();
     this.role_id = jsonObject['role_id'].toString();
     this.created_at = jsonObject['created_at'].toString();
     this.updated_at = jsonObject['updated_at'].toString();
   }
}