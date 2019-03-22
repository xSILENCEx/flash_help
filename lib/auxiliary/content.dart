import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:connectivity/connectivity.dart';

class AppColors {
  static const AppDeepColor = 0xFFEDEDED;
  static const AppDeepColor2 = 0xEECECECE;
  static const AppLabelColor = 0xFF2196F3;
  static const AppLabelColor2 = 0xFFFDA84B;
  static const AppLabelColor3 = 0x55234183;
  static const AppLabelColor4 = 0x552196F3;
  static const AppBarItemColor = 0xFF434343;
  static const AppWhiteColor = 0xFFFAFAFA;
  static const AppWhiteColor2 = 0x11FFFFFF;
  static const AppWhiteColor3 = 0xFFFFFFFF;
  static const AppWhiteColor4 = 0x33FFFFFF;
  static const AppWhiteColor5 = 0x33FFFFFF;
  static const AppShadowColor = 0x33DADADA;
  static const AppShadowColor2 = 0xAADADADA;
  static const AppShadowColor3 = 0xFF9B9B9B;
  static const AppBorderColor = 0xFFC1C1C1;
  static const AppLightColor = 0xFFFFFFFF;
  static const AppTextColor = 0xFF989898;
  static const AppTextColor1 = 0xFF808080;
  static const AppTextColor2 = 0xFF4B4B4B;
  static const AppBlackColor1 = 0xDD000000;
  static const AppBlackColor2 = 0x5F000000;
  static const AppBlackColor3 = 0x55000000;
  static const AppTranslateColor = 0x00000000;
  static const AppWaveColor = 0x05000000;
  static const AppWaveColor2 = 0x08000000;
  static const AppItemColor1 = 0xFF6A94FF;
  static const AppItemColor2 = 0xFF55E25C;
  static const AppItemColor3 = 0xFF9886FF;
  static const AppWaringColor = 0xFFFF544A;
}

class AppInfo {
  static bool logFlag = false;
  static const AppName = "闪帮";
  static const AppVersion = "0.0.2";
  static bool isNightModeOpen = false;

  static getLogFlag() {
    return logFlag;
  }

  static setLogFlag(bool log) {
    logFlag = log;
  }

  static hideTop() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static openTop() async {
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  static checkInternet(BuildContext context) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }else{
      Toast.toast(context, '请检查网络');
      return false;
    }
  }
}

class AppStyle {
  static double appRadius = 8;
  static String userPicture1 = 'images/user_me.jpg';
  static String userPicture2 = 'images/user_2.jpg';
  static String unLog = 'images/unlog.jpg';

  void changeAppRadius(double radius, BuildContext context) {
    appRadius = radius;
    Toast.toast(context, '修改成功');
  }
}
