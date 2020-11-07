
import 'package:smopaye_mobile/models/role.dart';

class Categorie{

   String id;
   String name;
   String role_id;
   Role role;
   String created_at;
   String updated_at;

   Categorie(this.id, this.name, this.role_id, this.role, this.created_at,
      this.updated_at);

   Categorie.fromJson( Map<String, dynamic> jsonObject){
     this.id = jsonObject['id'].toString();
     this.name = jsonObject['name'].toString();
     this.role_id = jsonObject['role_id'].toString();
     this.role = Role.fromJson(jsonObject['role']);
     this.created_at = jsonObject['created_at'].toString();
     this.updated_at = jsonObject['updated_at'].toString();
   }
}


