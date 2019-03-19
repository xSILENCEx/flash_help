import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/arc_clipper.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalPage extends StatefulWidget {
  final String headTag;
  final String name;
  final String headUrl;

  const PersonalPage({Key key, @required this.headTag, @required this.name, @required this.headUrl}) : super(key: key);

  @override
  _PersonalPageState createState() => new _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  String get _headTag => widget.headTag;
  String get _name => widget.name;
  String get _headUrl => widget.headUrl;

  bool _isConcern = false;
  int _concernCount = 201;

  List<String> _taskLabels = ['取件', '外卖', '洗衣', '排队', '功课', '修图', '手工', '代购', '其它'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        backgroundColor: Color(AppColors.AppDeepColor),
        body: new NestedScrollView(
          headerSliverBuilder: _sliverBuilder,
          body: new Column(
            children: <Widget>[
              new Container(
                child: new TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Color(AppColors.AppLabelColor),
                  labelStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(40),
                  ),
                  tabs: [
                    Tab(text: '发布的悬赏'),
                    Tab(text: '获得的评价'),
                  ],
                ),
                color: Color(AppColors.AppWhiteColor),
              ),
              new Flexible(
                child: new TabBarView(
                  children: [
                    new Container(
                      child: new Center(child: new Text('暂无悬赏数据')),
                      color: Color(AppColors.AppDeepColor),
                    ),
                    new Container(
                      child: new Center(child: new Text('暂无评论数据')),
                      color: Color(AppColors.AppDeepColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: new Container(
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setWidth(140),
          child: new FittedBox(
            child: new FloatingActionButton(
              elevation: 2.0,
              backgroundColor: Color(AppColors.AppLabelColor),
              child: new Icon(
                Icons.chat_bubble_outline,
                color: Color(AppColors.AppWhiteColor),
                size: ScreenUtil().setWidth(60),
              ),
              onPressed: () {
                Toast.toast(context, '发起会话');
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showMoreFunctions(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
            color: Colors.transparent,
            child: new InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Flexible(child: new Container()),
                  new Container(
                    color: Color(AppColors.AppWhiteColor),
                    child: new GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return _buildMoreItem(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _buildMoreItem(int index) {
    List<String> titles = ['加入黑名单', '举报', '分享', '相册', '邮箱', '拨号'];
    List<IconData> icons = [
      Icons.do_not_disturb_on,
      Icons.pan_tool,
      Icons.share,
      Icons.photo,
      Icons.mail_outline,
      Icons.phone,
    ];
    return new Column(
      children: <Widget>[
        new Container(
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setWidth(140),
          decoration: BoxDecoration(
            color: Color(AppColors.AppLabelColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          child: new FlatButton(
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
            ),
            onPressed: () {
              Navigator.pop(context);
              Toast.toast(context, titles[index]);
            },
            child: new Icon(
              icons[index],
              color: Color(AppColors.AppWhiteColor),
              size: ScreenUtil().setWidth(50),
            ),
          ),
        ),
        new Text(
          titles[index],
          style: TextStyle(
            color: Color(AppColors.AppTextColor2),
            fontSize: ScreenUtil().setSp(38),
          ),
        ),
      ],
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      new SliverAppBar(
        brightness: Brightness.dark,
        expandedHeight: ScreenUtil().setWidth(830),
        elevation: 0.0,
        centerTitle: true,
        pinned: true,
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
        title: new Text(
          _name,
          style: TextStyle(
            color: Color(AppColors.AppWhiteColor),
            fontSize: ScreenUtil().setSp(55),
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Color(AppColors.AppWhiteColor),
              size: ScreenUtil().setWidth(60),
            ),
            onPressed: () {
              _showMoreFunctions(context);
            },
          ),
        ],
        flexibleSpace: new FlexibleSpaceBar(
          centerTitle: true,
          collapseMode: CollapseMode.parallax,
          background: new Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              new Container(
                color: Color(AppColors.AppWhiteColor),
                width: double.infinity,
                height: double.infinity,
              ),
              new ClipPath(
                clipper: new ArcClipper(),
                child: new Container(
                  height: ScreenUtil().setWidth(460),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(_headUrl == null ? AppStyle.userPicture1 : _headUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 20.0, sigmaX: 20.0),
                    child: new Container(
                      color: Color(AppColors.AppBlackColor2),
                    ),
                  ),
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Hero(
                    tag: _headTag,
                    child: new Container(
                      width: ScreenUtil().setWidth(170),
                      height: ScreenUtil().setWidth(170),
                      decoration: BoxDecoration(
                        color: Color(AppColors.AppDeepColor),
                        borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                        image: DecorationImage(
                          image: AssetImage(_headUrl == null ? AppStyle.userPicture1 : _headUrl),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Color(AppColors.AppWhiteColor), width: 2),
                      ),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: new Text('已实名', style: TextStyle(fontSize: ScreenUtil().setSp(35), color: Color(AppColors.AppWhiteColor))),
                        decoration: BoxDecoration(
                          color: Color(AppColors.AppLabelColor),
                          borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
                        ),
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(10),
                          right: ScreenUtil().setWidth(10),
                        ),
                        margin: EdgeInsets.only(top: ScreenUtil().setWidth(15), bottom: ScreenUtil().setWidth(20)),
                      ),
                      new Container(
                        child: new Text('信用度 : 77', style: TextStyle(fontSize: ScreenUtil().setSp(35), color: Color(AppColors.AppWhiteColor))),
                        decoration: BoxDecoration(
                          color: Color(AppColors.AppLabelColor2),
                          borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
                        ),
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(10),
                          right: ScreenUtil().setWidth(10),
                        ),
                        margin: EdgeInsets.only(top: ScreenUtil().setWidth(15), left: ScreenUtil().setWidth(15), bottom: ScreenUtil().setWidth(20)),
                      ),
                    ],
                  ),
                  new Text(
                    '这个人很懒，什么都没有留下',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setWidth(90),
                    child: new ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                      itemCount: _taskLabels.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildTaskItem(index);
                      },
                    ),
                  ),
                  new Container(
                    height: ScreenUtil().setWidth(70),
                    child: new FlatButton(
                      onPressed: () {
                        if (_isConcern) {
                          _concernCount--;
                          Toast.toast(context, '取消关注');
                        } else {
                          _concernCount++;
                          Toast.toast(context, '关注成功');
                        }
                        setState(() {
                          _isConcern = !_isConcern;
                        });
                      },
                      child: Text(
                        _isConcern ? '粉丝$_concernCount  + 取关' : '粉丝201  + 关注',
                        style:
                            TextStyle(color: Color(_isConcern ? AppColors.AppWhiteColor : AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(32)),
                      ),
                      color: Color(_isConcern ? AppColors.AppLabelColor : AppColors.AppTranslateColor),
                      padding: EdgeInsets.only(left: 3, right: 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppStyle.appRadius / 3),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(_isConcern ? AppColors.AppLabelColor : AppColors.AppTextColor1)),
                      borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
                    ),
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(20)),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Color(AppColors.AppLabelColor),
      ),
    ];
  }

  _buildTaskItem(int index) {
    return new Container(
      alignment: Alignment.center,
      child: new Text('${_taskLabels[index]}', style: TextStyle(color: Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(32))),
      decoration: BoxDecoration(
        border: Border.all(color: Color(AppColors.AppTextColor1), width: 0.7),
        borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
      ),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
    );
  }
}
