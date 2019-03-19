import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_functions/search_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final double elevation;

  const SearchBar({Key key, this.elevation}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      brightness: Brightness.dark,
      backgroundColor: Color(AppColors.AppLabelColor),
      elevation: elevation == null ? 0.3 : elevation,
      title: new Row(
        children: <Widget>[
          new Flexible(
            child: new Container(
              height: ScreenUtil().setWidth(100),
              width: double.infinity,
              child: new FlatButton(
                color: Color(AppColors.AppWhiteColor4),
                onPressed: () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      builder: (context) {
                        return SearchPage();
                      },
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                ),
                child: new Text(
                  '点击搜索用户/悬赏/分类',
                  style: TextStyle(
                    color: Color(AppColors.AppWhiteColor),
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ),
            ),
            fit: FlexFit.loose,
          ),
          new Container(
            margin: EdgeInsets.only(left: 10),
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setWidth(100),
            child: new FlatButton(
              color: Color(AppColors.AppWhiteColor4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              padding: EdgeInsets.all(0),
              onPressed: () {
                Toast.toast(context, '新的通知');
              },
              child: new Icon(
                Icons.notifications_none,
                color: Color(AppColors.AppWhiteColor),
                size: ScreenUtil().setWidth(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}
