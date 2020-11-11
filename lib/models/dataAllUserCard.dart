

import 'package:smopaye_mobile/models/particulier.dart';

import 'dataUserCard.dart';
import 'entreprise.dart';

class DataAllUserCard{

  String id;
  String phone;
  String created_at;
  List<DataUserCard> cards;
  List<Particulier> particulier;
  List<Entreprise> enterprise;

  DataAllUserCard(this.id, this.phone, this.created_at, this.cards,
      this.particulier, this.enterprise);

  DataAllUserCard.fromJson( Map<String, dynamic> jsonObject){

    this.id = jsonObject['id'].toString();
    this.phone = jsonObject['phone'].toString();
    this.created_at = jsonObject['created_at'].toString();

    this.cards = [];
    for(var item in jsonObject['cards']){
      this.cards.add(DataUserCard.fromJson(item));
    }

    this.particulier = [];
    for(var item in jsonObject['particulier']){
      this.particulier.add(Particulier.fromJson(item));
    }

    this.enterprise = [];
    for(var item in jsonObject['enterprise']){
      this.enterprise.add(Entreprise.fromJson(item));
    }
  }



}