import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_functions/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/search_bar.dart';
import 'package:flash_help/first_page/item_page/task_page.dart';
import 'package:flash_help/first_page/item_page/top_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: _sliverBuilder,
        body: TabBarView(
          controller: _tabController,
          children: _pages,
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    final List<String> _sweeperUrl = [
      'http://img4.333cn.com/img333cn/2018/05/16/1526457986805.jpg',
      'http://img4.333cn.com/img333cn/2018/05/16/1526457993890.jpg',
      'http://img4.333cn.com/img333cn/2018/05/16/1526457989896.jpg'
    ];
    return <Widget>[
      SliverAppBar(
        elevation: 0.2,
        forceElevated: true,
        centerTitle: true,
        expandedHeight: ScreenUtil().setWidth(800),
        floating: false,
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
            decoration: BoxDecoration(
              color: Color(AppColors.AppMainColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppStyle.appRadius),
                topRight: Radius.circular(AppStyle.appRadius),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.all(ScreenUtil().setWidth(40)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppStyle.appRadius),
                      child: Swiper(
                        pagination: SwiperPagination(),
                        itemCount: _sweeperUrl.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(AppColors.AppMainColor),
                              borderRadius:
                                  BorderRadius.circular(AppStyle.appRadius),
                              image: DecorationImage(
                                image: NetworkImage(_sweeperUrl[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildHeadItem(Boxicons.bxCloud, '这是标题'),
                    _buildHeadItem(Boxicons.bxAward, '这是标题'),
                    _buildHeadItem(Boxicons.bxBall, '这是标题'),
                    _buildHeadItem(Boxicons.bxCoffee, '这是标题'),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ];
  }

  _buildHeadItem(IconData icon, String title) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(140),
          height: ScreenUtil().setWidth(140),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 10),
            color: Color(AppColors.AppThemeColor),
            boxShadow: [
              BoxShadow(
                color: Color(AppColors.AppThemeColor),
                offset: Offset(1, 1),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: Color(AppColors.AppMainColor),
            ),
            onPressed: () {
              Toast.toast(context, '点击');
            },
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Color(AppColors.AppTitleColor),
            fontSize: ScreenUtil().setSp(32),
            height: ScreenUtil().setHeight(5),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
