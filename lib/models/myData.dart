

class MyData {

  String starting_date;
  String end_date;
  String card_id_sender;
  String card_id_receiver;
  String transaction_type;
  String transaction_number;
  String amount;
  String device_id;
  String state;
  String tarif_grid_id;
  String servicecharge;
  String updated_at;
  String created_at;
  String id;

  MyData(
      this.starting_date,
      this.end_date,
      this.card_id_sender,
      this.card_id_receiver,
      this.transaction_type,
      this.transaction_number,
      this.amount,
      this.device_id,
      this.state,
      this.tarif_grid_id,
      this.servicecharge,
      this.updated_at,
      this.created_at,
      this.id);


  MyData.fromJson( Map<String, dynamic> jsonObject){
    this.starting_date = jsonObject['starting_date'].toString();
    this.end_date = jsonObject['end_date'].toString();
    this.card_id_sender = jsonObject['card_id_sender'].toString();
    this.card_id_receiver = jsonObject['card_id_receiver'].toString();
    this.transaction_type = jsonObject['transaction_type'].toString();
    this.transaction_number = jsonObject['transaction_number'].toString();
    this.amount = jsonObject['amount'].toString();
    this.device_id = jsonObject['device_id'].toString();
    this.state = jsonObject['state'].toString();
    this.tarif_grid_id = jsonObject['tarif_grid_id'].toString();
    this.servicecharge = jsonObject['servicecharge'].toString();
    this.updated_at = jsonObject['updated_at'].toString();
    this.created_at = jsonObject['created_at'].toString();
    this.id = jsonObject['id'].toString();
  }

}