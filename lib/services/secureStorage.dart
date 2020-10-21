import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  static final storage = new FlutterSecureStorage();

  static void tokenStorage({@required String access, @required String refresh}) async {
    await storage.write(key: "access", value: access);
    await storage.write(key: "refresh", value: refresh);
  }

  // Read value
  static Future readAccessToken({@required String access}) async{
   return await storage.read(key: access);
  }

  // Delete value
  static void deleteAccessToken({@required String access}) async{
    return await storage.delete(key: access);
  }

// Read all values
  static Future<Map<String, String>> readAllSecureStorage() async{
    return await storage.readAll();
  }

// Delete all
  static void deleteAllSecureStorage() async{
    return await storage.deleteAll();
  }

}