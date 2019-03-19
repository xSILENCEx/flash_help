import 'dart:math' as math;

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

  const TaskDetailPage({Key key, @required this.pictureTag, @required this.reward}) : super(key: key);

  @override
  _TaskDetailPageState createState() => new _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  String get _picTag => widget.pictureTag;
  String get _reward => widget.reward;

  String _name;

  List<String> _taskLabels = ['取件', '外卖', '洗衣', '排队', '功课', '修图', '手工', '代购', '其它'];

  List<String> _pictureUrl = ['images/task_main.jpeg', 'images/task_2.jpg', 'images/task_3.jpg'];

  int _talkCount = 5;

  @override
  void initState() {
    _name = WordPair.random().asPascalCase;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
        appBar: new AppBar(
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0.5,
          leading: new IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtil().setWidth(60),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: new Text(
            '￥$_reward',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(55),
              color: Color(AppColors.AppTextColor2),
            ),
          ),
          actions: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.more_vert,
                size: ScreenUtil().setWidth(60),
              ),
              onPressed: () {
                Toast.toast(context, '更多');
              },
            )
          ],
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              dense: true,
              leading: new Hero(
                tag: 'headpicture',
                child: new Container(
                  width: ScreenUtil().setWidth(140),
                  height: ScreenUtil().setWidth(140),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppDeepColor),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                    image: DecorationImage(
                      image: AssetImage(AppStyle.userPicture1),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Color(AppColors.AppWhiteColor), width: 2),
                  ),
                ),
              ),
              title: new Text(
                _name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: new Text('这个人很懒，什么都没有留下'),
              trailing: new Container(
                padding: new EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: new Text('在线', style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(35))),
                decoration: new BoxDecoration(color: Color(AppColors.AppLabelColor), borderRadius: BorderRadius.circular(AppStyle.appRadius / 4)),
              ),
              contentPadding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setWidth(10),
                bottom: ScreenUtil().setWidth(10),
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new PersonalPage(
                    headTag: 'headpicture',
                    name: _name,
                    headUrl: null,
                  );
                }));
              },
            ),
            _buildInterval(),
            _buildTaskDetailItem(),
            _buildInterval(),
            new Container(
              color: Color(AppColors.AppWhiteColor),
              height: ScreenUtil().setWidth(600),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: _pictureUrl.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return new Hero(
                      tag: _picTag,
                      child: _pictureBuilder(_pictureUrl[index], index),
                    );
                  }
                  return _pictureBuilder(_pictureUrl[index], index);
                },
              ),
            ),
            _buildInterval(),
            new Container(
              child: new ListView.separated(
                padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(100)),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _talkCount,
                itemBuilder: (BuildContext context, int index) {
                  return _buildTalkItem(index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return new Container(
                    color: Color(AppColors.AppDeepColor),
                    height: ScreenUtil().setWidth(4),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: new BottomAppBar(
          notchMargin: double.parse(ScreenUtil().setWidth(20).toString()),
          shape: CircularNotchedRectangle(),
          child: new BottomItems(),
        ),
        floatingActionButton: new Container(
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setWidth(140),
          child: new FittedBox(
            child: new ThreeStateFab(),
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
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: new Hero(
          tag: "p$index",
          child: new Container(
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
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
            return new PictureDetail(index: index, url: _pictureUrl[index]);
          }));
        },
      ),
    );
  }

  _buildTaskItem(int index) {
    return new Container(
      alignment: Alignment.center,
      child: new Text('${_taskLabels[index]}', style: TextStyle(color: Color(AppColors.AppWhiteColor), fontSize: ScreenUtil().setSp(35))),
      decoration: BoxDecoration(
        color: Color(AppColors.AppLabelColor2),
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
    return new Container(
      color: Color(AppColors.AppWhiteColor),
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            child: new Text(
              '任务标题  任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务',
              style: TextStyle(fontSize: ScreenUtil().setSp(38)),
            ),
            decoration: BoxDecoration(
              color: Color(AppColors.AppDeepColor),
              borderRadius: BorderRadius.circular(AppStyle.appRadius),
            ),
          ),
          new Row(
            children: <Widget>[
              new Text('现金任务', style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(40))),
              new Flexible(
                child: new Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  alignment: Alignment.center,
                  height: ScreenUtil().setWidth(120),
                  child: new ListView.builder(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(35), bottom: ScreenUtil().setWidth(35)),
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
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('发布时间', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
              _dateBuilder(_pickTime, ScreenUtil().setSp(40)),
            ],
          ),
          new Container(
            width: double.infinity,
            height: 0.5,
            color: Color(AppColors.AppBorderColor),
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(28), bottom: ScreenUtil().setWidth(28)),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('剩余时间', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
              new Text('无限制', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
            ],
          ),
        ],
      ),
    );
  }

  _dateBuilder(DateTime date, double fontSize) {
    return new Text(
      '${date.year} 年 '
          '${date.month.toString().padLeft(2, '0')} 月 '
          '${date.day.toString().padLeft(2, '0')} 日 '
          '${date.hour.toString().padLeft(2, '0')}:'
          '${date.minute.toString().padLeft(2, '0')}:'
          '${date.second.toString().padLeft(2, '0')}',
      style: TextStyle(fontSize: fontSize),
    );
  }

  _buildInterval() {
    return new Container(
      height: 20,
      color: Color(AppColors.AppDeepColor),
    );
  }

  _buildTalkItem(int index) {
    return new ListTile(
      title: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            width: ScreenUtil().setWidth(80),
            height: ScreenUtil().setWidth(80),
            decoration: BoxDecoration(
              color: Color(AppColors.AppDeepColor),
              borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              border: Border.all(
                color: Color(AppColors.AppBorderColor),
              ),
            ),
          ),
          new Text('  留言用户$index   ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(40))),
          _dateBuilder(new DateTime.now(), ScreenUtil().setSp(32)),
        ],
      ),
      subtitle: new Container(
        margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
        padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
        child: new Text(
          '哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎啊嘎嘎嘎嘎哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈，这是什么沙雕软件',
          style: TextStyle(fontSize: ScreenUtil().setSp(38)),
        ),
        decoration: BoxDecoration(
          color: Color(AppColors.AppDeepColor),
          borderRadius: BorderRadius.circular(AppStyle.appRadius),
        ),
      ),
      contentPadding: EdgeInsets.all(ScreenUtil().setWidth(20)),
    );
  }
}

