import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/sql_setting.dart';
import 'package:flash_help/auxiliary/toast.dart';

class UserSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const List<String> _itemTitle = ['账户设置', '我的二维码', '通用设置', '通知提醒', '清除缓存', '图片质量', '隐私', '用户协议', '关于', ''];
    return new Scaffold(
      backgroundColor: Color(AppColors.AppWhiteColor),
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          '设置',
          style: TextStyle(
            color: Color(AppColors.AppWhiteColor),
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(55),
          ),
        ),
        elevation: 0.0,
        brightness: Brightness.dark,
        backgroundColor: Color(AppColors.AppLabelColor),
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(AppColors.AppWhiteColor),
            size: ScreenUtil().setWidth(60),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new ListView.separated(
        itemCount: _itemTitle.length,
        itemBuilder: (BuildContext context, int index) {
          return new SettingItem(index: index, itemTitle: _itemTitle);
        },
        separatorBuilder: (context, index) {
          bool _isLogIn = AppInfo.getLogFlag();
          if (index == 1 || index == 5) {
            return new Container(
              height: ScreenUtil().setWidth(30),
              color: Color(AppColors.AppDeepColor),
            );
          } else if (index == _itemTitle.length - 2 && _isLogIn) {
            return new Container(
              height: ScreenUtil().setWidth(100),
              color: Color(AppColors.AppDeepColor),
            );
          }
          return new Container(
            height: ScreenUtil().setWidth(2),
            color: Color(AppColors.AppDeepColor),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
          );
        },
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final int index;
  final List<String> itemTitle;

  const SettingItem({Key key, @required this.index, @required this.itemTitle}) : super(key: key);

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
          ? new Container(
              height: ScreenUtil().setWidth(140),
              width: double.infinity,
              color: Color(AppColors.AppWaringColor),
              child: new FlatButton(
                onPressed: () async {
                  AppInfo.setLogFlag(false);
                  await SQLiteSetting.resetUser();
                  Toast.toast(context, '账户已注销');
                  Navigator.of(context).pop(false);
                },
                child: new Center(
                  child: Text(
                    '注销',
                    style: TextStyle(
                      color: Color(AppColors.AppWhiteColor),
                      fontSize: ScreenUtil().setSp(42),
                    ),
                  ),
                ),
              ),
            )
          : new Container();
    }
    return new ListTile(
      leading: new Container(
        alignment: Alignment.center,
        height: ScreenUtil().setWidth(80),
        width: ScreenUtil().setWidth(80),
        decoration: BoxDecoration(
          color: Color(AppColors.AppLabelColor2),
          borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
        ),
        child: new Icon(
          _itemIcon[index],
          size: ScreenUtil().setWidth(40),
          color: Color(AppColors.AppWhiteColor),
        ),
      ),
      title: Text(
        itemTitle[index],
        style: TextStyle(
          color: Color(AppColors.AppTextColor2),
          fontSize: ScreenUtil().setSp(42),
        ),
      ),
      trailing: new Icon(
        Icons.arrow_forward_ios,
        size: ScreenUtil().setWidth(60),
        color: Color(AppColors.AppTextColor),
      ),
      onTap: () {
        Toast.toast(context, itemTitle[index]);
      },
    );
  }
}
