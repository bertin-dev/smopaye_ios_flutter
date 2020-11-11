

import 'dart:io';
import 'package:sqflite/sqflite.dart';

class DbUser{

   static const int DB_VERSION = 1;
   static const String DB_NAME = "smopaye_dbUser";
   static const String TABLE_Users = "utilisateur";

   static const String KEY_ID = "id";
   static const String KEY_NOM = "nom";
   static const String KEY_PRENOM = "prenom";
   static const String KEY_SEXE = "sexe";
   static const String KEY_TEL = "tel";
   static const String KEY_CNI = "cni";
   static const String KEY_SESSION = "session";
   static const String KEY_ADRESSE = "adresse";
   static const String KEY_ID_CARTE = "id_carte";
   static const String KEY_TYPEUSER = "typeUser";
   static const String KEY_IMAGEURL = "imageURL";
   static const String KEY_STATUS = "status";
   static const String KEY_ABONNEMENT = "abonnement";
   static const String KEY_DATE = "dateEnreg";

   static const isDeleted = "isDeleted";

   static void databaselog(String functionName, String sql,
     [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult]){
     print(functionName);
     print(sql);
     if(selectQueryResult != null){
       print(selectQueryResult);
     } else if(insertAndUpdateQueryResult != null){
       print(insertAndUpdateQueryResult);
     }
   }


   Future<void> createUtilisateur(Database db) async{

     final userSQL = ''' CREATE TABLE $TABLE_Users
     (
     $KEY_ID INTEGER PRIMARY KEY,
     $KEY_NOM TEXT,
     $KEY_PRENOM TEXT,
     $KEY_SEXE TEXT,
     $KEY_TEL TEXT,
     $KEY_CNI TEXT,
     $KEY_SESSION TEXT,
     $KEY_ADRESSE TEXT,
     $KEY_ID_CARTE TEXT,
     $KEY_TYPEUSER TEXT,
     $KEY_IMAGEURL TEXT,
     $KEY_STATUS TEXT,
     $KEY_ABONNEMENT TEXT,
     $KEY_DATE TEXT,
     $isDeleted BIT NOT NULL
     
     )''';

     await db.execute(userSQL);
   }

   Future<String> getDatabasePath(String dbName) async{
     final databasePath = await getDatabasesPath();
     final path = join(databasePath, dbName);

     //make sure the folder exists
     if(await Directory(dirname(path)).exists()){
       //await deleteDatabase(path);
     } else{
       await Directory(dirname(path)).create(recursive: true);
     }
     return path;
   }


}