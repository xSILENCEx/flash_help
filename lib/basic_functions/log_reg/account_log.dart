import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/http_setting.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class AccountLog extends StatefulWidget {
  final PageController pageController;

  const AccountLog({Key key, this.pageController}) : super(key: key);

  @override
  _AccountLogState createState() => new _AccountLogState();
}

class _AccountLogState extends State<AccountLog> {
  PageController get _controllerPage => widget.pageController;

  TextEditingController _controllerAccount;
  TextEditingController _controllerPassword;

  FocusNode _pswNode = new FocusNode();

  bool _isPswHide = true;
  bool _isProcess = false;

  _sortMethod(String taskType) async {
    //all,onlymoney,onlyint,onlyfree,neartask,newtask,hightask
    var url = 'url';
    http.post(url, body: {"tasktype": "$taskType"});
  }

  _logFunction(String username, String password) async {
    bool log;

    FocusScope.of(context).requestFocus(new FocusNode());

    setState(() {
      _isProcess = true;
    });

    try {
      log = await HttpSetting.userAccountLogin(username, password, context);
    } catch (e) {
      print('错误$e');
    }

    if (log) {
      Navigator.of(context).pop(true);
    }

    setState(() {
      _isProcess = false;
    });
  }

  @override
  void initState() {
    _controllerAccount = new TextEditingController();
    _controllerPassword = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerAccount.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(100),
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
            child: new Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                new TextField(
                  textInputAction: TextInputAction.next,
                  controller: _controllerAccount,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(30),
                      bottom: ScreenUtil().setWidth(30),
                    ),
                    labelText: '昵称/手机号/邮箱',
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
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_pswNode);
                  },
                ),
                _controllerAccount.text.length > 0
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
                            _controllerAccount.clear();
                            setState(() {});
                          },
                        ),
                      )
                    : new Container(),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(100),
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
            child: new Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                new TextField(
                  focusNode: _pswNode,
                  controller: _controllerPassword,
                  obscureText: _isPswHide,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(30),
                      bottom: ScreenUtil().setWidth(30),
                    ),
                    labelText: '密码',
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
                new Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setWidth(100),
                  child: new FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.appRadius * 20),
                    ),
                    padding: EdgeInsets.all(0),
                    child: new Icon(
                      _isPswHide ? Icons.visibility : Icons.visibility_off,
                      color: Color(AppColors.AppLabelColor),
                      size: ScreenUtil().setWidth(50),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPswHide = !_isPswHide;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                height: ScreenUtil().setWidth(150),
                child: new FlatButton(
                  highlightColor: Color(AppColors.AppTranslateColor),
                  splashColor: Color(AppColors.AppTranslateColor),
                  onPressed: () {
                    _controllerPage.jumpToPage(0);
                  },
                  child: new Text(
                    '手机验证码登录',
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
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
                height: ScreenUtil().setWidth(150),
                child: new FlatButton(
                  highlightColor: Color(AppColors.AppTranslateColor),
                  splashColor: Color(AppColors.AppTranslateColor),
                  onPressed: () {
                    Toast.toast(context, '忘记密码');
                  },
                  child: new Text(
                    '忘记密码?',
                    style: TextStyle(
                      color: Color(AppColors.AppLabelColor),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(42),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                ),
              ),
            ],
          ),
          new Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(260), right: ScreenUtil().setWidth(260)),
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(120), bottom: ScreenUtil().setWidth(60)),
            child: new RaisedButton(
              color: Color(AppColors.AppLabelColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              onPressed: _controllerAccount.text.length == 0 || _controllerPassword.text.length == 0
                  ? null
                  : () async {
                      await _logFunction(_controllerAccount.text, _controllerPassword.text);
                    },
              child: _buildProgress(_isProcess, '登录'),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: ScreenUtil().setWidth(250),
                height: ScreenUtil().setWidth(3),
                color: Color(AppColors.AppTextColor1),
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(100),
                  bottom: ScreenUtil().setWidth(100),
                  right: ScreenUtil().setWidth(20),
                ),
              ),
              new Text(
                '其它登录方式',
                style: TextStyle(color: Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(35), fontWeight: FontWeight.bold),
              ),
              new Container(
                width: ScreenUtil().setWidth(250),
                height: ScreenUtil().setWidth(3),
                color: Color(AppColors.AppTextColor1),
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(100),
                  bottom: ScreenUtil().setWidth(100),
                  left: ScreenUtil().setWidth(20),
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildOtherSignUpItem(
                Icons.alternate_email,
                Color(AppColors.AppLabelColor2),
              ),
              _buildOtherSignUpItem(
                Icons.audiotrack,
                Color(AppColors.AppItemColor1),
              ),
              _buildOtherSignUpItem(
                Icons.beach_access,
                Color(AppColors.AppItemColor2),
              ),
              _buildOtherSignUpItem(
                Icons.beenhere,
                Color(AppColors.AppItemColor3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildOtherSignUpItem(IconData mIcon, Color mColor) {
    return new Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setWidth(150),
      child: new FlatButton(
        color: mColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
        ),
        onPressed: () async {},
        child: new Icon(
          mIcon,
          color: Color(AppColors.AppWhiteColor),
          size: ScreenUtil().setWidth(60),
        ),
        padding: EdgeInsets.all(0),
      ),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(80)),
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
        : new Text(
            label,
            style: TextStyle(
              color: Color(AppColors.AppWhiteColor),
              fontSize: ScreenUtil().setSp(42),
              fontWeight: FontWeight.bold,
            ),
          );
  }
}
