import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/basic_classes.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

Map defaultUser = {
  "code": 200,
  "msg": "登录成功！",
  "data": {
    "userId": -1,
    "username": "默认昵称",
    "phone": "88888888",
    "email": "example@example.example",
    "password": "000000",
    "autograph": "这个人很懒，什么也没有留下",
    "registertime": "now",
    "isRealName": 0,
    "credit": 0,
    "follow": "",
    "fans": "",
    "balance": 0.0,
    "integral": 0,
    "sendList": "",
    "accept": "",
    "collection": "",
    "finish": "",
    "oftenTask": "",
    "nikename": "test",
    "photo": "",
    "sex": 0,
    "location": "location"
  }
};

//{"code":200,"msg":"登录成功！","data":{"userId":1,"username":"admin","phone":"0","email":"0",
// "password":"123456","autograph":"这个人很懒，什么也没有留下","registertime":"Feb 18, 2019 10:38:57 AM",
// "isRealName":1,"credit":99999,"follow":"0,","fans":"0,","balance":0.0,"integral":0.0,
// "sendList":"1","accept":"0,","collection":"1,","finish":"0,","oftenTask":"0,","nikename":"test",
// "photo":null,"sex":0,"location":null}}

//用户数据表字段名
//'user_id INTEGER, '
//'user_name TEXT, '
//'phone_num TEXT',
//'email TEXT',
//'password TEXT, '
//'auto_graph TEXT, '
//'reg_time TEXT, '
//'is_real_name INTEGER, '
//'credit INTEGER, '
//'follow TEXT'
//'fans TEXT'
//'balance REAL, '
//'integral INTEGER, '
//'send_list TEXT'
//'accept TEXT'
//'collection TEXT'
//'finish TEXT'
//'often_task TEXT'
//'nike_name TEXT, '
//'photo TEXT'
//'sex INTEGER, '
//'location TEXT'

