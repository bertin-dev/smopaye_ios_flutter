


class Card_receiver {

  String id;
  String code_number;
  String serial_number;
  String user_id;
  String type;
  String company;
  String unity;
  String deposit;
  String starting_date;
  String end_date;
  String card_state;
  String user_created;
  String created_at;
  String updated_at;
  String notif;

  Card_receiver(
      this.id,
      this.code_number,
      this.serial_number,
      this.user_id,
      this.type,
      this.company,
      this.unity,
      this.deposit,
      this.starting_date,
      this.end_date,
      this.card_state,
      this.user_created,
      this.created_at,
      this.updated_at,
      this.notif);


  Card_receiver.fromJson( Map<String, dynamic> jsonObject){
    this.id = jsonObject['id'].toString();
    this.code_number = jsonObject['code_number'].toString();
    this.serial_number = jsonObject['serial_number'].toString();
    this.user_id = jsonObject['user_id'].toString();
    this.type = jsonObject['type'].toString();
    this.company = jsonObject['company'].toString();

    this.unity = jsonObject['unity'].toString();
    this.deposit = jsonObject['deposit'].toString();
    this.starting_date = jsonObject['starting_date'].toString();
    this.card_state = jsonObject['card_state'].toString();
    this.user_created = jsonObject['user_created'].toString();
    this.created_at = jsonObject['created_at'].toString();

    this.updated_at = jsonObject['updated_at'].toString();
    this.notif = jsonObject['notif'].toString();
  }
}