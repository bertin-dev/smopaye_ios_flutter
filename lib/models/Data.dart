


class Data {

  String id;
  String account_number;
  String company;
  String amount;
  String notif;


  Data(this.id, this.account_number, this.company, this.amount, this.notif);

  Data.fromJson( Map<String, dynamic> jsonObject){
    this.id = jsonObject['id'].toString();

    this.account_number = jsonObject['account_number'].toString();
    this.company = jsonObject['company'].toString();
    this.amount = jsonObject['amount'].toString();
    this.notif = jsonObject['notif'].toString();
  }

}