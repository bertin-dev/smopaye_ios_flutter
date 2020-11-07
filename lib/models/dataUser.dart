import 'package:smopaye_mobile/models/particulier.dart';
import 'package:smopaye_mobile/models/role.dart';
import 'categoryUser.dart';
import 'compte.dart';
import 'dataUserCard.dart';
import 'entreprise.dart';

class DataUser {

   String id;
   String phone;
   String address;
   String category_id;
   String state;
   String parent_id;
   String created_by;
   String compte_id;
   String role_id;
   String bonus;
   String created_at;
   String updated_at;
   String bonus_valider;
   String bonus_non_valider;
   CategoryUser categorie;
   List<Particulier> particulier;
   Role role;
   Compte compte;
   List<DataUserCard> cards;
   List<Entreprise> enterprise;


   DataUser(
      this.id,
      this.phone,
      this.address,
      this.category_id,
      this.state,
      this.parent_id,
      this.created_by,
      this.compte_id,
      this.role_id,
      this.bonus,
      this.created_at,
      this.updated_at,
      this.bonus_valider,
      this.bonus_non_valider,
      this.categorie,
      this.particulier,
      this.role,
      this.compte,
      this.cards,
      this.enterprise);

  DataUser.fromJson( Map<String, dynamic> jsonObject){

  this.id = jsonObject['id'].toString();
  this.phone = jsonObject['phone'].toString();
  this.address = jsonObject['address'].toString();
  this.category_id = jsonObject['category_id'].toString();
  this.state = jsonObject['state'].toString();
  this.parent_id = jsonObject['parent_id'].toString();
  this.created_by = jsonObject['created_by'].toString();
  this.compte_id = jsonObject['compte_id'].toString();
  this.role_id = jsonObject['role_id'].toString();
  this.bonus = jsonObject['bonus'].toString();
  this.created_at = jsonObject['created_at'].toString();
  this.updated_at = jsonObject['updated_at'].toString();
  this.bonus_valider = jsonObject['bonus_valider'].toString();
  this.bonus_non_valider = jsonObject['bonus_non_valider'].toString();
  this.categorie = CategoryUser.fromJson(jsonObject['categorie']);

  this.particulier = [];
  for(var item in jsonObject['particulier']){
    this.particulier.add(Particulier.fromJson(item));
  }
  /*this.particulier = jsonObject['particulier'].map( (Map<String, dynamic> jsonParticulier) {
    return Particulier.fromJson(jsonParticulier);
  }).toList();*/
  this.role = Role.fromJson(jsonObject['role']);
  this.compte = Compte.fromJson(jsonObject['compte']);

  this.cards = [];
  for(var item in jsonObject['cards']){
    this.cards.add(DataUserCard.fromJson(item));
  }
  /*this.cards = jsonObject['cards'].map((Map<String, dynamic> jsonCards){
    return DataUserCard.fromJson(jsonCards);
  }).toList();*/

  this.enterprise = [];
  for(var item in jsonObject['enterprise']){
    this.enterprise.add(Entreprise.fromJson(item));
  }
  /*this.enterprise = jsonObject['enterprise'].map((Map<String, dynamic> jsonEntreprise){
    return Entreprise.fromJson(jsonEntreprise);
  }).toList();*/
  }

}

