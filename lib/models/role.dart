

class Role {

   String id;
   String name;
   String type;
   String created_at;
   String updated_at;

   Role(this.id, this.name, this.type, this.created_at, this.updated_at);

   Role.fromJson( Map<String, dynamic> jsonObject){
     this.id = jsonObject['id'].toString();
     this.name = jsonObject['name'].toString();
     this.type = jsonObject['type'].toString();
     this.created_at = jsonObject['created_at'].toString();
     this.updated_at = jsonObject['updated_at'].toString();
   }
}