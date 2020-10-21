import 'categorie.dart';

class DataUser {

  final String id;
  final String phone;
  final String address;
  final String category_id;
  final String state;
  final String parent_id;
  final String created_by;
  final String compte_id;
  final String role_id;
  final String created_at;
  final String updated_at;
  final Categorie categorie;


  DataUser({
      this.id,
      this.phone,
      this.address,
      this.category_id,
      this.state,
      this.parent_id,
      this.created_by,
      this.compte_id,
      this.role_id,
      this.created_at,
      this.updated_at,
      this.categorie});


  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      phone: json['phone'] as String,
      address: json['address'] as String,
      category_id: json['category_id'] as String,
      state: json['state'] as String,
      parent_id: json['parent_id'] as String,
      created_by: json['created_by'] as String,
      compte_id: json['compte_id'] as String,
      role_id: json['role_id'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      categorie: json['categorie'] as Categorie,
    );
  }
}

