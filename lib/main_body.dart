import 'dart:math' as math;
import 'dart:ui';

import 'package:flash_help/auxiliary/http_setting.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_functions/log_reg/login_page.dart';
import 'package:flash_help/basic_functions/new_task_page.dart';
import 'package:flash_help/first_page/home_page.dart';
import 'package:flash_help/auxiliary/my_app_bar.dart';
import 'package:flash_help/msg_page/msg_page.dart';
import 'package:flash_help/my_page/my_page.dart';
import 'package:flash_help/near_page/near_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';

class MainBody extends StatelessWidget {
  final PageController _pageController = new PageController(initialPage: 0);

  final List<Widget> _pages = [
    new HomePage(),
    new NearPage(),
    new MsgPage(),
    new MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 2160)..init(context);
    DateTime _lastPressedAt;
    return new WillPopScope(
      onWillPop: () async {
        Toast.toast(context, '再按一次退出');
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: new Scaffold(
        body: new Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            new Material(
              child: new PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index];
                },
              ),
            ),
            new MyAppBar(
              controller: _pageController,
              navHeight: ScreenUtil().setWidth(130),
            ),
          ],
        ),
        floatingActionButton: new Container(
          margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(60)),
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setWidth(140),
          child: new FittedBox(
            child: new AddFab(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}

class AddFab extends StatefulWidget {
  @override
  _AddFabState createState() => _AddFabState();
}

class _AddFabState extends State<AddFab> with SingleTickerProviderStateMixin {
  AnimationController _controllerAnimated;
  Animation<double> _rota;
  Curve _curve = Curves.fastOutSlowIn;

  bool _isMenuOpen = false;

  List<String> _chineseCalendar = new List(2);

  @override
  initState() {
    super.initState();
    _chineseCalendar[0] = '正在联网获取农历...';
    _chineseCalendar[1] = ' ';
    _controllerAnimated = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _rota = new Tween<double>(begin: 0.0, end: 3.0).animate(CurvedAnimation(
      parent: _controllerAnimated,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    _getChineseCal();
  }

  void _getChineseCal() async {
    _chineseCalendar = await HttpSetting.getCnCalendar(context);
  }

  @override
  dispose() {
    _controllerAnimated.dispose();
    super.dispose();
  }

  _animate() {
    if (_isMenuOpen) {
      _controllerAnimated.reverse();
    } else {
      _showToolsDialog();
      _controllerAnimated.forward();
    }
    _isMenuOpen = !_isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: _controllerAnimated,
        builder: (BuildContext context, Widget child) {
          return new FloatingActionButton(
            onPressed: () {
              _animate();
            },
            child: new Transform.rotate(
              origin: Offset(0.0, 0.0),
              angle: _rota.value * math.pi / 4.0,
              child: new Icon(
                Icons.add,
                color: Color(AppColors.AppWhiteColor),
                size: ScreenUtil().setWidth(60),
              ),
            ),
          );
        });
  }

  _showToolsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Material(
          color: Color(AppColors.AppTranslateColor),
          child: new InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              _controllerAnimated.reverse();
              Navigator.pop(context);
              _isMenuOpen = false;
            },
            child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: new Scaffold(
                body: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new HelloTime(controller: _controllerAnimated, curve: _curve, data: _chineseCalendar),
                    new GridView.builder(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(300)),
                      shrinkWrap: true,
                      itemCount: 8,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, crossAxisSpacing: 2.0, childAspectRatio: 1.0, mainAxisSpacing: 2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return new ToolItem(controller: _controllerAnimated, curve: _curve, index: index);
                      },
                    ),
                  ],
                ),
                backgroundColor: Color(AppColors.AppBlackColor2),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
                floatingActionButton: new Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(60)),
                  width: ScreenUtil().setWidth(140),
                  height: ScreenUtil().setWidth(140),
                  child: new FittedBox(
                    child: new FloatingActionButton(
                      elevation: 0.0,
                      backgroundColor: Color(AppColors.AppTranslateColor),
                      child: new ShutIcon(controller: _controllerAnimated, curve: _curve),
                      onPressed: () {
                        _isMenuOpen = false;
                        _controllerAnimated.reverse();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      _controllerAnimated.reverse();
      setState(() {
        _isMenuOpen = false;
      });
    });
  }
}

class ShutIcon extends StatefulWidget {
  final AnimationController controller;
  final Curve curve;

  const ShutIcon({Key key, this.controller, this.curve}) : super(key: key);

  @override
  _ShutIconState createState() => new _ShutIconState();
}

class _ShutIconState extends State<ShutIcon> {
  Animation<double> _rota;

  get curve => widget.curve;
  get controller => widget.controller;

