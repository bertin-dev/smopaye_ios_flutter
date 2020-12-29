


import 'package:smopaye_mobile/locale_db/dbUser.dart';

import 'localUser.dart';

class RepositoryService{


  static Future<List<LocalUser>> getAllUsers() async{
    final sql = '''SELECT * FROM ${DbUser.TABLE_Users} WHERE ${DbUser.isDeleted} == 0''';
    final data = await db.rawQuery(sql);
    List<LocalUser> users = List();

    for(final node in data){
      final user1 = LocalUser.fromJson(node);
      users.add(user1);
    }
    return users;
  }

  static Future<List<LocalUser>> getUserFilter(int id) async{
    final sql = '''SELECT * FROM ${DbUser.TABLE_Users} WHERE ${DbUser.KEY_ID} == $id''';
    final data = await db.rawQuery(sql);
    final user1 = LocalUser.fromJson(data[0]);
    return user1;
  }


  static Future<void> addUser(LocalUser localUser){
    final sql = '''INSERT INTO ${DbUser.TABLE_Users}
    (
     ${DbUser.KEY_ID},
     ${DbUser.KEY_NOM},
     ${DbUser.KEY_PRENOM},
     ${DbUser.KEY_SEXE},
     ${DbUser.KEY_TEL},
     ${DbUser.KEY_CNI},
     ${DbUser.KEY_SESSION},
     ${DbUser.KEY_ADRESSE},
     ${DbUser.KEY_ID_CARTE},
     ${DbUser.KEY_TYPEUSER},
     ${DbUser.KEY_IMAGEURL},
     ${DbUser.KEY_STATUS},
     ${DbUser.KEY_ABONNEMENT},
     ${DbUser.KEY_DATE},
     ${DbUser.isDeleted}
    )
    VALUES
    (
     ${localUser.KEY_ID},
     ${localUser.KEY_NOM},
     ${localUser.KEY_PRENOM},
     ${localUser.KEY_SEXE},
     ${localUser.KEY_TEL},
     ${localUser.KEY_CNI},
     ${localUser.KEY_SESSION},
     ${localUser.KEY_ADRESSE},
     ${localUser.KEY_ID_CARTE},
     ${localUser.KEY_TYPEUSER},
     ${localUser.KEY_IMAGEURL},
     ${localUser.KEY_STATUS},
     ${localUser.KEY_ABONNEMENT},
     ${localUser.KEY_DATE},
     ${localUser.isDeleted ? 1: 0}
    )''';

    final result = await db.rawInsert(sql);
    LocalUser.databaselog('Add user', sql, null, result);


    static Future<void> deleteUser(LocalUser localUser) async{
      final sql = '''UPDATE ${DbUser.TABLE_Users}
      SET ${DbUser.isDeleted} = 1
      WHERE ${DbUser.KEY_ID} == ${localUser.KEY_ID} ''';

      final result = await db.rawUpdate(sql);
      LocalUser.databaselog('Delete user', sql, null, result);
    }


    static Future<void> updateUser(LocalUser localUser) async{
      final sql = '''UPDATE ${DbUser.TABLE_Users}
      SET ${DbUser.KEY_NOM} = ${localUser.KEY_NOM}
      WHERE ${DbUser.KEY_ID} == ${localUser.KEY_ID} ''';

      final result = await db.rawUpdate(sql);
      LocalUser.databaselog('Update user', sql, null, result);
    }


    static Future<int> userCount() async{
      final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DbUser.TABLE_Users}''');

      int count = data[0].values.elementAt(0);
      return count;
    }





  }

}