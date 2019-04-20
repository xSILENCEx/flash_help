import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/sql_setting.dart';
import 'package:flash_help/main_body.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

void main() async {
  try {
    await SQLiteSetting.iniLocalDb();
    int f = await SQLiteSetting.getAppInfo();
    AppInfo.setLogFlag(f == 1);
  } catch (e) {
    print('检查登录状态出错$e');
  } //检查是否登录
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(FlashHelp());
  });
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//    SystemChrome.setEnabledSystemUIOverlays([]);
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }
}

class FlashHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '闪帮',
      theme: ThemeData(
        platform: TargetPlatform.android,
        primaryColor: Color(AppColors.AppThemeColor),
        cardColor: Colors.transparent,
        scaffoldBackgroundColor: Color(AppColors.AppMainColor),
      ),
      home: MainBody(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}
