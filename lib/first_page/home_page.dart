import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/search_bar.dart';
import 'package:flash_help/first_page/item_page/task_page.dart';
import 'package:flash_help/first_page/item_page/top_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new ScrollMar(height: kToolbarHeight + MediaQuery.of(context).padding.top),
              new Flexible(
                child: new PageViewItem(),
              ),
            ],
          ),
          new Container(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            child: new SearchBar(elevation: 0.0),
          ),
        ],
      ),
    );
  }
}

class ScrollMar extends StatefulWidget {
  final double height;

  const ScrollMar({Key key, @required this.height}) : super(key: key);
  @override
  ScrollMarState createState() => new ScrollMarState();
}

class ScrollMarState extends State<ScrollMar> with SingleTickerProviderStateMixin {
  Animation<double> _itemHeight;
  static AnimationController _animationController;

  double get _height => widget.height;

  static bool _isBarOpen = true;

  @override
  void initState() {
    _animationController = new AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _itemHeight = new Tween<double>(begin: _height, end: _height - ScreenUtil().setWidth(100)).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    super.initState();
  }

  void animateStart() async {
    if (_isBarOpen) {
      _isBarOpen = false;
      _animationController.forward();
    }
  }

  void animateBack() async {
    if (!_isBarOpen) {
      _isBarOpen = true;
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        return new Container(
          height: _itemHeight.value,
          color: Color(AppColors.AppLabelColor),
        );
      },
      animation: _itemHeight,
    );
  }
}

class PageViewItem extends StatelessWidget {
  final List<Tab> _homePageTabs = [
    new Tab(
      child: Text('闪友排行', style: TextStyle(fontWeight: FontWeight.bold)),
    ),
    new Tab(
      child: Text('悬赏列表', style: TextStyle(fontWeight: FontWeight.bold)),
    ),
  ];
  final List<Widget> _pages = [
    new TopPage(),
    new RewardPage(),
  ];
  @override
  Widget build(BuildContext context) {
    double _positionY;
    return new DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TabBar(
              labelStyle: TextStyle(fontSize: ScreenUtil().setSp(35)),
              labelColor: Color(AppColors.AppWhiteColor),
              indicatorWeight: ScreenUtil().setWidth(4),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Color(AppColors.AppWhiteColor),
              tabs: _homePageTabs,
            ),
            height: ScreenUtil().setWidth(100),
            color: Color(AppColors.AppLabelColor),
            alignment: Alignment.center,
          ),
          new Flexible(
            child: new Listener(
              child: new TabBarView(
                physics: ClampingScrollPhysics(),
                children: _pages,
              ),
              onPointerDown: (detail) {
                _positionY = detail.position.dy;
              },
              onPointerUp: (detail) {
                if (_positionY + ScreenUtil().setWidth(200) < detail.position.dy) {
                  ScrollMarState().animateBack();
                } else if (_positionY > detail.position.dy + ScreenUtil().setWidth(200)) {
                  ScrollMarState().animateStart();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
