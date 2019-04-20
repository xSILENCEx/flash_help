import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/http_setting.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController _controllerUserName;
  TextEditingController _controllerPassword;
  TextEditingController _controllerCheckPassword;

  FocusNode _pswNode = FocusNode();
  FocusNode _checkPswNode = FocusNode();

  bool _isPswHide = true;
  bool _isProcess = false;
  bool _isPswSame = true;
  bool _isNameRight = true;

  List<String> _onPswComplete = ['密码', '含非法字符', '至少6位', '最多16位', '不能是9位以下纯数字'];

  int _pswS = 0; //密码强度标记
  int _pswC = 0; //密码格式标记

  bool _checkName() {
    String name = _controllerUserName.text;
    String regStrName = r"^[\u4e00-\u9fa5_a-zA-Z0-9_-、]{4,16}$";
    RegExp regExpName = RegExp(
      regStrName,
      caseSensitive: false,
      multiLine: false,
    );
    setState(() {
      _isNameRight = regExpName.hasMatch(name);
    });
    return regExpName.hasMatch(name);
  }

  _checkFirstPsw() {
    String psw = _controllerPassword.text;

    int flag = 0;

    if (psw.length < 6) {
      flag = 2;
    } else if (psw.length > 16) {
      flag = 3;
    } else {
      String regComNum9 = r"^\d{1,8}$";
      String regComSymbol = r"^.*[ \u4e00-\u9fa5]+.*$";
      RegExp regExpNum9 = RegExp(
        regComNum9,
        caseSensitive: false,
        multiLine: false,
      );
      RegExp regExpSpace = RegExp(
        regComSymbol,
        caseSensitive: false,
        multiLine: false,
      );
      if (regExpNum9.hasMatch(psw)) {
        flag = 4;
      }
      if (regExpSpace.hasMatch(psw)) {
        flag = 1;
      }
    }

    setState(() {
      _pswC = flag;
    });

    return flag == 0 ? true : false;
  }

  _checkSedPsw() {
    String fPsw = _controllerPassword.text;
    String sPsw = _controllerCheckPassword.text;

    FocusScope.of(context).requestFocus(FocusNode());

    if (fPsw == sPsw) {
      setState(() {
        _isPswSame = true;
      });
    } else {
      setState(() {
        _isPswSame = false;
      });
    }
    return _isPswSame;
  }

  _pswStrength() {
    setState(() {
      _pswS = 0;
    });
    int count = 0;
    try {
      String psw = _controllerPassword.text;
      if (psw.length < 6) return false;
      String regStrNum = r"^.*\d+.*$";
      String regStrLetter = r"^.*[a-zA_Z]+.*$";
      String regStrSymbol = r"^.*[~!@#$%^&*()_+|<>,.?/:;'\\\[\]{}]+.*$";
      RegExp regExpNum = RegExp(
        regStrNum,
        caseSensitive: false,
        multiLine: false,
      );
      RegExp regExpLetter = RegExp(
        regStrLetter,
        caseSensitive: false,
        multiLine: false,
      );
      RegExp regExpSymbol = RegExp(
        regStrSymbol,
        caseSensitive: false,
        multiLine: false,
      );
      if (regExpNum.hasMatch(psw)) count++;
      if (regExpLetter.hasMatch(psw)) count++;
      if (regExpSymbol.hasMatch(psw)) count++;

      setState(() {
        _pswS = count;
      });

      return count > 0 ? true : false;
    } catch (e) {
      print('密码强度校验错误');
      print(e);
    }
  }

  _regFunction() async {
    String username = _controllerUserName.text;
    String password = _controllerPassword.text;
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        _isProcess = true;
      });
      if (_checkFirstPsw() &&
          _checkSedPsw() &&
          _pswStrength() &&
          _checkName()) {
        bool log =
            await HttpSetting.userAccountReg(username, password, context);
        if (log) {
          Navigator.of(context).pop(true);
        }
      } else {
        Toast.toast(context, '请检查用户名和密码');
      }
      setState(() {
        _isProcess = false;
      });
    } catch (e) {
      Toast.toast(context, '未知错误');
      print('错误信息' + e.toString());
      setState(() {
        _isProcess = false;
      });
    }
  }

  @override
  void initState() {
    _controllerUserName = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerCheckPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    _controllerPassword.dispose();
    _controllerCheckPassword.dispose();
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
                  color: Color(_isNameRight
                      ? AppColors.AppSubtitleColor
                      : AppColors.AppWaringColor),
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    color: Color(_isNameRight
                        ? AppColors.AppTitleColor
                        : AppColors.AppWaringColor),
                  ),
                  onTap: () {
                    setState(() {
                      _isNameRight = true;
                      _isPswSame = true;
                      _pswC = 0;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  controller: _controllerUserName,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                    hintText: '支持文字、字母、数字 -_、4-16位',
                    hintStyle: TextStyle(
                      color: Color(AppColors.AppTitleColor),
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.normal,
                    ),
                    labelText: _isNameRight ? '用户名/昵称' : '格式有误',
                    labelStyle: TextStyle(
                      color: Color(_isNameRight
                          ? AppColors.AppTitleColor
                          : AppColors.AppWaringColor),
                      fontSize: ScreenUtil().setSp(42),
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (String content) {
                    setState(() {});
                  },
                  onEditingComplete: () {
                    if (_checkName()) {
                      FocusScope.of(context).requestFocus(_pswNode);
                    }
                  },
                ),
                _controllerUserName.text.length > 0
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
                            _controllerUserName.clear();
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
              top: ScreenUtil().setWidth(140),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100),
              bottom: ScreenUtil().setWidth(20),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(_pswC == 0
                      ? AppColors.AppSubtitleColor
                      : AppColors.AppWaringColor),
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    color: Color(_pswC == 0
                        ? AppColors.AppTitleColor
                        : AppColors.AppWaringColor),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _pswNode,
                  controller: _controllerPassword,
                  obscureText: _isPswHide,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                    labelText: _onPswComplete[_pswC],
                    labelStyle: TextStyle(
                      color: Color(_pswC == 0
                          ? AppColors.AppTitleColor
                          : AppColors.AppWaringColor),
                      fontSize: ScreenUtil().setSp(42),
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: '至少6位，不能为9位以下纯数字',
                    hintStyle: TextStyle(
                      color: Color(AppColors.AppTitleColor),
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.normal,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (content) {
                    _pswStrength();
                  },
                  onEditingComplete: () {
                    if (_checkFirstPsw()) {
                      FocusScope.of(context).requestFocus(_checkPswNode);
                    }
                  },
                  onTap: () {
                    setState(() {
                      _pswC = 0;
                      _isPswSame = true;
                      _isNameRight = true;
                    });
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
          _buildPswStrength(_pswS),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(100),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(_isPswSame
                      ? AppColors.AppSubtitleColor
                      : AppColors.AppWaringColor),
                ),
              ),
            ),
            child: TextField(
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(45),
                color: Color(_isPswSame
                    ? AppColors.AppTitleColor
                    : AppColors.AppWaringColor),
              ),
              onTap: () {
                setState(() {
                  _isNameRight = true;
                  _isPswSame = true;
                  _pswC = 0;
                });
              },
              focusNode: _checkPswNode,
              controller: _controllerCheckPassword,
              obscureText: _isPswHide,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setWidth(20),
                ),
                labelText: _isPswSame ? '确认密码' : '密码不一致',
                labelStyle: TextStyle(
                  color: Color(_isPswSame
                      ? AppColors.AppTitleColor
                      : AppColors.AppWaringColor),
                  fontSize: ScreenUtil().setSp(42),
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
              onEditingComplete: () {
                _checkSedPsw();
              },
            ),
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
              onPressed: _controllerUserName.text.length == 0 ||
                      _controllerPassword.text.length == 0 ||
                      _controllerCheckPassword.text.length == 0
                  ? null
                  : () async {
                      await _regFunction();
                    },
              child: _buildProgress(_isProcess, '注册'),
            ),
          ),
        ],
      ),
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

  _buildPswStrength(int index) {
    List<String> strStrength = ['', '弱', '中', '强'];
    List<int> color = [
      0x00FFFFFF,
      AppColors.AppWaringColor,
      AppColors.AppThemeColor2,
      AppColors.AppThemeColor
    ];
    List<Widget> art = [
      Container(),
      Row(
        children: <Widget>[
          Flexible(
              child: Container(
            width: ScreenUtil().setWidth(200),
            decoration: BoxDecoration(
              color: Color(color[index]),
              borderRadius: BorderRadius.circular(AppStyle.appRadius * 10),
            ),
          )),
          Flexible(child: Container()),
          Flexible(child: Container()),
        ],
      ),
      Row(
        children: <Widget>[
          Flexible(
              child: Container(
            width: ScreenUtil().setWidth(200),
            decoration: BoxDecoration(
              color: Color(color[index]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppStyle.appRadius * 10),
                  bottomLeft: Radius.circular(AppStyle.appRadius * 10)),
            ),
          )),
          Flexible(
              child: Container(
            width: ScreenUtil().setWidth(200),
            decoration: BoxDecoration(
              color: Color(color[index]),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppStyle.appRadius * 10),
                  bottomRight: Radius.circular(AppStyle.appRadius * 10)),
            ),
          )),
          Flexible(child: Container()),
        ],
      ),
      Container(
        width: ScreenUtil().setWidth(200),
        decoration: BoxDecoration(
          color: Color(color[index]),
          borderRadius: BorderRadius.circular(AppStyle.appRadius * 10),
        ),
      ),
    ];

    return Row(
      children: <Widget>[
        Container(width: ScreenUtil().setWidth(100)),
        Text(
          '密码强度: ',
          style: TextStyle(
            color: Color(AppColors.AppTitleColor),
            fontSize: ScreenUtil().setSp(36),
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
          padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
          width: ScreenUtil().setWidth(400),
          height: ScreenUtil().setWidth(35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 10),
            border: Border.all(
                color: Color(AppColors.AppTitleColor),
                width: ScreenUtil().setWidth(3)),
          ),
          child: art[index],
        ),
        Text(
          strStrength[index],
          style: TextStyle(
            color: Color(AppColors.AppTitleColor),
            fontSize: ScreenUtil().setSp(36),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
