
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smopaye_mobile/models/abonnement.dart';
import 'package:smopaye_mobile/models/allMyHomeResponse.dart';
import 'package:smopaye_mobile/models/compte.dart';
import 'package:smopaye_mobile/models/dataAllUserCard.dart';
import 'package:smopaye_mobile/models/dataUser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/dataUserCard.dart';
import 'package:smopaye_mobile/models/errorBody.dart';
import 'package:smopaye_mobile/models/listAllUserCardResponse.dart';
import 'package:smopaye_mobile/utils/endpoints.dart';

class AuthService {


  /*----------------------------------------------------------SMOPAYE MOBILE-------------------------------------------------------*/
  //Service d'Authentification
  static dynamic login({ @required String phone, @required String password, @required String secret }) async {

    /*try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }*/

    try {

      String myUrl = Endpoints.baseUrl + Endpoints.login;
      final response = await http.post(myUrl,
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "phone" : "$phone",
            "password" : "$password",
            "secret" : "$secret"
          });
      /*var data = json.decode(response.body);
    _save(data["access_token"]);*/
      return response;

    }on TimeoutException catch (_) {
      // A timeout occurred.
      return "Temps écroulé";
    } on SocketException catch (_) {
      // Other exception
      return "pas de connexion internet";
    }


    /*catch (exception) {
    if (exception == null ||
    exception.toString().contains('SocketException')) {
    return "Network Error";
    } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
    exception.type == DioErrorType.CONNECT_TIMEOUT) {
    return "Time Out";
    } else {
    return "Unknown Error";
    }
    }*/

