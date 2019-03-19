import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/arc_clipper.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatefulWidget {
  final double navHeight;
  final PageController controller;

  const MyAppBar({Key key, @required this.navHeight, @required this.controller}) : super(key: key);

  @override
  _MyAppBar createState() => new _MyAppBar();
}

class _MyAppBar extends State<MyAppBar> with TickerProviderStateMixin {
  int _pageIndex = 0;

  double get _navHeight => widget.navHeight;
  PageController get _controller => widget.controller;

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
            _buildNavItem(0, Icons.home, '首页'),
            _buildNavItem(1, Icons.explore, '发现'),
            new Flexible(child: new Container()),
            _buildNavItem(2, Icons.textsms, '消息'),
            _buildNavItem(3, Icons.person, '我的'),
          ],
        ),
      ),
      shadow: BoxShadow(color: Color(AppColors.AppTextColor1), blurRadius: 0.0, offset: Offset(0, -2)),
    );
  }

  _buildNavItem(int index, IconData icon, String title) {
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
        onPressed: () {
          setState(() {
            _pageIndex = index;
          });
          _controller.jumpToPage(index);
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(icon,
                color: _pageIndex == index ? Color(AppColors.AppLabelColor) : Color(AppColors.AppBorderColor), size: ScreenUtil().setWidth(60)),
            new Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: _pageIndex == index ? Color(AppColors.AppLabelColor) : Color(AppColors.AppBorderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
