

class ErrorBody {

  bool success;
  String message;

  ErrorBody(this.success, this.message);
  ErrorBody.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.message = jsonObject['message'].toString();
  }
}