    /*on SocketException catch (e) {
      throw new FatalServiceException('Gagal');
    } catch (e) {
      throw new FatalServiceException('Gagal');
    }*/
  }

  //service de Reinitialisation du mot de passe
  static dynamic reset_password({ @required String phone, @required String pIdentite }) async {

      String myUrl = Endpoints.baseUrl + Endpoints.reset_password;
      final response = await http.post(myUrl,
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "phone" : "$phone",
            "cni" : "$pIdentite"
          });
      return response;
  }

  //traitement du profil utilisateur méthode 1
  static dynamic profilUser({ @required String phone}) async {

    var uri =  Endpoints.baseUrl + Endpoints.profilUser + phone;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    http.Response response = await http.get(uri,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        });
    return response;

  }

  //traitement du profil utilisateur méthode 2 pour lister les Abonnements
  Future<List<Abonnement>> userProfilSubscription(@required String phone) async{
    String url = Endpoints.baseUrl + Endpoints.profilUser + phone;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };
    var response = await http.get( url, headers: headers);
    List<Abonnement> itemAbonnement = [];
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);

      //object
      DataUser dataUser = DataUser.fromJson(body);
      print(dataUser.phone);

      Compte compte = dataUser.compte;
      print(compte.compte_subscriptions);

      //ArrayList
      for(var item in compte.compte_subscriptions){
        //Abonnement abon = item;
        print(item.subscription_type);
        itemAbonnement.add(item);
      }
    }
    return itemAbonnement;
  }


  /* Lister all Card using by user */
  Future<List<DataAllUserCard>> findAllUserCards({ @required String user_id }) async {
    print("***************************************** $user_id");
    String myUrl =  Endpoints.baseUrl + Endpoints.cardUser + user_id + Endpoints.cardUser2;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };
    var response = await http.get( myUrl, headers: headers);
    print('11111111111 ${response.statusCode}');
    print('BBBBBBBBBBBBBBB ${jsonDecode(response.body)}');

    List<DataAllUserCard> itemDataAllUserCard = [];
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);

      //object
      ListAllUserCardResponse dataAllUserCard = ListAllUserCardResponse.fromJson(body);

      //ArrayList
      for(var item in dataAllUserCard.data){
        //Abonnement abon = item;
        print(item.phone);
        itemDataAllUserCard.add(item);
      }
    }
    return itemDataAllUserCard;


  }

  //liste la carte principale de l'utilisateur connecté
  Future<DataAllUserCard> userProfilOwnerCard(@required String phone) async{
    String url = Endpoints.baseUrl + Endpoints.profilUser + phone;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };
    var response = await http.get( url, headers: headers);
    DataAllUserCard dataAllUserCard;
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);

      //object
      dataAllUserCard = DataAllUserCard.fromJson(body);
      print(dataAllUserCard.phone);
    }
    return dataAllUserCard;
  }

  /* Transfert(Compte à Compte)*/
  static dynamic transaction_compte_A_Compte({@required double amount, @required String account_number_receiver, @required String account_number_sender, @required String transaction_type}) async {
    String myUrl = Endpoints.baseUrl + Endpoints.account_transfer;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };

    var response = await http.post(myUrl,
        headers: headers,
        body: {
          "amount" : "$amount",
          "account_number_receiver" : "$account_number_receiver",
          "account_number_sender" : "$account_number_sender",
          "transaction_type" : "$transaction_type"
        });
    return response;
}


  /* Transfert(Carte à Carte)*/
  static dynamic transaction_carte_A_Carte({@required double amount, @required String id_card_sender, @required String id_card_receiver, @required String typeTransaction}) async {
    String myUrl = Endpoints.baseUrl + Endpoints.card_transfer;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };

    var response = await http.post(myUrl,
        headers: headers,
        body: {
          "amount" : "$amount",
          "code_number_sender" : "$id_card_sender",
          "code_number_receiver" : "$id_card_receiver",
          "transaction_type" : "$typeTransaction"
        });
    return response;
  }


  /* Basculer (Compte Unité vers Compte dépot et vis-vers ça)*/
  static dynamic toggleUnitDepositInSmopayeServer({@required String card_id, @required String action, @required double withDrawalAmount}) async {
    String myUrl = Endpoints.baseUrl + Endpoints.toggle_balance1 + card_id + Endpoints.toggle_balance2;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };

    var response = await http.post(myUrl,
        headers: headers,
        body: {
          "card_id" : "$card_id",
          "action" : "$action",
          "withDrawalAmount" : "$withDrawalAmount"
        });
    return response;
  }


  /* Consult Account */
  static dynamic consult_account({@required String card_id, @required String typeSolde}) async {
    String myUrl = Endpoints.baseUrl + Endpoints.checkBalance + card_id + '/' + typeSolde;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };

    var response = await http.get(myUrl,
        headers: headers);

    return response;
  }


  //service permettant de recupérer le nom du détenteur du code QR
  static dynamic profil_userQRCode({ @required String card_number }) async {

    String myUrl = Endpoints.baseUrl + Endpoints.qr_code1 + card_number + Endpoints.qr_code2;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    http.Response response = await http.get(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        });
    return response;
  }


  //Retrait (Compte à Compte) chez operateur
  static dynamic retraitCompteOperator({@required String account_number, @required double withDrawalAmount, @required String phoneNumber}) async {
    String myUrl = Endpoints.baseUrl + Endpoints.retraitCompte + account_number + Endpoints.retrait;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };

    var response = await http.post(myUrl,
        headers: headers,
        body: {
          "account_number" : "$account_number",
          "withDrawalAmount" : "$withDrawalAmount",
          "phoneNumber" : "$phoneNumber"
        });
    return response;
  }


  //Retrait (carte à carte) chez operateur
  static dynamic retrait_accepteur({@required double withDrawalAmount, @required String phoneNumber, @required String card_id}) async {
    String myUrl = Endpoints.baseUrl + Endpoints.retraitCarte + card_id + Endpoints.retrait;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };

    var response = await http.post(myUrl,
        headers: headers,
        body: {
          "withDrawalAmount" : "$withDrawalAmount",
          "phoneNumber" : "$phoneNumber",
          "card_id" : "$card_id"
        });
    return response;
  }


  /* Recharge Card by User */
  static dynamic rechargeCards({ @required String code_number, @required double withDrawalAmount, @required String account_number }) async {

    String myUrl = Endpoints.baseUrl + Endpoints.rechargeCartebyCompte + account_number + Endpoints.rechargecarte;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "code_number" : "$code_number",
          "withDrawalAmount" : "$withDrawalAmount",
          "account_number" : "$account_number"
        });
    return response;
  }


  /* Manage_Recharge step 1*/
  static dynamic recharge_step1({ @required String account_number, @required double amount, @required String phoneNumber }) async {
    String myUrl = Endpoints.baseUrl + Endpoints.retraitCompte + account_number + Endpoints.recharge;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "account_number" : "$account_number",
          "amount" : "$amount",
          "phoneNumber" : "$phoneNumber"
        });
    return response;
  }



  /* Manage_Recharge step 2*/
  static dynamic recharge_step2({ @required String account_number, @required String paymentId }) async {
    String myUrl = Endpoints.baseUrl + Endpoints.retraitCompte + account_number + Endpoints.checkpayment;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "account_number" : "$account_number",
          "paymentId" : "$paymentId"
        });
    return response;
  }


























































































  //Différents Roles du client --Administrateur, utilisateur, Agent, Accepteur
  static dynamic roleAndCategory() async {

    var uri = "https://webservice.domaineteste.space.smopaye.fr/public/api/categorierole";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    http.Response response = await http.get(uri,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        });
    return json.decode(response.body);

  }

  //auto enregistrement
  static dynamic auto_register({
    @required String firstname,
    @required String lastname,
    @required String gender,
    @required String address,
    @required String categoryId,
    //@required String createdBy,
    @required String roleId,
    @required String cni,
    @required String phone,
    //@required String cardNumber,
    @required String nom_img_recto,
    @required String nom_img_verso,
    @required String piece_recto,
    @required String piece_verso }) async {

      String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/autoregister";
      final response = await http.post(myUrl,
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "firstname" : "$firstname",
            "lastname" : "$lastname",
            "gender" : "$gender",
            "address" : "$address",
            "category_id" : "$categoryId",
            "role_id" : "$roleId",
            "cni" : "$cni",
            "phone" : "$phone",
            "nom_img_recto" : "$nom_img_recto",
            "nom_img_verso" : "$nom_img_verso",
            "piece_recto" : "$piece_recto",
            "piece_verso" : "$piece_verso"
          });
      /*var data = json.decode(response.body);
    _save(data["access_token"]);*/
      return response;
  }



  //souscription
  static dynamic register({
    @required String lastname,
    @required String firstname,
    @required String gender,
    @required String phone,
    @required String address,
    @required String category_id,
    @required String role_id,
    @required String cni,
    @required String card_number }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/auth/register";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "lastname" : "$lastname",
          "firstname" : "$firstname",
          "gender" : "$gender",
          "phone" : "$phone",
          "address" : "$address",
          "category_id" : "$category_id",
          "role_id" : "$role_id",
          "cni" : "$cni",
          "card_number" : "$card_number"
        });
    /*var data = json.decode(response.body);
    _save(data["access_token"]);*/
    return response;
  }


  //ajout sous-compte
  static dynamic sub_register({
    @required String firstname,
    @required String lastname,
    @required String gender,
    @required String phone,
    @required String address,
    @required String category_id,
    @required String cni,
    @required String role_id,
    @required String card_number }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/subuser";

    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "firstname" : "$firstname",
          "lastname" : "$lastname",
          "gender" : "$gender",
          "phone" : "$phone",
          "address" : "$address",
          "category_id" : "$category_id",
          "cni" : "$cni",
          "role_id" : "$role_id",
          "card_number" : "$card_number"
        });
    /*var data = json.decode(response.body);
    _save(data["access_token"]);*/
    return response;
  }


  //service de Modification du mot de passe
  static dynamic updatePassword({ @required String oldPassword, @required String newPassword }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/renitializePassword";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "oldPassword" : "$oldPassword",
          "newPassword" : "$newPassword"
        });
    return response;
  }


  //service de Rafraichissement du token qui a expiré
  static dynamic refreshToken({ @required String refresh_token}) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/refresh";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "refresh_token" : "$refresh_token"
        });
    return response;
  }


  /* Transfert(Carte à Carte), Payer Facture, QR CODE, RETRAIT_SMOPAYE*/
  static dynamic transaction({ @required double amount, @required String code_number_sender, @required String code_number_receiver, @required String transaction_type }) async {

    String myUrl = Endpoints.baseUrl + Endpoints.transaction;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "amount" : "$amount",
          "code_number_sender" : "$code_number_sender",
          "code_number_receiver" : "$code_number_receiver",
          "transaction_type" : "$transaction_type"
        });
    return response;
  }

  /* Debit */
  static dynamic debit({ @required Float amount, @required String code_number_sender, @required String code_number_receiver, @required String transaction_type, @required String serial_number_device }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/card/transaction/payment";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "amount" : "$amount",
          "code_number_sender" : "$code_number_sender",
          "code_number_receiver" : "$code_number_receiver",
          "transaction_type" : "$transaction_type",
          "serial_number_device" : "$serial_number_device"
        });
    return response;
  }


  /* Abonnement*/
  static dynamic abonnement({ @required int account_id, @required String typeAbonnement }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/account/$account_id/takeSubscription";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "account_id" : "$account_id",
          "type" : "$typeAbonnement"
        });
    return response;
  }




  /* Debit Card */
  static dynamic debit_card({ @required Float amount, @required String code_number_sender, @required String serial_number_device }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/transaction/debit";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "amount" : "$amount",
          "code_number_sender" : "$code_number_sender",
          "serial_number_device" : "$serial_number_device"
        });
    return response;
  }


  /* Details Card */
  static dynamic mycards({ @required int id }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/card/$id";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.get(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        });
    return response;
  }

  /* Activer et désactiver la carte */
  static dynamic etat_carte({ @required String card_id, @required String card_state }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/card/$card_id/activation";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          //"card_id" : "$card_id",
          "card_state" : "$card_state"
        });
    return response;
  }

  /*----------------------------------------------------------END SMOPAYE MOBILE-------------------------------------------------------*/




  /*----------------------------------------------------------CARD SMOPAYE-------------------------------------------------------*/
  /* Create Card */
  static dynamic createCard({ @required String code_number, @required String serial_number, @required String end_date, @required int user_created }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/card";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "code_number" : "$code_number",
          "serial_number" : "$serial_number",
          "end_date" : "$end_date",
          "user_created" : "$user_created"
        });
    return response;
  }

  /* Lister all Cards */
  static dynamic findAllCards() async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/card";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.get(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        });
    return response;
  }




  /* update Card */
  static dynamic updateCard({ @required int card_id, @required String code_number, @required String serial_number, @required String end_date, @required String user_created }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/card/$card_id";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "card_id" : "$card_id",
          "code_number" : "$code_number",
          "serial_number" : "$serial_number",
          "end_date" : "$end_date",
          "user_created" : "$user_created"
        });
    return response;
  }


  /* delete Card */
  static dynamic deleteCard({ @required int card_id }) async {

    String myUrl = "https://webservice.domaineteste.space.smopaye.fr/public/api/card/$card_id";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.delete(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization' : 'Bearer $value'
        });
    return response;
  }

  /*----------------------------------------------------------END CARD SMOPAYE-------------------------------------------------------*/




}