import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/arc_clipper.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';

class MyAppBar extends StatefulWidget {
  final double navHeight;
  final PageController controller;

  const MyAppBar({Key key, @required this.navHeight, @required this.controller}) : super(key: key);

  @override
  _MyAppBar createState() => new _MyAppBar();
}

class _MyAppBar extends State<MyAppBar> with TickerProviderStateMixin {
  double get _navHeight => widget.navHeight;
  PageController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipShadowPath(
      clipper: new BottomClipper(),
      child: new Container(
        decoration: BoxDecoration(
          color: Color(AppColors.AppWhiteColor),
        ),
        alignment: Alignment.center,
        height: _navHeight,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new NavItem(
              index: 0,
              icon: Boxicons.bxHomeAlt,
              actIcon: Boxicons.bxsHomeAlt,
              title: '首页',
              controller: _controller,
              onPressed: () {
                _controller.jumpToPage(0);
                setState(() {});
              },
            ),
            new NavItem(
              index: 1,
              icon: Boxicons.bxCompass,
              actIcon: Boxicons.bxsCompass,
              title: '附近',
              controller: _controller,
              onPressed: () {
                _controller.jumpToPage(1);
                setState(() {});
              },
            ),
            new Flexible(child: new Container()),
            new NavItem(
              index: 2,
              icon: Boxicons.bxMessageRounded,
              actIcon: Boxicons.bxsMessageRounded,
              title: '消息',
              controller: _controller,
              onPressed: () {
                _controller.jumpToPage(2);
                setState(() {});
              },
            ),
            new NavItem(
              index: 3,
              icon: Boxicons.bxUser,
              actIcon: Boxicons.bxsUser,
              title: '我的',
              controller: _controller,
              onPressed: () {
                _controller.jumpToPage(3);
                setState(() {});
              },
            ),
          ],
        ),
      ),
      shadow: BoxShadow(color: Color(AppColors.AppTextColor1), blurRadius: 0.0, offset: Offset(0, -2)),
    );
  }
}

class NavItem extends StatefulWidget {
  final int index;
  final IconData icon;
  final IconData actIcon;
  final String title;
  final PageController controller;
  final VoidCallback onPressed;

  const NavItem({
    Key key,
    @required this.index,
    @required this.icon,
    @required this.actIcon,
    @required this.title,
    @required this.controller,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _NavItemState createState() => new _NavItemState();
}

class _NavItemState extends State<NavItem> {
  int get _index => widget.index;
  IconData get _icon => widget.icon;
  IconData get _actIcon => widget.actIcon;
  String get _title => widget.title;
  PageController get _controller => widget.controller;
  VoidCallback get _onPressed => widget.onPressed;

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      fit: FlexFit.loose,
      child: new FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(AppStyle.appRadius * 1.5, AppStyle.appRadius * 3),
            topRight: Radius.elliptical(AppStyle.appRadius * 1.5, AppStyle.appRadius * 3),
            bottomLeft: Radius.elliptical(AppStyle.appRadius * 1.5, AppStyle.appRadius * 3),
            bottomRight: Radius.elliptical(AppStyle.appRadius * 1.5, AppStyle.appRadius * 3),
          ),
        ),
        splashColor: Color(AppColors.AppWaveColor),
        padding: EdgeInsets.all(0),
        onPressed: _onPressed,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              ((_controller.page == null && _index == 0) || _controller.page == _index) ? _actIcon : _icon,
              color: ((_controller.page == null && _index == 0) || _controller.page == _index)
                  ? Color(AppColors.AppLabelColor)
                  : Color(AppColors.AppBorderColor),
              size: ScreenUtil().setWidth(60),
            ),
            new Text(
              _title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: ((_controller.page == null && _index == 0) || _controller.page == _index)
                    ? Color(AppColors.AppLabelColor)
                    : Color(AppColors.AppBorderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
