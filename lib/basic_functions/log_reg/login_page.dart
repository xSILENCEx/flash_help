import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/arc_clipper.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/basic_functions/log_reg/account_log.dart';
import 'package:flash_help/basic_functions/log_reg/phone_log.dart';
import 'package:flash_help/basic_functions/log_reg/reg_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  PageController _pageController;
  bool _isLog = true;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        elevation: 0.0,
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
        title: Text(
          _isLog ? '登录' : '注册',
          style: TextStyle(
              color: Color(AppColors.AppMainColor),
              fontSize: ScreenUtil().setSp(65),
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_isLog)
                _pageController.jumpToPage(2);
              else
                _pageController.jumpToPage(1);
              setState(() {
                _isLog = !_isLog;
              });
            },
            child: Text(
              _isLog ? '注册' : '登录',
              style: TextStyle(
                  color: Color(AppColors.AppMainColor),
                  fontSize: ScreenUtil().setSp(45),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              alignment: Alignment.topCenter,
              height: ScreenUtil().setWidth(400),
              color: Color(AppColors.AppThemeColor),
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setWidth(60)),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppThemeColor),
                  borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                  border: Border.all(
                      color: Color(AppColors.AppMainColor), width: 4),
                  boxShadow: [
                    BoxShadow(
                        color: Color(AppColors.AppMainColor), blurRadius: 15.0),
                  ],
                ),
                padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
                child: Icon(
                  Icons.flash_on,
                  color: Color(AppColors.AppMainColor),
                  size: ScreenUtil().setWidth(100),
                ),
              ),
            ),
          ),
          Flexible(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                PhoneLog(pageController: _pageController),
                AccountLog(pageController: _pageController),
                RegPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