class SQLiteSetting {
  static Future getDbLocalPath() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'help.db');
    return path;
  }

  static Future iniLocalDb() async {
    Database db = await openDatabase(await getDbLocalPath());
    var strMe = await db.rawQuery("SELECT COUNT(*) FROM sqlite_master WHERE TYPE = 'table' AND name = 'me'");
    if (strMe.toList()[0]["COUNT(*)"] == 0) {
      await db.execute(
        'CREATE TABLE me ('
            'id INTEGER PRIMARY KEY, '
            'user_id INTEGER, '
            'user_name TEXT, '
            'phone_num TEXT, '
            'email TEXT, '
            'password TEXT, '
            'auto_graph TEXT, '
            'reg_time TEXT, '
            'is_real_name INTEGER, '
            'credit INTEGER, '
            'follow TEXT, '
            'fans TEXT, '
            'balance REAL, '
            'integral INTEGER, '
            'send_list TEXT, '
            'accept TEXT, '
            'collection TEXT, '
            'finish TEXT, '
            'often_task TEXT, '
            'nike_name TEXT, '
            'photo TEXT, '
            'sex INTEGER, '
            'location TEXT'
            ')',
      );
      await addUser(defaultUser, 'me');
    }
    var strUser = await db.rawQuery("SELECT COUNT(*) FROM sqlite_master WHERE TYPE = 'table' AND name = 'user'");
    if (strUser.toList()[0]["COUNT(*)"] == 0) {
      await db.execute(
        'CREATE TABLE user ('
            'id INTEGER PRIMARY KEY, '
            'user_id INTEGER, '
            'user_name TEXT, '
            'phone_num TEXT, '
            'email TEXT, '
            'password TEXT, '
            'auto_graph TEXT, '
            'reg_time TEXT, '
            'is_real_name INTEGER, '
            'credit INTEGER, '
            'follow TEXT, '
            'fans TEXT, '
            'balance REAL, '
            'integral INTEGER, '
            'send_list TEXT, '
            'accept TEXT, '
            'collection TEXT, '
            'finish TEXT, '
            'often_task TEXT, '
            'nike_name TEXT, '
            'photo TEXT, '
            'sex INTEGER, '
            'location TEXT'
            ')',
      );
    }
    var appInfo = await db.rawQuery("SELECT COUNT(*) FROM sqlite_master WHERE TYPE = 'table' AND name = 'app_info'");
    if (appInfo.toList()[0]["COUNT(*)"] == 0) {
      await db.execute(
        'CREATE TABLE app_info ('
            'id INTEGER PRIMARY KEY, '
            'night_mode INTEGER, '
            'version_name TEXT, '
            'log_flag INTEGER, '
            'first_open INTEGER'
            ')',
      );
      await db.rawQuery(
        'INSERT INTO app_info'
            '('
            'night_mode, '
            'version_name, '
            'log_flag, '
            'first_open'
            ')'
            'VALUES(?, ?, ?, ?)',
        [
          0,
          '${AppInfo.AppVersion}',
          0,
          0,
        ],
      );
    }
    print('初始化本地数据库成功');
  }

  static Future deleteDb() async {
    try {
      await deleteDatabase(await getDbLocalPath());
      print('删除数据库成功');
    } catch (e) {
      print('删除数据库出错');
    }
  }

  static Future addUser(Map data, String table) async {
    //往table表写入一个user
    Database database = await openDatabase(await getDbLocalPath());
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO $table '
            '('
            'user_id, '
            'user_name, '
            'phone_num, '
            'email, '
            'password, '
            'auto_graph, '
            'reg_time, '
            'is_real_name, '
            'credit, '
            'follow, '
            'fans, '
            'balance, '
            'integral, '
            'send_list, '
            'accept, '
            'collection, '
            'finish, '
            'often_task, '
            'nike_name, '
            'photo, '
            'sex, '
            'location'
            ') '
            'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data["data"]['userId'],
          data["data"]['username'],
          data["data"]['phone'],
          data["data"]['email'],
          data["data"]['password'],
          data["data"]['autograph'],
          data["data"]['registertime'],
          data["data"]['isRealName'],
          data["data"]['credit'],
          data["data"]['follow'],
          data["data"]['fans'],
          data["data"]['balance'],
          data["data"]['integral'],
          data["data"]['sendList'],
          data["data"]['accept'],
          data["data"]['collection'],
          data["data"]['finish'],
          data["data"]['oftenTask'],
          data["data"]['nikename'],
          data["data"]['photo'],
          data["data"]['sex'],
          data["data"]['location'],
        ],
      );
    });
  }

  static Future deleteUser(String userName, String table) async {
    //删除table表中名称为userName的行
    Database database = await openDatabase(await getDbLocalPath());
    await database.rawDelete('DELETE FROM $table WHERE user_name = "$userName"');
  }

  static Future getUserValue(String table, String fieldName) async {
    Database database = await openDatabase(await getDbLocalPath());
    var s = await database.rawQuery('SELECT $fieldName FROM $table WHERE id = 1');
    return s.toList()[0]['$fieldName'];
  }

  static Future getMe() async {
    Database db = await openDatabase(await getDbLocalPath());
    var s = await db.rawQuery('SELECT * FROM me WHERE id = 1');
    User me;
    Map user = s.toList()[0];
    try {
      me = new User(
        user["user_id"],
        user["user_name"],
        user["phone_num"],
        user["email"],
        user["auto_graph"],
        user["reg_time"],
        user["is_real_name"],
        user["credit"],
        user["follow"].toString().split(','),
        user["fans"].toString().split(','),
        user["balance"],
        user["integral"],
        user["send_list"].toString().split(','),
        user["accept"].toString().split(','),
        user["collection"].toString().split(','),
        user["finish"].toString().split(','),
        user["often_task"].toString().split(','),
        user["nike_name"],
        user["photo"],
        user["sex"],
        user["location"],
      );
    } catch (e) {
      print('封装User对象出错');
    }
    return me;
  }

  static Future updateUserValue(String table, String fieldName, var newValue, int userId) async {
    //注意：更新字符串时添加/"/",如/"你的字符串/"
    Database database = await openDatabase(await getDbLocalPath());
    await database.rawUpdate('UPDATE $table SET $fieldName = $newValue WHERE id = 1');
  }

  static Future updateUser(Map data, String table) async {
    Database db = await openDatabase(await getDbLocalPath());
    await db.rawUpdate(
      'UPDATE $table SET '
          'user_id = ?, '
          'user_name = ?, '
          'phone_num = ?, '
          'email = ?, '
          'password = ?, '
          'auto_graph = ?, '
          'reg_time = ?, '
          'is_real_name = ?, '
          'credit = ?, '
          'follow = ?, '
          'fans = ?, '
          'balance = ?, '
          'integral = ?, '
          'send_list = ?, '
          'accept = ?, '
          'collection = ?, '
          'finish = ?, '
          'often_task = ?, '
          'nike_name = ?, '
          'photo = ?, '
          'sex = ?, '
          'location = ? '
          'WHERE id = 1',
      [
        data["data"]['userId'],
        data["data"]['username'],
        data["data"]['phone'],
        data["data"]['email'],
        data["data"]['password'],
        data["data"]['autograph'],
        data["data"]['registertime'],
        data["data"]['isRealName'],
        data["data"]['credit'],
        data["data"]['follow'],
        data["data"]['fans'],
        data["data"]['balance'],
        data["data"]['integral'],
        data["data"]['sendList'],
        data["data"]['accept'],
        data["data"]['collection'],
        data["data"]['finish'],
        data["data"]['oftenTask'],
        data["data"]['nikename'],
        data["data"]['photo'],
        data["data"]['sex'],
        data["data"]['location'],
      ],
    );
  }

  static Future resetUser() async {
    Database db = await openDatabase(await getDbLocalPath());
    await db.execute('DROP TABLE me');
    await iniLocalDb();
  }

  static Future updateAppInfo(int logFlag) async {
    Database database = await openDatabase(await getDbLocalPath());
    await database.rawUpdate('UPDATE app_info SET log_flag = $logFlag WHERE id = 1');
  }

  static Future getAppInfo() async {
    Database database = await openDatabase(await getDbLocalPath());
    var s = await database.rawQuery('SELECT log_flag FROM app_info WHERE id = 1');
    return s.toList()[0]['log_flag'];
  }

  static Future test() async {
    await getMe();
  }

  static Future test3() async {
    Database db = await openDatabase(await getDbLocalPath());
    try {
      var s = await db.rawQuery('SELECT * FROM me');
      print('第一次查询结果${s.toString()}');
    } catch (e) {
      print('第一次查询失败');
    }
    try {
      await addUser(defaultUser, "me");
      print('增加admin用户成功');
    } catch (e) {
      print('增加用户出错\n错误代码$e');
    }
    try {
      var s = await db.rawQuery('SELECT * FROM me');
      print('第二次查询结果${s.toString()}');
    } catch (e) {
      print('第二次查询失败');
    }

    try {
      await updateUserValue("me", "nike_name", "\"哈哈哈哈\"", 1);
      print('更新成功');
    } catch (e) {
      print('更新出错\n错误代码$e');
    }
    try {
      var s = await db.rawQuery('SELECT * FROM me');
      print('第三次查询结果${s.toString()}');
    } catch (e) {
      print('第三次查询失败');
    }
    try {
      await deleteUser("admin", "me");
      print('删除admin用户成功');
    } catch (e) {
      print('删除admin用户出错\n错误代码$e');
    }
  }

  static Future test2() async {
    Database db = await openDatabase(await getDbLocalPath());
    try {
      await db.execute('CREATE TABLE test (id INTEGER PRIMARY KEY ,name TEST ,password TEST ,num INTEGER)');
      print('创建test表成功');
    } catch (e) {
      print('创建test表失败\n错误信息$e');
    }
    try {
      await db.rawInsert('INSERT INTO test (name ,password ,num) VALUES (? ,? ,?)', ['admin', '123456', 100]);
      print('插入成功');
    } catch (e) {
      print('插入出错\n错误信息$e');
    }
    try {
      var s = await db.rawQuery('SELECT * FROM test');
      print('修改前: ' + s.toString());
    } catch (e) {
      print('修改前查询失败\n错误信息$e');
    }
    try {
      await db.rawUpdate('UPDATE test SET num = ? WHERE name = ?', [20, 'admin']);
      print('修改成功');
    } catch (e) {
      print('修改失败\n错误信息$e');
    }
    try {
      var s = await db.rawQuery('SELECT * FROM test');
      print('修改后: ' + s.toString());
    } catch (e) {
      print('修改后查询失败\n错误信息$e');
    }
    try {
      var s = await db.rawQuery("SELECT COUNT(*) FROM sqlite_master WHERE TYPE = 'table' AND name = 'User'"); //判断是否有test表
      print('所有表:${s.toList()[0]["COUNT(*)"]}');
    } catch (e) {
      print('错误信息$e');
    }
    try {
      await db.execute('DROP TABLE test');
      print('删除test表成功');
    } catch (e) {
      print('删除test表失败\n错误信息$e');
    }
  }
}
