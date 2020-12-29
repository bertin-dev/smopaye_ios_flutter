


class CompteSender {

  String id;
  String account_number;
  String company;
  String account_state;
  String amount;
  String notif;

  CompteSender(this.id, this.account_number, this.company, this.account_state,
      this.amount, this.notif);


  CompteSender.fromJson( Map<String, dynamic> jsonObject){
    this.id = jsonObject['id'].toString();
    this.account_number = jsonObject['account_number'].toString();
    this.company = jsonObject['company'].toString();
    this.account_state = jsonObject['account_state'].toString();
    this.amount = jsonObject['amount'].toString();
    this.notif = jsonObject['notif'].toString();
  }
}