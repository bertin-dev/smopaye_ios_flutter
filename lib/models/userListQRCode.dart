


import 'package:smopaye_mobile/models/particulier.dart';

class UserListQRCode {

  String id;
  String phone;
  String address;
  String category_id;
  List<Particulier> particulier;

  UserListQRCode(
      this.id, this.phone, this.address, this.category_id, this.particulier);

  UserListQRCode.fromJson( Map<String, dynamic> jsonObject){
    this.id = jsonObject['id'].toString();
    this.phone = jsonObject['phone'].toString();
    this.address = jsonObject['address'].toString();
    this.category_id = jsonObject['category_id'].toString();
    this.particulier = [];
    for(var item in jsonObject['particulier']){
      this.particulier.add(Particulier.fromJson(item));
    }
  }
}