  @override
  void initState() {
    _rota = new Tween<double>(
      begin: 0.0,
      end: 3.0,
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.2,
          1.0,
          curve: curve,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget child) {
        return new Transform.rotate(
          angle: _rota.value * math.pi / 4.0,
          child: new Icon(
            Icons.add,
            color: Color(AppColors.AppWhiteColor),
            size: ScreenUtil().setWidth(60),
          ),
        );
      },
    );
  }
}

class ToolItem extends StatefulWidget {
  final AnimationController controller;
  final Curve curve;
  final int index;

  const ToolItem({Key key, this.controller, this.curve, this.index}) : super(key: key);

  @override
  _ToolItemState createState() => new _ToolItemState();
}

class _ToolItemState extends State<ToolItem> {
  Animation<double> _alpha;
  List<IconData> _icons = [
    Icons.add,
    Icons.visibility_off,
    Icons.brightness_4,
    Icons.color_lens,
    Boxicons.bxFullscreen,
    Icons.share,
    Icons.cancel,
    Icons.edit,
  ];
  List<String> _titles = ['发布悬赏', '隐身模式', '夜间模式', '主题颜色', '扫一扫', '分享软件', '退出软件', '编辑'];

  get curve => widget.curve;
  get controller => widget.controller;
  get index => widget.index;

  @override
  void initState() {
    _alpha = new Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.40,
        1.00,
        curve: curve,
      ),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: ScreenUtil().setWidth(140),
              height: ScreenUtil().setWidth(140),
              child: new FlatButton(
                padding: EdgeInsets.all(0),
                color: Color(AppColors.AppWhiteColor).withOpacity(_alpha.value),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                ),
                onPressed: () async {
                  controller.reverse();
                  Navigator.pop(context);
                  switch (index) {
                    case 0:
                      {
                        if (AppInfo.getLogFlag()) {
                          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                            return new NewTaskPage();
                          }));
                        } else {
                          Toast.toast(context, '请先登录');
                          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                            return new LoginPage();
                          }));
                        }
                      }
                      break;
                    case 1:
                      {
                        if (AppInfo.getLogFlag()) {
                          Toast.toast(context, '隐身模式');
                        } else {
                          Toast.toast(context, '请先登录');
                          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                            return new LoginPage();
                          }));
                        }
                      }
                      break;
                  }
                },
                child: Icon(
                  _icons[index],
                  size: ScreenUtil().setWidth(60),
                  color: Color(AppColors.AppLabelColor).withOpacity(_alpha.value),
                ),
              ),
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
            ),
            new Text(
              _titles[index],
              style: TextStyle(
                color: Color(AppColors.AppWhiteColor).withOpacity(_alpha.value),
                fontSize: ScreenUtil().setSp(30),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}

class HelloTime extends StatefulWidget {
  final AnimationController controller;
  final Curve curve;
  final List<String> data;

  const HelloTime({Key key, @required this.controller, @required this.curve, @required this.data}) : super(key: key);

  @override
  _HelloTimeState createState() => new _HelloTimeState();
}

class _HelloTimeState extends State<HelloTime> {
  Animation<double> _alpha;

  get curve => widget.curve;
  get controller => widget.controller;
  get cnCal => widget.data;

  @override
  void initState() {
    super.initState();
    _alpha = new Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.40,
        1.00,
        curve: curve,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<String> _week = ['一', '二', '三', '四', '五', '六', '日'];
    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(height: ScreenUtil().setWidth(150)),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: ScreenUtil().setWidth(60),
                  ),
                  new Text(
                    '星期${_week[DateTime.now().weekday - 1]}',
                    style: TextStyle(
                      letterSpacing: ScreenUtil().setWidth(4),
                      fontSize: ScreenUtil().setWidth(100),
                      fontWeight: FontWeight.bold,
                      color: Color(AppColors.AppWhiteColor).withOpacity(_alpha.value),
                    ),
                  ),
                  new Container(
                    width: ScreenUtil().setWidth(40),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        '${DateTime.now().year.toString().padLeft(2, '0')} / ${DateTime.now().month.toString().padLeft(2, '0')} / ${DateTime.now().day.toString().padLeft(2, '0')} ${cnCal[1]}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setWidth(50),
                          fontWeight: FontWeight.bold,
                          color: Color(AppColors.AppWhiteColor).withOpacity(_alpha.value),
                        ),
                      ),
                      new Text(
                        cnCal[0],
                        style: TextStyle(
                          fontSize: ScreenUtil().setWidth(30),
                          fontWeight: FontWeight.bold,
                          color: Color(AppColors.AppWhiteColor).withOpacity(_alpha.value),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
