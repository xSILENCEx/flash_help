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
  _AccountLogState createState() => _AccountLogState();
}

class _AccountLogState extends State<AccountLog> {
  PageController get _controllerPage => widget.pageController;

  TextEditingController _controllerAccount;
  TextEditingController _controllerPassword;

  FocusNode _pswNode = FocusNode();

  bool _isPswHide = true;
  bool _isProcess = false;

  _sortMethod(String taskType) async {
    //all,onlymoney,onlyint,onlyfree,neartask,newtask,hightask
    var url = 'url';
    http.post(url, body: {"tasktype": "$taskType"});
  }

  _logFunction(String username, String password) async {
    bool log;

    FocusScope.of(context).requestFocus(FocusNode());

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
    _controllerAccount = TextEditingController();
    _controllerPassword = TextEditingController();
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
    return Material(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(100),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(AppColors.AppSubtitleColor),
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  textInputAction: TextInputAction.next,
                  controller: _controllerAccount,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(30),
                      bottom: ScreenUtil().setWidth(30),
                    ),
                    labelText: '昵称/手机号/邮箱',
                    labelStyle: TextStyle(
                      color: Color(AppColors.AppTitleColor),
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
                    ? Container(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setWidth(100),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppStyle.appRadius * 20),
                          ),
                          padding: EdgeInsets.all(0),
                          child: Icon(
                            Icons.clear,
                            color: Color(AppColors.AppThemeColor),
                            size: ScreenUtil().setWidth(50),
                          ),
                          onPressed: () {
                            _controllerAccount.clear();
                            setState(() {});
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(100),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(AppColors.AppSubtitleColor),
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
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
                      color: Color(AppColors.AppTitleColor),
                      fontSize: ScreenUtil().setSp(42),
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (content) {
                    setState(() {});
                  },
                ),
                Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setWidth(100),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppStyle.appRadius * 20),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      _isPswHide ? Icons.visibility : Icons.visibility_off,
                      color: Color(AppColors.AppThemeColor),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                height: ScreenUtil().setWidth(150),
                child: FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    _controllerPage.jumpToPage(0);
                  },
                  child: Text(
                    '手机验证码登录',
                    style: TextStyle(
                      color: Color(AppColors.AppThemeColor),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(42),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
                height: ScreenUtil().setWidth(150),
                child: FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Toast.toast(context, '忘记密码');
                  },
                  child: Text(
                    '忘记密码?',
                    style: TextStyle(
                      color: Color(AppColors.AppThemeColor),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(42),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(260),
                right: ScreenUtil().setWidth(260)),
            margin: EdgeInsets.only(
                top: ScreenUtil().setWidth(120),
                bottom: ScreenUtil().setWidth(60)),
            child: RaisedButton(
              color: Color(AppColors.AppThemeColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              onPressed: _controllerAccount.text.length == 0 ||
                      _controllerPassword.text.length == 0
                  ? null
                  : () async {
                      await _logFunction(
                          _controllerAccount.text, _controllerPassword.text);
                    },
              child: _buildProgress(_isProcess, '登录'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(250),
                height: ScreenUtil().setWidth(1),
                color: Color(AppColors.AppTitleColor),
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(100),
                  bottom: ScreenUtil().setWidth(100),
                  right: ScreenUtil().setWidth(20),
                ),
              ),
              Text(
                '其它登录方式',
                style: TextStyle(
                    color: Color(AppColors.AppTitleColor),
                    fontSize: ScreenUtil().setSp(35),
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: ScreenUtil().setWidth(250),
                height: ScreenUtil().setWidth(1),
                color: Color(AppColors.AppTitleColor),
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(100),
                  bottom: ScreenUtil().setWidth(100),
                  left: ScreenUtil().setWidth(20),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildOtherSignUpItem(
                Icons.alternate_email,
                Color(AppColors.AppThemeColor),
              ),
              _buildOtherSignUpItem(
                Icons.audiotrack,
                Color(AppColors.AppThemeColor),
              ),
              _buildOtherSignUpItem(
                Icons.beach_access,
                Color(AppColors.AppThemeColor),
              ),
              _buildOtherSignUpItem(
                Icons.beenhere,
                Color(AppColors.AppThemeColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildOtherSignUpItem(IconData mIcon, Color mColor) {
    return Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setWidth(150),
      child: FlatButton(
        color: mColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
        ),
        onPressed: () async {},
        child: Icon(
          mIcon,
          color: Color(AppColors.AppMainColor),
          size: ScreenUtil().setWidth(60),
        ),
        padding: EdgeInsets.all(0),
      ),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(80)),
    );
  }

  _buildProgress(bool p, String label) {
    return p
        ? Container(
            alignment: Alignment.center,
            child: SizedBox(
                width: ScreenUtil().setWidth(50),
                height: ScreenUtil().setWidth(50),
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 2)))
        : Text(
            label,
            style: TextStyle(
              color: Color(AppColors.AppMainColor),
              fontSize: ScreenUtil().setSp(42),
              fontWeight: FontWeight.bold,
            ),
          );
  }
}
