
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smopaye_mobile/models/dataUser.dart';
import 'package:smopaye_mobile/models/particulier.dart';
import 'package:smopaye_mobile/utils/api_util.dart';

class AuthService2{


    Future<List<Particulier>> fetchAllProfilUser() async{
    String url = ApiUtil.MAIN_API_URL + ApiUtil.PARAMS_USER + "694048925";
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $value'
    };
    var response = await http.get( url, headers: headers);
    List<Particulier> itemParticulier = [];
    if(response.statusCode == 200){
     Map<String, dynamic> body = jsonDecode(response.body);

     //object
     DataUser dataUser = DataUser.fromJson(body);
     print(dataUser.phone);

     //ArrayList
     for(var item in body['particulier']){
       Particulier particulier = Particulier.fromJson( item );
       print(particulier.firstname);
       itemParticulier.add(particulier);
     }
    }
    return itemParticulier;
  }
}