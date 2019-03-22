import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/arc_clipper.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/sql_setting.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_classes.dart';
import 'package:flash_help/basic_functions/log_reg/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash_help/my_page/user_setting_page.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  bool _isLogin = false;

  User _me;

  List<String> _taskLabels;

  @override
  void initState() {
    _taskLabels = ['取件', '外卖', '洗衣', '排队', '功课', '修图', '手工', '代购', '其它'];
    _me = new User(
      -1,
      '我的',
      '88888888',
      'example@example.exanple',
      '这个人很懒，什么都没有留下',
      '2019',
      0,
      0,
      [],
      [],
      0.0,
      0,
      [],
      [],
      [],
      [],
      [],
      '我的',
      'url',
      0,
      'location',
    );
    super.initState();
  }

  Future _iniData() async {
    _isLogin = AppInfo.getLogFlag();
    if (_isLogin) {
      try {
        _me = await SQLiteSetting.getMe();
      } catch (e) {
        print('读取用户数据出错$e');
      }
    }
  }

  Future _refresh() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {});
      Toast.toast(context, '刷新成功');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _iniData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return new Scaffold(
          body: new NestedScrollView(
            headerSliverBuilder: _isLogin ? _loginHeadBuilder : _notLoginHeadBuilder,
            body: _isLogin ? _buildLogUI() : _buildNotLogUI(),
          ),
        );
      },
    );
  }

  List<Widget> _loginHeadBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      new SliverAppBar(
        brightness: Brightness.dark,
        expandedHeight: ScreenUtil().setWidth(600),
        elevation: 0.0,
        forceElevated: true,
        floating: false,
        pinned: true,
        title: new Text(_me.userName,
            style: TextStyle(color: Color(AppColors.AppWhiteColor), fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(55))),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(AppColors.AppWhiteColor),
              size: ScreenUtil().setWidth(60),
            ),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return new UserSettingPage();
              })).then((value) {
                setState(() {
                  _isLogin = value;
                });
              });
            },
          ),
        ],
        flexibleSpace: new FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: new Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              new Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(AppColors.AppDeepColor),
              ),
              new ClipPath(
                clipper: new ArcClipper(),
                child: new Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setWidth(650),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppLabelColor),
                    image: DecorationImage(
                      image: AssetImage(AppStyle.userPicture1),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20.0, sigmaX: 20.0),
                    child: new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        new Container(
                          color: Color(AppColors.AppLabelColor3),
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Container(
                              width: ScreenUtil().setWidth(160),
                              height: ScreenUtil().setWidth(160),
                              decoration: BoxDecoration(
                                color: Color(AppColors.AppDeepColor),
                                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                                image: DecorationImage(
                                  image: NetworkImage('http://pic150.nipic.com/file/20171222/21540071_161111478000_2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(color: Color(AppColors.AppWhiteColor), width: 2),
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(top: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                              width: ScreenUtil().setWidth(700),
                              child: new Text(
                                _me.autoGraph,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Color(AppColors.AppWhiteColor),
                                  fontSize: ScreenUtil().setSp(34),
                                ),
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(80)),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      _me.isRealName == 1 ? '已实名' : '未实名',
                                      style: TextStyle(
                                        color: Color(AppColors.AppWhiteColor),
                                        fontSize: ScreenUtil().setSp(30),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(AppColors.AppWhiteColor), width: 0.6),
                                      borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
                                    ),
                                    padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                                  ),
                                  new Container(
                                    child: new Text(
                                      '信用度 ${_me.credit}',
                                      style: TextStyle(
                                        color: Color(AppColors.AppWhiteColor),
                                        fontSize: ScreenUtil().setSp(30),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(AppColors.AppWhiteColor), width: 0.6),
                                      borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
                                    ),
                                    padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(AppColors.AppLabelColor),
      ),
    ];
  }

  List<Widget> _notLoginHeadBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      new SliverAppBar(
        brightness: Brightness.dark,
        expandedHeight: ScreenUtil().setWidth(600),
        elevation: 0.0,
        forceElevated: true,
        floating: false,
        pinned: true,
        title: new Text('我的', style: TextStyle(color: Color(AppColors.AppWhiteColor), fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(55))),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(AppColors.AppWhiteColor),
              size: ScreenUtil().setWidth(60),
            ),
            onPressed: () async {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return new UserSettingPage();
              })).then((value) {
                setState(() {
                  _isLogin = value;
                });
              });
            },
          ),
        ],
        flexibleSpace: new FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: new Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              new Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(AppColors.AppDeepColor),
              ),
              new ClipPath(
                clipper: new ArcClipper(),
                child: new Container(
                  height: ScreenUtil().setWidth(650),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppLabelColor),
                    image: DecorationImage(
                      image: AssetImage(AppStyle.unLog),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20.0, sigmaX: 20.0),
                    child: new Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        new Container(
                          color: Color(AppColors.AppLabelColor3),
                        ),
                        new Container(
                          width: ScreenUtil().setWidth(160),
                          height: ScreenUtil().setWidth(160),
                          decoration: BoxDecoration(
                            color: Color(AppColors.AppDeepColor),
                            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                            image: DecorationImage(
                              image: AssetImage(AppStyle.unLog),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Color(AppColors.AppWhiteColor), width: 2),
                          ),
                          margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(160)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(AppColors.AppLabelColor),
      ),
    ];
  }

  _buildLogUI() {
    return new RefreshIndicator(
      onRefresh: _refresh,
      color: Color(AppColors.AppWhiteColor),
      backgroundColor: Color(AppColors.AppLabelColor),
      child: new ListView.separated(
        padding: EdgeInsets.all(0),
        itemCount: 13,
        itemBuilder: (BuildContext context, int index) {
          return new FunctionItem(index: index, user: _me, taskLabels: _taskLabels);
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0 || index == 4 || index == 5 || index == 8 || index == 10) {
            return new Container(
              height: ScreenUtil().setWidth(30),
              color: Color(AppColors.AppDeepColor),
            );
          }
          return new Container(
            height: ScreenUtil().setWidth(2),
            color: Color(AppColors.AppDeepColor),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(150), right: ScreenUtil().setWidth(150)),
          );
        },
      ),
    );
  }

  _buildNotLogUI() {
    return new Container(
      color: Color(AppColors.AppDeepColor),
      child: new Center(
        child: new Container(
          width: ScreenUtil().setWidth(360),
          height: ScreenUtil().setWidth(100),
          child: new RaisedButton(
            color: Color(AppColors.AppLabelColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
            ),
            onPressed: () async {
              setState(() {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new LoginPage();
                })).then((value) async {
                  if (value != null) {
                    setState(() {
                      _isLogin = value;
                    });
                  }
                });
              });
            },
            child: new Text('登录 / 注册', style: TextStyle(color: Color(AppColors.AppWhiteColor), fontSize: ScreenUtil().setSp(40))),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FunctionItem extends StatelessWidget {
  final int index;
  final User user;
  final List<String> taskLabels;

  const FunctionItem({Key key, @required this.index, @required this.user, @required this.taskLabels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> _icons = [
      null,
      Icons.assignment,
      Icons.send,
      Icons.check_circle_outline,
      Icons.stars,
      Icons.monetization_on,
      Icons.chat,
      Icons.history,
      Icons.label_important,
      Icons.person_pin,
      Icons.verified_user,
      Icons.supervised_user_circle,
    ];
    List<String> _titleList = ['', '悬赏清单', '发布', '完成', '收藏', '积分', '评论', '历史', '常用标签', '实名认证', '安全认证', '联系客服'];
    List<String> _count = [
      '',
      '${user.accept.length}',
      '${user.sendList.length}',
      '${user.finish.length}',
      '${user.collection.length}',
      '${user.integral}',
      '0',
      '0'
    ];
    if (index == 0) {
      return new Row(
        children: <Widget>[
          new Flexible(
            child: new FlatButton(
              color: Color(AppColors.AppWhiteColor),
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              onPressed: () {
                Toast.toast(context, '关注');
              },
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    '${user.follow.length}',
                    style: TextStyle(
                      color: Color(AppColors.AppTextColor2),
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                  new Container(
                    color: Color(AppColors.AppDeepColor),
                    width: ScreenUtil().setWidth(300),
                    height: 1,
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                  ),
                  new Text(
                    '关注',
                    style: TextStyle(
                      color: Color(AppColors.AppTextColor2),
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                ],
              ),
            ),
            fit: FlexFit.tight,
          ),
          new Flexible(
            child: new FlatButton(
              color: Color(AppColors.AppWhiteColor),
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              onPressed: () {
                Toast.toast(context, '粉丝');
              },
              child: new Column(
                children: <Widget>[
                  new Text(
                    '${user.fans.length}',
                    style: TextStyle(
                      color: Color(AppColors.AppTextColor2),
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                  new Container(
                    color: Color(AppColors.AppDeepColor),
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setWidth(2),
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                  ),
                  new Text(
                    '粉丝',
                    style: TextStyle(
                      color: Color(AppColors.AppTextColor2),
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                ],
              ),
            ),
            fit: FlexFit.tight,
          ),
        ],
      );
    } else if (index == 8) {
      return ListTile(
        leading: new Container(
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setWidth(80),
          decoration: BoxDecoration(
            color: Color(AppColors.AppLabelColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          alignment: Alignment.center,
          child: new Icon(
            _icons[index],
            size: ScreenUtil().setWidth(40),
            color: Color(
              AppColors.AppWhiteColor,
            ),
          ),
        ),
        title: Text(
          _titleList[index],
          style: TextStyle(
            color: Color(AppColors.AppTextColor2),
            fontSize: ScreenUtil().setSp(42),
          ),
        ),
        trailing: new Container(
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new Container(
                  height: ScreenUtil().setWidth(50),
                  child: new ListView.builder(
                    itemCount: taskLabels.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTaskItem(index);
                    },
                  ),
                ),
              ),
              new Icon(
                Icons.arrow_forward_ios,
                size: ScreenUtil().setWidth(50),
              ),
            ],
          ),
          width: ScreenUtil().setWidth(600),
        ),
        onTap: () {
          Toast.toast(context, _titleList[index]);
        },
      );
    } else if (index > 8 && index < 12) {
      return new ListTile(
        leading: new Container(
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setWidth(80),
          decoration: BoxDecoration(
            color: Color(AppColors.AppLabelColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          alignment: Alignment.center,
          child: new Icon(
            _icons[index],
            size: ScreenUtil().setWidth(40),
            color: Color(
              AppColors.AppWhiteColor,
            ),
          ),
        ),
        title: new Text(
          _titleList[index],
          style: TextStyle(
            color: Color(AppColors.AppTextColor2),
            fontSize: ScreenUtil().setSp(42),
          ),
        ),
        trailing: new Icon(
          Icons.arrow_forward_ios,
          size: ScreenUtil().setWidth(50),
        ),
        onTap: () {
          Toast.toast(context, _titleList[index]);
        },
      );
    } else if (index == 12) {
      return new Container(
        height: ScreenUtil().setWidth(250),
        width: double.infinity,
        color: Color(AppColors.AppDeepColor),
      );
    } else
      return new ListTile(
        leading: new Container(
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setWidth(80),
          decoration: BoxDecoration(
            color: Color(AppColors.AppLabelColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          alignment: Alignment.center,
          child: new Icon(
            _icons[index],
            size: ScreenUtil().setWidth(40),
            color: Color(
              AppColors.AppWhiteColor,
            ),
          ),
        ),
        title: new Text(
          _titleList[index],
          style: TextStyle(
            color: Color(AppColors.AppTextColor2),
            fontSize: ScreenUtil().setSp(42),
          ),
        ),
        trailing: new Container(
          width: ScreenUtil().setWidth(400),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text(_count[index]),
              new Icon(
                Icons.arrow_forward_ios,
                size: ScreenUtil().setWidth(50),
              ),
            ],
          ),
        ),
        onTap: () {
          Toast.toast(context, _titleList[index]);
        },
      );
  }

  _buildTaskItem(int index) {
    return new Center(
      child: new Container(
        alignment: Alignment.center,
        child: new Text('${taskLabels[index]}', style: TextStyle(color: Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(32))),
        decoration: BoxDecoration(
          border: Border.all(color: Color(AppColors.AppTextColor1), width: 0.7),
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
        ),
        margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
      ),
    );
  }
}
