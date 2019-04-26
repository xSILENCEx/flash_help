import 'dart:math' as math;

import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_functions/log_reg/login_page.dart';
import 'package:flash_help/first_page/detail_page/personal_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_words/english_words.dart';
import 'package:photo_view/photo_view.dart';

class TaskDetailPage extends StatefulWidget {
  final String pictureTag;
  final String reward;

  const TaskDetailPage(
      {Key key, @required this.pictureTag, @required this.reward})
      : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  String get _picTag => widget.pictureTag;
  String get _reward => widget.reward;

  String _name;

  List<String> _taskLabels = [
    '取件',
    '外卖',
    '洗衣',
    '排队',
    '功课',
    '修图',
    '手工',
    '代购',
    '其它'
  ];

  List<String> _pictureUrl = [
    'images/task_main.jpeg',
    'images/task_2.jpg',
    'images/task_3.jpg'
  ];

  int _talkCount = 5;

  @override
  void initState() {
    _name = WordPair.random().asPascalCase;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(AppColors.AppDeepColor),
        appBar: AppBar(
          backgroundColor: Color(AppColors.AppMainColor),
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtil().setWidth(50),
              color: Color(AppColors.AppTitleColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            '￥$_reward',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(50),
              color: Color(AppColors.AppTitleColor),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
                size: ScreenUtil().setWidth(54),
                color: Color(AppColors.AppTitleColor),
              ),
              onPressed: () {
                Toast.toast(context, '更多');
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              color: Color(AppColors.AppMainColor),
              child: ListTile(
                dense: true,
                leading: Hero(
                  tag: 'headpicture',
                  child: Container(
                    width: ScreenUtil().setWidth(140),
                    height: ScreenUtil().setWidth(140),
                    decoration: BoxDecoration(
                      color: Color(AppColors.AppDeepColor),
                      borderRadius:
                          BorderRadius.circular(AppStyle.appRadius * 40),
                      image: DecorationImage(
                        image: AssetImage(AppStyle.userPicture1),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  _name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(AppColors.AppTitleColor),
                  ),
                ),
                subtitle: Text(
                  '这个人很懒，什么都没有留下',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(AppColors.AppSubtitleColor),
                    fontSize: ScreenUtil().setSp(35),
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Text(
                    '在线',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(35),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppThemeColor),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  top: ScreenUtil().setWidth(10),
                  bottom: ScreenUtil().setWidth(10),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return PersonalPage(
                      headTag: 'headpicture',
                      name: _name,
                      headUrl: null,
                    );
                  }));
                },
              ),
            ),
            _buildTaskDetailItem(),
            Container(
              color: Color(AppColors.AppMainColor),
              height: ScreenUtil().setWidth(600),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setWidth(30)),
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: _pictureUrl.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Hero(
                      tag: _picTag,
                      child: _pictureBuilder(_pictureUrl[index], index),
                    );
                  }
                  return _pictureBuilder(_pictureUrl[index], index);
                },
              ),
            ),
            Container(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(100)),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _talkCount,
                itemBuilder: (BuildContext context, int index) {
                  return _buildTalkItem(index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Color(AppColors.AppDeepColor),
                    height: ScreenUtil().setWidth(2),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(30),
                        right: ScreenUtil().setWidth(30)),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: double.parse(ScreenUtil().setWidth(20).toString()),
          shape: CircularNotchedRectangle(),
          child: BottomItems(),
        ),
        floatingActionButton: Container(
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setWidth(140),
          child: FittedBox(
            child: ThreeStateFab(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
      onWillPop: () {
        Navigator.pop(context);
      },
    );
  }

  _pictureBuilder(String url, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Hero(
          tag: "p$index",
          child: Container(
            width: 300,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppStyle.appRadius),
              image: DecorationImage(
                image: AssetImage(url),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return PictureDetail(index: index, url: _pictureUrl[index]);
          }));
        },
      ),
    );
  }

  _buildTaskItem(int index) {
    return Container(
      alignment: Alignment.center,
      child: Text('${_taskLabels[index]}',
          style: TextStyle(
              color: Color(AppColors.AppMainColor),
              fontSize: ScreenUtil().setSp(35))),
      decoration: BoxDecoration(
        color: Color(AppColors.AppDotColor),
        borderRadius: BorderRadius.circular(AppStyle.appRadius / 4),
      ),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(6),
        right: ScreenUtil().setWidth(6),
      ),
    );
  }

  _buildTaskDetailItem() {
    var _pickTime = DateTime.now();
    return Container(
      color: Color(AppColors.AppMainColor),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(30),
        right: ScreenUtil().setWidth(30),
        top: ScreenUtil().setWidth(30),
        bottom: ScreenUtil().setWidth(50),
      ),
      margin: EdgeInsets.only(
        top: ScreenUtil().setWidth(30),
        bottom: ScreenUtil().setWidth(30),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
            child: Text(
              '任务标题  任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Color(AppColors.AppSubtitleColor),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(AppColors.AppDeepColor),
              borderRadius: BorderRadius.circular(AppStyle.appRadius),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                '现金任务',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(40),
                  color: Color(AppColors.AppTitleColor),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                    top: ScreenUtil().setWidth(20),
                    bottom: ScreenUtil().setWidth(20),
                  ),
                  alignment: Alignment.center,
                  height: ScreenUtil().setWidth(120),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(35),
                        bottom: ScreenUtil().setWidth(35)),
                    itemCount: _taskLabels.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTaskItem(index);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '截止时间',
                style: TextStyle(
                  color: Color(AppColors.AppTitleColor),
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
              _dateBuilder(_pickTime, ScreenUtil().setSp(40)),
            ],
          ),
        ],
      ),
    );
  }

  _dateBuilder(DateTime date, double fontSize) {
    return Text(
      '${date.year} 年 '
          '${date.month.toString().padLeft(2, '0')} 月 '
          '${date.day.toString().padLeft(2, '0')} 日 '
          '${date.hour.toString().padLeft(2, '0')}:'
          '${date.minute.toString().padLeft(2, '0')}:'
          '${date.second.toString().padLeft(2, '0')}',
      style: TextStyle(
        fontSize: fontSize,
        color: Color(
          AppColors.AppSubtitleColor,
        ),
      ),
    );
  }

  _buildTalkItem(int index) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(20),
        bottom: ScreenUtil().setWidth(20),
      ),
      color: Color(AppColors.AppMainColor),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setWidth(80),
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppDeepColor),
                    borderRadius:
                        BorderRadius.circular(AppStyle.appRadius * 40),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '留言用户$index',
                      style: TextStyle(
                        color: Color(AppColors.AppTitleColor),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                    _dateBuilder(DateTime.now(), ScreenUtil().setSp(32)),
                  ],
                ),
              ],
            ),
            Container(
              width: ScreenUtil().setWidth(120),
              height: ScreenUtil().setWidth(60),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyle.appRadius * 10),
                ),
                padding: EdgeInsets.all(0),
                color: Color(AppColors.AppThemeColor),
                child: Text(
                  '关注',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color(AppColors.AppMainColor),
                  ),
                ),
                onPressed: () {
                  Toast.toast(context, '关注$index');
                },
              ),
            ),
          ],
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
          child: Text(
            '哈哈哈哈哈哈哈嘎嘎嘎嘎嘎嘎啊嘎嘎嘎嘎哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈，这是什么沙雕软件',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(38),
              color: Color(AppColors.AppSubtitleColor),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(AppColors.AppDeepColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius),
          ),
        ),
        contentPadding: EdgeInsets.all(ScreenUtil().setWidth(30)),
      ),
    );
  }
}

