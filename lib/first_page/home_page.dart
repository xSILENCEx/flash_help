import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flash_help/basic_functions/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/search_bar.dart';
import 'package:flash_help/first_page/item_page/task_page.dart';
import 'package:flash_help/first_page/item_page/top_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController(initialScrollOffset: 0.0);
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> _homePageTabs = [
      Tab(
        child: Text(
          '排行',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Tab(
        child: Text(
          '悬赏',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
    final List<Widget> _pages = [
      TopPage(),
      RewardPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: null,
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Text(
              '首页',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(60),
                fontWeight: FontWeight.bold,
                color: Color(AppColors.AppMainColor),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                top: ScreenUtil().setWidth(44),
                bottom: ScreenUtil().setWidth(36),
              ),
              width: ScreenUtil().setWidth(360),
              child: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                labelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)),
                labelColor: Color(AppColors.AppMainColor),
                indicatorPadding: EdgeInsets.all(0),
                tabs: _homePageTabs,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppStyle.appRadius * 20),
                  color: Color(AppColors.AppThemeColor2),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Boxicons.bxSearch,
              color: Color(AppColors.AppMainColor),
              size: ScreenUtil().setWidth(70),
            ),
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
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: ClampingScrollPhysics(),
        children: _pages,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
