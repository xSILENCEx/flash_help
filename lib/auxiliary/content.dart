import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const LDeepColor = 0xFFEDEDED;
  static const DDeepColor = 0xFF000000;
  static const LMainColor = 0xFEFEFEFE;
  static const DMainColor = 0xFF111111;
  static const LThemeColor = 0xFF2196F3;
  static const DThemeColor = 0xFF111111;
  static const LThemeColor2 = LThemeColor + 0xFF0C0C0C;
  static const DThemeColor2 = DThemeColor + 0xFF0C0C0C;
  static const LTitleColor = 0xFF666666;
  static const DTitleColor = 0xFF999999;
  static const LSubtitleColor = 0xFF999999;
  static const DSubtitleColor = 0xFF666666;
  static const DotColor1 = 0xFF8D6AEA;
  static const DotColor2 = 0xFFEDEDED;

  static int AppDeepColor = LDeepColor;
  static int AppMainColor = LMainColor;
  static int AppThemeColor = LThemeColor;
  static int AppThemeColor2 = LThemeColor2;
  static int AppTitleColor = LTitleColor;
  static int AppSubtitleColor = LSubtitleColor;
  static int AppDotColor = DotColor1;
  static int AppShadowColor = 0xFFEEEEEE;
  static int AppMaskColor = 0x88000000;
  static int AppWaringColor = 0xFFFF544A;

  static openNightMode() {
    AppDeepColor = DDeepColor;
    AppMainColor = DMainColor;
    AppThemeColor = DThemeColor;
    AppThemeColor2 = DThemeColor2;
  }
}

class AppInfo {
  static bool logFlag = false;
  static const AppName = "闪帮";
  static const AppVersion = "0.0.4";
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
    await SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  static checkInternet(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      Toast.toast(context, '请检查网络');
      return false;
    }
  }
}

class AppStyle {
  static double appRadius = 8;
  static double sizeScale = 1.00;
  static double appTitleFS = ScreenUtil().setSp(60) * sizeScale;
  static String userPicture1 = 'images/user_me.jpg';
  static String userPicture2 = 'images/user_2.jpg';
  static String unLog = 'images/unlog.jpg';

  void changeAppRadius(double radius, BuildContext context) {
    appRadius = radius;
    Toast.toast(context, '修改成功');
  }
}
