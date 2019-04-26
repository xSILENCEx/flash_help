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
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  bool _isLogin = false;

  User _me;

  List<String> _taskLabels;

  @override
  void initState() {
    _taskLabels = ['取件', '外卖', '洗衣', '排队', '功课', '修图', '手工', '代购', '其它'];
    _me = User(
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
    return FutureBuilder(
      future: _iniData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                _isLogin ? _loginHeadBuilder : _notLoginHeadBuilder,
            body: _isLogin ? _buildLogUI() : _buildNotLogUI(),
          ),
        );
      },
    );
  }

  List<Widget> _loginHeadBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        brightness: Brightness.dark,
        expandedHeight: ScreenUtil().setWidth(600),
        elevation: 0.0,
        forceElevated: true,
        floating: false,
        pinned: true,
        title: Text(_me.userName,
            style: TextStyle(
                color: Color(AppColors.AppMainColor),
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(55))),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(AppColors.AppMainColor),
              size: ScreenUtil().setWidth(60),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return UserSettingPage();
              })).then((value) {
                setState(() {
                  _isLogin = value;
                });
              });
            },
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(AppColors.AppDeepColor),
              ),
              ClipPath(
                clipper: ArcClipper(),
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setWidth(650),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppThemeColor),
                    image: DecorationImage(
                      image: AssetImage(AppStyle.userPicture1),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20.0, sigmaX: 20.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          color: Color(AppColors.AppMaskColor),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(160),
                              height: ScreenUtil().setWidth(160),
                              decoration: BoxDecoration(
                                color: Color(AppColors.AppDeepColor),
                                borderRadius: BorderRadius.circular(
                                    AppStyle.appRadius * 40),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'http://pic150.nipic.com/file/20171222/21540071_161111478000_2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: Color(AppColors.AppMainColor),
                                    width: 2),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(20),
                                  bottom: ScreenUtil().setWidth(20)),
                              width: ScreenUtil().setWidth(700),
                              child: Text(
                                _me.autoGraph,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Color(AppColors.AppMainColor),
                                  fontSize: ScreenUtil().setSp(34),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setWidth(80)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      _me.isRealName == 1 ? '已实名' : '未实名',
                                      style: TextStyle(
                                        color: Color(AppColors.AppMainColor),
                                        fontSize: ScreenUtil().setSp(30),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(AppColors.AppMainColor),
                                          width: 0.6),
                                      borderRadius: BorderRadius.circular(
                                          AppStyle.appRadius / 4),
                                    ),
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setWidth(5)),
                                  ),
                                  Container(
                                    child: Text(
                                      '信用度 ${_me.credit}',
                                      style: TextStyle(
                                        color: Color(AppColors.AppMainColor),
                                        fontSize: ScreenUtil().setSp(30),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(AppColors.AppMainColor),
                                          width: 0.6),
                                      borderRadius: BorderRadius.circular(
                                          AppStyle.appRadius / 4),
                                    ),
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setWidth(5)),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(20)),
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
        backgroundColor: Color(AppColors.AppThemeColor),
      ),
    ];
  }

  List<Widget> _notLoginHeadBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        brightness: Brightness.dark,
        expandedHeight: ScreenUtil().setWidth(600),
        elevation: 0.0,
        forceElevated: true,
        floating: false,
        pinned: true,
        title: Text('我的',
            style: TextStyle(
                color: Color(AppColors.AppMainColor),
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(55))),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(AppColors.AppMainColor),
              size: ScreenUtil().setWidth(60),
            ),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return UserSettingPage();
              })).then((value) {
                setState(() {
                  _isLogin = value;
                });
              });
            },
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(AppColors.AppDeepColor),
              ),
              ClipPath(
                clipper: ArcClipper(),
                child: Container(
                  height: ScreenUtil().setWidth(650),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppThemeColor),
                    image: DecorationImage(
                      image: AssetImage(AppStyle.unLog),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20.0, sigmaX: 20.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          color: Color(AppColors.AppMaskColor),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(160),
                          height: ScreenUtil().setWidth(160),
                          decoration: BoxDecoration(
                            color: Color(AppColors.AppDeepColor),
                            borderRadius:
                                BorderRadius.circular(AppStyle.appRadius * 40),
                            image: DecorationImage(
                              image: AssetImage(AppStyle.unLog),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                                color: Color(AppColors.AppMainColor), width: 2),
                          ),
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setWidth(160)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(AppColors.AppThemeColor),
      ),
    ];
  }

  _buildLogUI() {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: Color(AppColors.AppMainColor),
      backgroundColor: Color(AppColors.AppThemeColor),
      child: ListView.separated(
        padding: EdgeInsets.all(0),
        itemCount: 13,
        itemBuilder: (BuildContext context, int index) {
          return FunctionItem(index: index, user: _me, taskLabels: _taskLabels);
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0 ||
              index == 4 ||
              index == 5 ||
              index == 8 ||
              index == 10) {
            return Container(
              height: ScreenUtil().setWidth(30),
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

  _buildNotLogUI() {
    return Container(
      color: Color(AppColors.AppDeepColor),
      child: Center(
        child: Container(
          width: ScreenUtil().setWidth(360),
          height: ScreenUtil().setWidth(100),
          child: FlatButton(
            color: Color(AppColors.AppThemeColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
            ),
            onPressed: () async {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return LoginPage();
                })).then((value) async {
                  if (value != null) {
                    setState(() {
                      _isLogin = value;
                    });
                  }
                });
              });
            },
            child: Text('登录 / 注册',
                style: TextStyle(
                    color: Color(AppColors.AppMainColor),
                    fontSize: ScreenUtil().setSp(40))),
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

  const FunctionItem(
      {Key key,
      @required this.index,
      @required this.user,
      @required this.taskLabels})
      : super(key: key);

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
    List<String> _titleList = [
      '',
      '悬赏清单',
      '发布',
      '完成',
      '收藏',
      '积分',
      '评论',
      '历史',
      '常用标签',
      '实名认证',
      '安全认证',
      '联系客服'
    ];
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
      return Row(
        children: <Widget>[
          Flexible(
            child: FlatButton(
              color: Color(AppColors.AppMainColor),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setWidth(30)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              onPressed: () {
                Toast.toast(context, '关注');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${user.follow.length}',
                    style: TextStyle(
                      color: Color(AppColors.AppTitleColor),
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                  Container(
                    color: Color(AppColors.AppDeepColor),
                    width: ScreenUtil().setWidth(300),
                    height: 1,
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                  ),
                  Text(
                    '关注',
                    style: TextStyle(
                      color: Color(AppColors.AppTitleColor),
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                ],
              ),
            ),
            fit: FlexFit.tight,
          ),
          Flexible(
            child: FlatButton(
              color: Color(AppColors.AppMainColor),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setWidth(30)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              onPressed: () {
                Toast.toast(context, '粉丝');
              },
              child: Column(
                children: <Widget>[
                  Text(
                    '${user.fans.length}',
                    style: TextStyle(
                      color: Color(AppColors.AppTitleColor),
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                  Container(
                    color: Color(AppColors.AppDeepColor),
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setWidth(2),
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20),
                    ),
                  ),
                  Text(
                    '粉丝',
                    style: TextStyle(
                      color: Color(AppColors.AppTitleColor),
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
        leading: Container(
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setWidth(80),
          decoration: BoxDecoration(
            color: Color(AppColors.AppThemeColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          alignment: Alignment.center,
          child: Icon(
            _icons[index],
            size: ScreenUtil().setWidth(40),
            color: Color(
              AppColors.AppMainColor,
            ),
          ),
        ),
        title: Text(
          _titleList[index],
          style: TextStyle(
            color: Color(AppColors.AppTitleColor),
            fontSize: ScreenUtil().setSp(42),
          ),
        ),
        trailing: Container(
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  height: ScreenUtil().setWidth(50),
                  child: ListView.builder(
                    itemCount: taskLabels.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTaskItem(index);
                    },
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: ScreenUtil().setWidth(40),
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
      return ListTile(
        leading: Container(
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setWidth(80),
          decoration: BoxDecoration(
            color: Color(AppColors.AppThemeColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          alignment: Alignment.center,
          child: Icon(
            _icons[index],
            size: ScreenUtil().setWidth(40),
            color: Color(
              AppColors.AppMainColor,
            ),
          ),
        ),
        title: Text(
          _titleList[index],
          style: TextStyle(
            color: Color(AppColors.AppTitleColor),
            fontSize: ScreenUtil().setSp(42),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: ScreenUtil().setWidth(40),
        ),
        onTap: () {
          Toast.toast(context, _titleList[index]);
        },
      );
    } else if (index == 12) {
      return Container(
        height: ScreenUtil().setWidth(250),
        width: double.infinity,
        color: Color(AppColors.AppDeepColor),
      );
    } else
      return ListTile(
        leading: Container(
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setWidth(80),
          decoration: BoxDecoration(
            color: Color(AppColors.AppThemeColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          alignment: Alignment.center,
          child: Icon(
            _icons[index],
            size: ScreenUtil().setWidth(40),
            color: Color(
              AppColors.AppMainColor,
            ),
          ),
        ),
        title: Text(
          _titleList[index],
          style: TextStyle(
            color: Color(AppColors.AppTitleColor),
            fontSize: ScreenUtil().setSp(42),
          ),
        ),
        trailing: Container(
          width: ScreenUtil().setWidth(400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(_count[index]),
              Icon(
                Icons.arrow_forward_ios,
                size: ScreenUtil().setWidth(40),
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
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Text('${taskLabels[index]}',
            style: TextStyle(
                color: Color(AppColors.AppSubtitleColor),
                fontSize: ScreenUtil().setSp(32))),
        decoration: BoxDecoration(
          border:
              Border.all(color: Color(AppColors.AppSubtitleColor), width: 0.7),
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
        ),
        margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
      ),
    );
  }
}