class PictureDetail extends StatelessWidget {
  final int index;
  final String url;

  const PictureDetail({Key key, this.index, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Center(
              child: PhotoView(
                heroTag: "p$index",
                imageProvider: AssetImage(url),
                minScale: 0.1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(200)),
                  width: ScreenUtil().setWidth(280),
                  height: ScreenUtil().setWidth(90),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.appRadius),
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Toast.toast(context, '查看原图');
                    },
                    child: Text(
                      '查看原图',
                      style: TextStyle(
                        color: Color(AppColors.AppMainColor),
                        fontSize: ScreenUtil().setSp(42),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(AppColors.AppMainColor),
                        width: ScreenUtil().setWidth(2)),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(200)),
                  width: ScreenUtil().setWidth(280),
                  height: ScreenUtil().setWidth(90),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.appRadius),
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Toast.toast(context, '下载图片');
                    },
                    child: Text(
                      '下载图片',
                      style: TextStyle(
                        color: Color(AppColors.AppMainColor),
                        fontSize: ScreenUtil().setSp(42),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(AppColors.AppMainColor),
                        width: ScreenUtil().setWidth(2)),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () async {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ThreeStateFab extends StatefulWidget {
  @override
  _ThreeStateFabState createState() => _ThreeStateFabState();
}

class _ThreeStateFabState extends State<ThreeStateFab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<Color> _iconColor;
  Animation<Color> _proColor;
  Animation<double> _iconSize;
  Animation<double> _rotaIcon;
  Curve _curve = Curves.linear;

  bool _isAcceptProgress = false;
  bool _isAccept = false;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _iconSize = Tween<double>(
            begin: ScreenUtil().setWidth(60), end: ScreenUtil().setWidth(40))
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.80,
        curve: _curve,
      ),
    ));

    _iconColor = ColorTween(
            begin: Color(AppColors.AppMainColor),
            end: Color(AppColors.AppThemeColor))
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.80,
        curve: _curve,
      ),
    ));

    _proColor = ColorTween(
            begin: Color(AppColors.AppThemeColor),
            end: Color(AppColors.AppMainColor))
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.20,
        1.00,
        curve: _curve,
      ),
    ));

    _rotaIcon = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.80,
        curve: _curve,
      ),
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _progressTime() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('accept');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return FloatingActionButton(
          backgroundColor: Color(AppColors.AppThemeColor),
          onPressed: () async {
            if (AppInfo.getLogFlag()) {
              if (_isAccept)
                Toast.toast(context, '此悬赏已被锁定');
              else {
                await _animationController.forward();
                setState(() {
                  _isAcceptProgress = true;
                });
                await _progressTime();

                setState(() {
                  _isAccept = true;
                  _isAcceptProgress = false;
                });
                await _animationController.reverse();
                Toast.toast(context, '已加入清单');
              }
            } else {
              Toast.toast(context, '请先登录');
              Future.delayed(const Duration(milliseconds: 1000), () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return LoginPage();
                }));
              });
            }
          },
          isExtended: false,
          child: Transform.rotate(
            origin: Offset(0.0, 0.0),
            angle: _rotaIcon.value * math.pi * 1.5,
            child: _isAcceptProgress
                ? _buildProgress(_proColor)
                : Icon(
                    _isAccept ? Icons.check : Icons.assistant_photo,
                    size: _iconSize.value,
                    color: _iconColor.value,
                  ),
          ),
        );
      },
    );
  }

  _buildProgress(Animation<Color> color) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: ScreenUtil().setWidth(60),
        height: ScreenUtil().setWidth(60),
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              color.value,
            ),
            strokeWidth: 2),
      ),
    );
  }
}

