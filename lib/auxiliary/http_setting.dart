import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'dart:convert';
import 'package:flash_help/auxiliary/sql_setting.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_classes.dart';
import 'package:http/http.dart' as http;

class HttpSetting {
  static Future userAccountLogin(String username, String password, BuildContext context) async {
    //登录功能
    var response;
    var userMap;
    try {
      var url = "http://47.102.133.157:8080/FlashHelp/LoginServlet";

      response = await http.post(url, body: {"username": "$username", "password": "$password"});

      print("服务器响应码: ${response.statusCode}");
      print("响应结果: ${response.body}");

      userMap = await json.decode(response.body.toString());

      if (userMap["code"] == 200) {
        await SQLiteSetting.updateUser(userMap, 'me');
        await SQLiteSetting.updateAppInfo(1);
        AppInfo.setLogFlag(true);
        Toast.toast(context, '${userMap["msg"]}');
        return true;
      } else {
        Toast.toast(context, '${userMap["msg"]}');
        return false;
      }
    } catch (e) {
      Toast.toast(context, '无法连接到服务器\n错误代码:${response.statusCode}');
      print(e);
      return false;
    }
  }

  static Future userAccountReg(String username, String password, BuildContext context) async {
    //注册功能
    var response;
    var userMap;
    try {
      var url = "http://47.102.133.157:8080/FlashHelp/RegisteServlet";

      response = await http.post(url, body: {"account": "$username", "password": "$password"});

      print("服务器响应码: ${response.statusCode}");
      print("响应结果: ${response.body}");

      userMap = await json.decode(response.body.toString());

      if (userMap["code"] == 200) {
        await SQLiteSetting.updateUser(userMap, 'me');
        await SQLiteSetting.updateAppInfo(1);
        AppInfo.setLogFlag(true);
        Toast.toast(context, '${userMap["msg"]}');
        return true;
      } else {
        Toast.toast(context, '${userMap["msg"]}');
        return false;
      }
    } catch (e) {
      Toast.toast(context, '无法连接到服务器\n错误代码:${response.statusCode}');
      print('错误信息' + e);
      return false;
    }
  }

  static Future sendNewTask(Task task, BuildContext context) async {
    var response;
    var taskR;

    try {
      var url = "http://47.102.133.157:8080/FlashHelp/SendTaskServlet";
      response = await http.post(
        url,
        body: {
          "userId": "${task.uId}",
          "taskName": "${task.taskTitle}",
          "taskInfo": "${task.taskDescribe}",
          "taskPhoto": "${task.pictureList.toString()}",//图片
          "taskLocation": "${task.location}",
          "taskType": "${task.taskType}",
          "taskLabel": "${task.taskLabels.toString()}",//标签
          "taskTimeLimit": "${task.taskLimit}",
          "taskSate": "${task.taskState}",
          "taskStartTime": "${task.taskSendTime}",
        },
      );

      print("服务器响应码: ${response.statusCode}");
      print("响应结果: ${response.body}");

      taskR = await json.decode(response.body.toString());

      if (taskR["code"] == 200) {
        Toast.toast(context, '${taskR["msg"]}');
        return true;
      } else {
        Toast.toast(context, '${taskR["msg"]}');
        return false;
      }

    } catch (e) {
      Toast.toast(context, '无法连接到服务器\n错误代码:${response.statusCode}');
      print('错误信息' + e);
      return false;
    }
  }
}
