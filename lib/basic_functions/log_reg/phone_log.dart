import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneLog extends StatefulWidget {
  final PageController pageController;

  const PhoneLog({Key key, this.pageController}) : super(key: key);

  @override
  _PhoneLogState createState() => new _PhoneLogState();
}

class _PhoneLogState extends State<PhoneLog> {
  TextEditingController _controllerPhone;
  TextEditingController _controllerCode;

  get _controllerPage => widget.pageController;

  bool _isClick = false;
  bool _isNotCountDown = true;
  bool _isProcess = false;

  String _btnContent = '发送验证码';

  @override
  void initState() {
    _controllerPhone = new TextEditingController();
    _controllerCode = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerPhone.dispose();
    _controllerCode.dispose();
    super.dispose();
  }

  _countDown() {
    setState(() {
      _isNotCountDown = false;
      _isClick = true;
    });
    Timer countdownTimer;
    countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (countdownTimer.tick > 59) {
        countdownTimer.cancel();
        countdownTimer = null;
        setState(() {
          _isNotCountDown = true;
          _btnContent = _isClick ? '重新发送' : '发送验证码';
        });
        return null;
      }
      setState(() {
        _btnContent = (60 - countdownTimer.tick).toString().padLeft(2, '0') + ' s';
      });
    });
  }

  _logFunction() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isProcess = true;
    });
    await Future.delayed(Duration(seconds: 3), () async {
      setState(() {
        _isProcess = false;
      });
      Navigator.of(context).pop(true);
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(ScreenUtil().setWidth(100)),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(AppColors.AppBlackColor2),
                ),
              ),
            ),
            child: new Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: _controllerPhone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(30),
                      bottom: ScreenUtil().setWidth(30),
                    ),
                    labelText: '手机号',
                    labelStyle: TextStyle(
                      color: Color(AppColors.AppTextColor1),
                      fontSize: ScreenUtil().setSp(42),
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (content) {
                    setState(() {});
                  },
                ),
                _controllerPhone.text.length > 0
                    ? new Container(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setWidth(100),
                        child: new FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppStyle.appRadius * 20),
                          ),
                          padding: EdgeInsets.all(0),
                          child: new Icon(
                            Icons.clear,
                            color: Color(AppColors.AppLabelColor),
                            size: ScreenUtil().setWidth(50),
                          ),
                          onPressed: () {
                            _controllerPhone.clear();
                            setState(() {});
                          },
                        ),
                      )
                    : new Container(),
              ],
            ),
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Flexible(
                child: new Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(100),
                    right: ScreenUtil().setWidth(100),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(AppColors.AppBlackColor2),
                      ),
                    ),
                  ),
                  child: new TextField(
                    keyboardType: TextInputType.number,
                    controller: _controllerCode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(30),
                        bottom: ScreenUtil().setWidth(30),
                      ),
                      labelText: '验证码',
                      labelStyle: TextStyle(
                        color: Color(AppColors.AppTextColor1),
                        fontSize: ScreenUtil().setSp(42),
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (content) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(100)),
                height: ScreenUtil().setWidth(110),
                width: ScreenUtil().setWidth(400),
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                  ),
                  color: Color(AppColors.AppLabelColor),
                  onPressed: _isNotCountDown && _controllerPhone.text.length != 0 ? _countDown : null,
                  child: new Text(
                    _btnContent,
                    style: TextStyle(
                      color: Color(AppColors.AppWhiteColor),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(42),
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
            width: double.infinity,
            height: ScreenUtil().setWidth(150),
            child: new FlatButton(
              highlightColor: Color(AppColors.AppTranslateColor),
              splashColor: Color(AppColors.AppTranslateColor),
              onPressed: () {
                _controllerPage.jumpToPage(1);
              },
              child: new Text(
                '账号密码登录',
                style: TextStyle(
                  color: Color(AppColors.AppLabelColor),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(42),
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(260), right: ScreenUtil().setWidth(260)),
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(300), bottom: ScreenUtil().setWidth(60)),
            child: new RaisedButton(
              color: Color(AppColors.AppLabelColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              onPressed: _controllerPhone.text.length == 0 || _controllerCode.text.length == 0 ? null : _logFunction,
              child: _buildProgress(_isProcess, '登录'),
            ),
          ),
        ],
      ),
    );
  }

  _buildProgress(bool p, String label) {
    return p
        ? new Container(
        alignment: Alignment.center,
        child: SizedBox(
            width: ScreenUtil().setWidth(50),
            height: ScreenUtil().setWidth(50),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white), strokeWidth: 2)))
        : new Text(label,
      style: TextStyle(
        color: Color(AppColors.AppWhiteColor),
        fontSize: ScreenUtil().setSp(42),
        fontWeight: FontWeight.bold,
      ),);
  }
}
