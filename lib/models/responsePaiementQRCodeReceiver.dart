

import 'package:smopaye_mobile/models/dataQRCode.dart';

class ResponsePaiementQRCodeReceiver {

  bool success;
  List<DataQRCode> data;
  String message;

  ResponsePaiementQRCodeReceiver(this.success, this.data, this.message);

  ResponsePaiementQRCodeReceiver.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'];
    this.data = [];
    for(var item in jsonObject['data']){
      this.data.add(DataQRCode.fromJson(item));
    }
    this.message = jsonObject['message'].toString();
  }
}