class BottomItems extends StatefulWidget {
  @override
  _BottomItemsState createState() => _BottomItemsState();
}

class _BottomItemsState extends State<BottomItems> {
  int _likeCount = 99;
  int _starCount = 99;
  int _talkCount = 10;
  int _shareCount = 99;

  bool _isLiked = false;
  bool _isStared = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(150),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(260)),
      child: Row(
        children: <Widget>[
          Flexible(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _isLiked ? _likeCount-- : _likeCount++;
                  _isLiked = !_isLiked;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(_isLiked ? Boxicons.bxsLike : Boxicons.bxLike,
                        color: Color(_isLiked
                            ? AppColors.AppThemeColor
                            : AppColors.AppSubtitleColor),
                        size: ScreenUtil().setWidth(50)),
                    Container(width: ScreenUtil().setWidth(20)),
                    Text('99+',
                        style: TextStyle(
                            color: Color(AppColors.AppSubtitleColor),
                            fontSize: ScreenUtil().setSp(36))),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          Flexible(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _isStared ? _starCount-- : _starCount++;
                  _isStared = !_isStared;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(_isStared ? Boxicons.bxsStar : Boxicons.bxStar,
                        color: Color(_isStared
                            ? AppColors.AppThemeColor
                            : AppColors.AppSubtitleColor),
                        size: ScreenUtil().setWidth(60)),
                    Container(width: ScreenUtil().setWidth(20)),
                    Text('99+',
                        style: TextStyle(
                            color: Color(AppColors.AppSubtitleColor),
                            fontSize: ScreenUtil().setSp(36))),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          Flexible(
            child: FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.textsms,
                      size: ScreenUtil().setWidth(50),
                      color: Color(AppColors.AppSubtitleColor),
                    ),
                    Container(width: ScreenUtil().setWidth(20)),
                    Text('99+',
                        style: TextStyle(
                            color: Color(AppColors.AppSubtitleColor),
                            fontSize: ScreenUtil().setSp(36))),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          Flexible(
            child: FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.share,
                      size: ScreenUtil().setWidth(50),
                      color: Color(AppColors.AppSubtitleColor),
                    ),
                    Container(width: ScreenUtil().setWidth(20)),
                    Text('99+',
                        style: TextStyle(
                            color: Color(AppColors.AppSubtitleColor),
                            fontSize: ScreenUtil().setSp(36))),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
