


import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {


  /*----------------------------------------------------------ACCESS TOKEN AND REFRESH TOKEN-------------------------------------------------------*/
  static saveToken(String access_token) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = access_token;
    prefs.setString(key, value);
  }


  static readToken() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

/*----------------------------------------------------------END TOKEN-------------------------------------------------------*/



  /*----------------------------------------------------------SAVE AND PHONE NUMBER-------------------------------------------------------*/
  static savePhone(String tel) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = tel;
    prefs.setString(key, value);
  }

  //pas encore utilisé
  static removePhone() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
/*----------------------------------------------------------END-------------------------------------------------------*/




  static saveProfilUser(
      String idUser,
      String etatUser,
      String myPhoneUser,
      String adresseUser,
      String myCategorieUser,
      String profil_completUser,
      String cniUser,
      String RoleUser,
      String myPersonalAccountNumberUser,
      String myPersonalAccountStateUser,
      String myPersonalAccountAmountUser,
      String myPersonalAccountIdUser,
      String myCompteUser,
      String myIdCardUser,
      String myAbonUser,
      int points,
      int bonus) async{
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("key_idUser", idUser);
    prefs.setString("key_etatUser", etatUser);
    prefs.setString("key_myPhoneUser", myPhoneUser);
    prefs.setString("key_adresseUser", adresseUser);
    prefs.setString("key_myCategorieUser", myCategorieUser);
    prefs.setString("key_profil_completUser", profil_completUser);
    prefs.setString("key_cniUser", cniUser);
    prefs.setString("key_RoleUser", RoleUser);
    prefs.setString("key_myPersonalAccountNumberUser", myPersonalAccountNumberUser);
    prefs.setString("key_myPersonalAccountStateUser", myPersonalAccountStateUser);
    prefs.setString("key_myPersonalAccountAmountUser", myPersonalAccountAmountUser);
    prefs.setString("key_myPersonalAccountIdUser", myPersonalAccountIdUser);
    prefs.setString("key_myCompteUser", myCompteUser);
    prefs.setString("key_myIdCardUser", myIdCardUser);
    prefs.setString("key_myAbonUser", myAbonUser);
    prefs.setInt("key_points", points);
    prefs.setInt("key_bonus", bonus);
  }
}