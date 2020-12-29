

import 'package:smopaye_mobile/locale_db/dbUser.dart';

class LocalUser{

  String KEY_ID = "id";
  String KEY_NOM = "nom";
  String KEY_PRENOM = "prenom";
  String KEY_SEXE = "sexe";
  String KEY_TEL = "tel";
  String KEY_CNI = "cni";
  String KEY_SESSION = "session";
  String KEY_ADRESSE = "adresse";
  String KEY_ID_CARTE = "id_carte";
  String KEY_TYPEUSER = "typeUser";
  String KEY_IMAGEURL = "imageURL";
  String KEY_STATUS = "status";
  String KEY_ABONNEMENT = "abonnement";
  String KEY_DATE = "dateEnreg";
  bool isDeleted;

  LocalUser(
      this.KEY_ID,
      this.KEY_NOM,
      this.KEY_PRENOM,
      this.KEY_SEXE,
      this.KEY_TEL,
      this.KEY_CNI,
      this.KEY_SESSION,
      this.KEY_ADRESSE,
      this.KEY_ID_CARTE,
      this.KEY_TYPEUSER,
      this.KEY_IMAGEURL,
      this.KEY_STATUS,
      this.KEY_ABONNEMENT,
      this.KEY_DATE,
      this.isDeleted);


  LocalUser.fromJson(Map<String, dynamic> jsonObject){
    this.KEY_ID = jsonObject[DbUser.KEY_ID];
    this.KEY_NOM = jsonObject[DbUser.KEY_NOM];
    this.KEY_PRENOM = jsonObject[DbUser.KEY_PRENOM];
    this.KEY_SEXE = jsonObject[DbUser.KEY_SEXE];
    this.KEY_TEL = jsonObject[DbUser.KEY_TEL];
    this.KEY_CNI = jsonObject[DbUser.KEY_CNI];
    this.KEY_SESSION = jsonObject[DbUser.KEY_SESSION];
    this.KEY_ADRESSE = jsonObject[DbUser.KEY_ADRESSE];
    this.KEY_ID_CARTE = jsonObject[DbUser.KEY_ID_CARTE];
    this.KEY_TYPEUSER = jsonObject[DbUser.KEY_TYPEUSER];
    this.KEY_IMAGEURL = jsonObject[DbUser.KEY_IMAGEURL];
    this.KEY_STATUS = jsonObject[DbUser.KEY_STATUS];
    this.KEY_ABONNEMENT = jsonObject[DbUser.KEY_ABONNEMENT];
    this.KEY_DATE = jsonObject[DbUser.KEY_DATE];
    this.isDeleted = jsonObject[DbUser.isDeleted] == 1;
  }

}