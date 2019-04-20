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
import 'package:barcode_scan/barcode_scan.dart';

class MainBody extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    HomePage(),
    NearPage(),
    MsgPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 2160)..init(context);
    DateTime _lastPressedAt;
    return WillPopScope(
      onWillPop: () async {
        Toast.toast(context, '再按一次退出');
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Material(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index];
                },
              ),
            ),
            MyAppBar(
              controller: _pageController,
              navHeight: ScreenUtil().setWidth(130),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(60)),
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setWidth(140),
          child: FittedBox(
            child: AddFab(),
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

  List<String> _chineseCalendar = List(2);

  @override
  initState() {
    super.initState();
    _chineseCalendar[0] = '正在联网获取农历...';
    _chineseCalendar[1] = ' ';
    _controllerAnimated =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _rota = Tween<double>(begin: 0.0, end: 3.0).animate(CurvedAnimation(
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
    return AnimatedBuilder(
      animation: _controllerAnimated,
      builder: (BuildContext context, Widget child) {
        return FloatingActionButton(
          onPressed: () {
            _animate();
          },
          child: Transform.rotate(
            origin: Offset(0.0, 0.0),
            angle: _rota.value * math.pi / 4.0,
            child: Icon(
              Icons.add,
              color: Color(AppColors.AppMainColor),
              size: ScreenUtil().setWidth(60),
            ),
          ),
          backgroundColor: Color(AppColors.AppThemeColor),
        );
      },
    );
  }

  _showToolsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              _controllerAnimated.reverse();
              Navigator.pop(context);
              _isMenuOpen = false;
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HelloTime(
                        controller: _controllerAnimated,
                        curve: _curve,
                        data: _chineseCalendar),
                    GridView.builder(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setWidth(300)),
                      shrinkWrap: true,
                      itemCount: 8,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 2.0,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return ToolItem(
                            controller: _controllerAnimated,
                            curve: _curve,
                            index: index);
                      },
                    ),
                  ],
                ),
                backgroundColor: Color(AppColors.AppMaskColor),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButtonAnimator:
                    FloatingActionButtonAnimator.scaling,
                floatingActionButton: Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(60)),
                  width: ScreenUtil().setWidth(140),
                  height: ScreenUtil().setWidth(140),
                  child: FittedBox(
                    child: FloatingActionButton(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      child: ShutIcon(
                          controller: _controllerAnimated, curve: _curve),
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
  _ShutIconState createState() => _ShutIconState();
}

class _ShutIconState extends State<ShutIcon> {
  Animation<double> _rota;

  get curve => widget.curve;
  get controller => widget.controller;

  @override
  void initState() {
    _rota = Tween<double>(
      begin: 0.0,
      end: 3.0,
    ).animate(
      CurvedAnimation(
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
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: _rota.value * math.pi / 4.0,
          child: Icon(
            Icons.add,
            color: Color(AppColors.AppMainColor),
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

  const ToolItem({Key key, this.controller, this.curve, this.index})
      : super(key: key);

  @override
  _ToolItemState createState() => _ToolItemState();
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
  List<String> _titles = [
    '发布悬赏',
    '隐身模式',
    '夜间模式',
    '主题颜色',
    '扫一扫',
    '分享软件',
    '退出软件',
    '编辑'
  ];
  String _barcode = "";

  get curve => widget.curve;
  get controller => widget.controller;
  get index => widget.index;

  @override
  void initState() {
    _alpha = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.40,
        1.00,
        curve: curve,
      ),
    ));
    super.initState();
  }

  Future _scan() async {
    Toast.toast(context, '暂未开放');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(140),
              height: ScreenUtil().setWidth(140),
              child: FlatButton(
                padding: EdgeInsets.all(0),
                color: Color(AppColors.AppMainColor).withOpacity(_alpha.value),
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return NewTaskPage();
                          }));
                        } else {
                          Toast.toast(context, '请先登录');
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return LoginPage();
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return LoginPage();
                          }));
                        }
                      }
                      break;
                    case 4:
                      {
                        await _scan();
                      }
                      break;
                    default:
                      {
                        Toast.toast(context, '暂未开放');
                      }
                  }
                },
                child: Icon(
                  _icons[index],
                  size: ScreenUtil().setWidth(60),
                  color:
                      Color(AppColors.AppThemeColor).withOpacity(_alpha.value),
                ),
              ),
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
            ),
            Text(
              _titles[index],
              style: TextStyle(
                color: Color(AppColors.AppMainColor).withOpacity(_alpha.value),
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

  const HelloTime(
      {Key key,
      @required this.controller,
      @required this.curve,
      @required this.data})
      : super(key: key);

  @override
  _HelloTimeState createState() => _HelloTimeState();
}

class _HelloTimeState extends State<HelloTime> {
  Animation<double> _alpha;

  get curve => widget.curve;
  get controller => widget.controller;
  get cnCal => widget.data;

  @override
  void initState() {
    super.initState();
    _alpha = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
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
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(height: ScreenUtil().setWidth(150)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(60),
                  ),
                  Text(
                    '星期${_week[DateTime.now().weekday - 1]}',
                    style: TextStyle(
                      letterSpacing: ScreenUtil().setWidth(4),
                      fontSize: ScreenUtil().setWidth(100),
                      fontWeight: FontWeight.bold,
                      color: Color(AppColors.AppMainColor)
                          .withOpacity(_alpha.value),
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(40),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${DateTime.now().year.toString().padLeft(2, '0')} / ${DateTime.now().month.toString().padLeft(2, '0')} / ${DateTime.now().day.toString().padLeft(2, '0')} ${cnCal[1]}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setWidth(50),
                          fontWeight: FontWeight.bold,
                          color: Color(AppColors.AppMainColor)
                              .withOpacity(_alpha.value),
                        ),
                      ),
                      Text(
                        cnCal[0],
                        style: TextStyle(
                          fontSize: ScreenUtil().setWidth(30),
                          fontWeight: FontWeight.bold,
                          color: Color(AppColors.AppMainColor)
                              .withOpacity(_alpha.value),
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
