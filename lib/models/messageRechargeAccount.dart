

class MessageRechargeAccount {

  String status;
  String message;
  String flow;
  String channel_ussd;
  String channel_name;
  String channel;
  String paymentId;

  MessageRechargeAccount(
      this.status,
      this.message,
      this.flow,
      this.channel_ussd,
      this.channel_name,
      this.channel,
      this.paymentId);


  MessageRechargeAccount.fromJson( Map<String, dynamic> jsonObject){
    this.status = jsonObject['id'].toString();
    this.message = jsonObject['message'].toString();
    this.flow = jsonObject['flow'].toString();
    this.channel_ussd = jsonObject['channel_ussd'].toString();
    this.channel_name = jsonObject['channel_name'].toString();
    this.channel = jsonObject['channel'].toString();
    this.paymentId = jsonObject['paymentId'].toString();
  }

}