class PictureDetail extends StatelessWidget {
  final int index;
  final String url;

  const PictureDetail({Key key, this.index, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: new Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            new Center(
              child: new PhotoView(
                heroTag: "p$index",
                imageProvider: AssetImage(url),
                minScale: 0.1,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(200)),
                  width: ScreenUtil().setWidth(280),
                  height: ScreenUtil().setWidth(90),
                  child: new FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.appRadius),
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Toast.toast(context, '查看原图');
                    },
                    child: new Text(
                      '查看原图',
                      style: TextStyle(
                        color: Color(AppColors.AppWhiteColor),
                        fontSize: ScreenUtil().setSp(42),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(AppColors.AppWhiteColor), width: ScreenUtil().setWidth(2)),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(200)),
                  width: ScreenUtil().setWidth(280),
                  height: ScreenUtil().setWidth(90),
                  child: new FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.appRadius),
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Toast.toast(context, '下载图片');
                    },
                    child: new Text(
                      '下载图片',
                      style: TextStyle(
                        color: Color(AppColors.AppWhiteColor),
                        fontSize: ScreenUtil().setSp(42),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(AppColors.AppWhiteColor), width: ScreenUtil().setWidth(2)),
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

class _ThreeStateFabState extends State<ThreeStateFab> with SingleTickerProviderStateMixin {
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
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _iconSize = new Tween<double>(begin: ScreenUtil().setWidth(60), end: ScreenUtil().setWidth(40)).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.80,
        curve: _curve,
      ),
    ));

    _iconColor = new ColorTween(begin: Color(AppColors.AppWhiteColor), end: Color(AppColors.AppLabelColor)).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.80,
        curve: _curve,
      ),
    ));

    _proColor = new ColorTween(begin: Color(AppColors.AppLabelColor), end: Color(AppColors.AppWhiteColor)).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.20,
        1.00,
        curve: _curve,
      ),
    ));

    _rotaIcon = new Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
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
    return new AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return new FloatingActionButton(
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
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new LoginPage();
                }));
              });
            }
          },
          isExtended: false,
          child: new Transform.rotate(
            origin: Offset(0.0, 0.0),
            angle: _rotaIcon.value * math.pi * 1.5,
            child: _isAcceptProgress
                ? _buildProgress(_proColor)
                : new Icon(
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
    return new Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: ScreenUtil().setWidth(60),
        height: ScreenUtil().setWidth(60),
        child: new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              color.value,
            ),
            strokeWidth: 3),
      ),
    );
  }
}

class BottomItems extends StatefulWidget {
  @override
  _BottomItemsState createState() => new _BottomItemsState();
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
    return new Container(
      height: ScreenUtil().setWidth(150),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(260)),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new FlatButton(
              onPressed: () {
                setState(() {
                  _isLiked ? _likeCount-- : _likeCount++;
                  _isLiked = !_isLiked;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: new Container(
                width: double.infinity,
                height: double.infinity,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.thumb_up,
                        color: Color(_isLiked ? AppColors.AppLabelColor : AppColors.AppTextColor1), size: ScreenUtil().setWidth(50)),
                    new Container(width: ScreenUtil().setWidth(20)),
                    new Text('99+', style: TextStyle(color: Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(36))),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          new Flexible(
            child: new FlatButton(
              onPressed: () {
                setState(() {
                  _isStared ? _starCount-- : _starCount++;
                  _isStared = !_isStared;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: new Container(
                width: double.infinity,
                height: double.infinity,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(_isStared ? Icons.star : Icons.star_border,
                        color: Color(_isStared ? AppColors.AppLabelColor : AppColors.AppTextColor1), size: ScreenUtil().setWidth(50)),
                    new Container(width: ScreenUtil().setWidth(20)),
                    new Text('99+', style: TextStyle(color: Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(36))),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          new Flexible(
            child: new FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: new Container(
                width: double.infinity,
                height: double.infinity,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.textsms, size: ScreenUtil().setWidth(50)),
                    new Container(width: ScreenUtil().setWidth(20)),
                    new Text('99+', style: TextStyle(color: Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(36))),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ),
          new Flexible(
            child: new FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: new Container(
                width: double.infinity,
                height: double.infinity,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.share, size: ScreenUtil().setWidth(50)),
                    new Container(width: ScreenUtil().setWidth(20)),
                    new Text('99+', style: TextStyle(color: Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(36))),
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
