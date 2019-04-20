import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/sql_setting.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const List<String> _itemTitle = [
      '账户设置',
      '我的二维码',
      '通用设置',
      '通知提醒',
      '清除缓存',
      '图片质量',
      '隐私',
      '用户协议',
      '关于',
      ''
    ];
    return Scaffold(
      backgroundColor: Color(AppColors.AppMainColor),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '设置',
          style: TextStyle(
            color: Color(AppColors.AppMainColor),
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(55),
          ),
        ),
        elevation: 0.0,
        brightness: Brightness.dark,
        backgroundColor: Color(AppColors.AppThemeColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(AppColors.AppMainColor),
            size: ScreenUtil().setWidth(60),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        itemCount: _itemTitle.length,
        itemBuilder: (BuildContext context, int index) {
          return SettingItem(index: index, itemTitle: _itemTitle);
        },
        separatorBuilder: (context, index) {
          bool _isLogIn = AppInfo.getLogFlag();
          if (index == 1 || index == 5) {
            return Container(
              height: ScreenUtil().setWidth(30),
              color: Color(AppColors.AppDeepColor),
            );
          } else if (index == _itemTitle.length - 2 && _isLogIn) {
            return Container(
              height: ScreenUtil().setWidth(100),
              color: Color(AppColors.AppDeepColor),
            );
          }
          return Container(
            height: ScreenUtil().setWidth(2),
            color: Color(AppColors.AppDeepColor),
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(150),
                right: ScreenUtil().setWidth(150)),
          );
        },
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final int index;
  final List<String> itemTitle;

  const SettingItem({Key key, @required this.index, @required this.itemTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<IconData> _itemIcon = [
      Icons.person,
      Icons.center_focus_strong,
      Icons.settings,
      Icons.notifications,
      Icons.cached,
      Icons.photo,
      Icons.block,
      Icons.assignment,
      Icons.error_outline,
    ];
    bool _isLogIn = AppInfo.getLogFlag();
    if (index == itemTitle.length - 1) {
      return _isLogIn
          ? Container(
              height: ScreenUtil().setWidth(140),
              width: double.infinity,
              color: Color(AppColors.AppWaringColor),
              child: FlatButton(
                onPressed: () async {
                  AppInfo.setLogFlag(false);
                  await SQLiteSetting.resetUser();
                  Toast.toast(context, '账户已注销');
                  Navigator.of(context).pop(false);
                },
                child: Center(
                  child: Text(
                    '注销',
                    style: TextStyle(
                      color: Color(AppColors.AppMainColor),
                      fontSize: ScreenUtil().setSp(42),
                    ),
                  ),
                ),
              ),
            )
          : Container();
    }
    return ListTile(
      leading: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setWidth(80),
        width: ScreenUtil().setWidth(80),
        decoration: BoxDecoration(
          color: Color(AppColors.AppThemeColor2),
          borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
        ),
        child: Icon(
          _itemIcon[index],
          size: ScreenUtil().setWidth(40),
          color: Color(AppColors.AppMainColor),
        ),
      ),
      title: Text(
        itemTitle[index],
        style: TextStyle(
          color: Color(AppColors.AppTitleColor),
          fontSize: ScreenUtil().setSp(42),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: ScreenUtil().setWidth(50),
        color: Color(AppColors.AppTitleColor),
      ),
      onTap: () {
        if (itemTitle[index] == '用户协议') {
          _launchURL();
        } else
          Toast.toast(context, itemTitle[index]);
      },
    );
  }

  _launchURL() async {
    const url = 'http://me.liugl.cn/otherFiles/Agreement.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
