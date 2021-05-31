

import 'messageToggle.dart';

class Home_toggle {

  bool success;
  MessageToggle message;

  Home_toggle(this.success, this.message);

  Home_toggle.fromJson( Map<String, dynamic> jsonObject){
    this.success = jsonObject['success'] as bool;
    this.message = MessageToggle.fromJson(jsonObject['message']);
  }
}