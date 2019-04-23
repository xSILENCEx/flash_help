import 'dart:math';

import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flash_help/basic_functions/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/search_bar.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/first_page/detail_page/personal_page.dart';
import 'package:flash_help/first_page/detail_page/task_detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:english_words/english_words.dart';

class NearPage extends StatefulWidget {
  @override
  _NearPageState createState() => _NearPageState();
}

class _NearPageState extends State<NearPage> {
  int _personNum = 5;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.AppDeepColor),
      body: NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder: _buildSliver,
        body: RefreshIndicator(
          child: ListView(
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(250)),
            children: <Widget>[
              Material(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Boxicons.bxBullseye,
                            size: ScreenUtil().setWidth(60),
                            color: Color(AppColors.AppTitleColor),
                          ),
                          Text(
                            ' 附近的人',
                            style: TextStyle(
                              color: Color(AppColors.AppTitleColor),
                              fontSize: ScreenUtil().setSp(40),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      leading: null,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: ScreenUtil().setWidth(45),
                        color: Color(AppColors.AppTitleColor),
                      ),
                      contentPadding: EdgeInsets.only(
                        right: ScreenUtil().setWidth(40),
                        left: ScreenUtil().setWidth(40),
                        top: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setWidth(20),
                      ),
                      dense: true,
                      onTap: () {
                        Toast.toast(context, '查看更多');
                      },
                    ),
                    Container(
                      height: ScreenUtil().setWidth(360),
                      width: double.infinity,
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                        ),
                        physics: BouncingScrollPhysics(),
                        itemCount: _personNum,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return PersonItem(
                            index: index,
                            name: WordPair.random().asPascalCase,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                color: Color(AppColors.AppMainColor),
              ),
              Material(
                color: Color(AppColors.AppMainColor),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Boxicons.bxDollarCircle,
                            size: ScreenUtil().setWidth(60),
                            color: Color(AppColors.AppTitleColor),
                          ),
                          Text(
                            ' 附近的悬赏',
                            style: TextStyle(
                              color: Color(AppColors.AppTitleColor),
                              fontSize: ScreenUtil().setSp(40),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      leading: null,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: ScreenUtil().setWidth(45),
                        color: Color(AppColors.AppTitleColor),
                      ),
                      contentPadding: EdgeInsets.only(
                        right: ScreenUtil().setWidth(40),
                        left: ScreenUtil().setWidth(40),
                        top: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setWidth(20),
                      ),
                      dense: true,
                      onTap: () {
                        Toast.toast(context, '查看更多');
                      },
                    ),
                    Container(
                      height: ScreenUtil().setWidth(780),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                        ),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return TaskItem(
                            index: index,
                            reward: Random().nextInt(999).toDouble(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(AppColors.AppMainColor),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(
                        Boxicons.bxGroup,
                        size: ScreenUtil().setWidth(60),
                        color: Color(AppColors.AppTitleColor),
                      ),
                      Text(
                        ' 闪友动态',
                        style: TextStyle(
                          color: Color(AppColors.AppTitleColor),
                          fontSize: ScreenUtil().setSp(40),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  leading: null,
                  contentPadding: EdgeInsets.only(
                    right: ScreenUtil().setWidth(40),
                    left: ScreenUtil().setWidth(40),
                    top: ScreenUtil().setWidth(20),
                    bottom: ScreenUtil().setWidth(20),
                  ),
                  dense: true,
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.all(0),
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _buildLifeItem();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: ScreenUtil().setWidth(20),
                  );
                },
              ),
            ],
          ),
          onRefresh: _onRefresh,
        ),
      ),
    );
  }

  List<Widget> _buildSliver(BuildContext context, bool innerBoxIsScrolled) {
    final List<String> _sweeperUrl = [
      'images/book.jpeg',
      'images/black.jpg',
      'images/coffee.JPEG'
    ];
    return <Widget>[
      SliverAppBar(
        title: Text(
          '附近',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(60),
            fontWeight: FontWeight.bold,
            color: Color(AppColors.AppMainColor),
          ),
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
        expandedHeight: ScreenUtil().setHeight(800),
        elevation: 0.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(800),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(AppColors.AppThemeColor),
                  Color(AppColors.AppMainColor),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Swiper(
              itemCount: _sweeperUrl.length,
              scale: 0.6,
              viewportFraction: 1.2,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppMainColor),
                    image: DecorationImage(
                      image: AssetImage(_sweeperUrl[index]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  ),
                );
              },
              pagination: SwiperPagination(),
            ),
          ),
        ),
      ),
    ];
  }

  _buildLifeItem() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(20),
      ),
      color: Color(AppColors.AppMainColor),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setWidth(100),
              decoration: BoxDecoration(
                color: Color(AppColors.AppDeepColor),
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 10),
              ),
            ),
            title: Text(
              '用户昵称',
              style: TextStyle(
                color: Color(AppColors.AppTitleColor),
                fontSize: ScreenUtil().setSp(32),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '发布于xxxxxxxxxxxxxx',
              style: TextStyle(
                color: Color(AppColors.AppTitleColor),
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
            trailing: Container(
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
                  Toast.toast(context, '关注');
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(50),
              right: ScreenUtil().setWidth(50),
            ),
            child: Text(
              '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容',
              style: TextStyle(
                color: Color(AppColors.AppTitleColor),
                fontSize: ScreenUtil().setSp(34),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(50),
              right: ScreenUtil().setWidth(50),
            ),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: ScreenUtil().setWidth(10),
                mainAxisSpacing: ScreenUtil().setWidth(10),
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppDeepColor),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: ScreenUtil().setWidth(2),
            color: Color(AppColors.AppDeepColor),
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(60),
              left: ScreenUtil().setWidth(80),
              right: ScreenUtil().setWidth(80),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Boxicons.bxLike,
                  size: ScreenUtil().setWidth(56),
                  color: Color(AppColors.AppSubtitleColor),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Boxicons.bxMessage,
                  size: ScreenUtil().setWidth(56),
                  color: Color(AppColors.AppSubtitleColor),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Boxicons.bxShare,
                  size: ScreenUtil().setWidth(56),
                  color: Color(AppColors.AppSubtitleColor),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final int index;
  final double reward;

  const TaskItem({Key key, this.index, this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _url = 'images/task_main.jpeg';
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
          color: Color(AppColors.AppMainColor),
          borderRadius: BorderRadius.circular(AppStyle.appRadius),
          boxShadow: [
            BoxShadow(color: Color(AppColors.AppShadowColor), blurRadius: 5.0),
          ],
        ),
        width: ScreenUtil().setWidth(650),
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'np$index',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: ScreenUtil().setWidth(360),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(_url), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppStyle.appRadius),
                        topRight: Radius.circular(AppStyle.appRadius)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(AppColors.AppShadowColor),
                          offset: Offset(0.0, 0.0),
                          blurRadius: 3.0),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  top: ScreenUtil().setWidth(30)),
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Text(
                '任务标题  任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(34),
                    color: Color(AppColors.AppSubtitleColor)),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              decoration: BoxDecoration(
                color: Color(AppColors.AppDeepColor),
                borderRadius: BorderRadius.circular(AppStyle.appRadius),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setWidth(100),
                  margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
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
                Text(
                  '信用度 ${Random().nextInt(999)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(AppColors.AppTitleColor),
                    fontSize: ScreenUtil().setSp(34),
                  ),
                ),
                Text(
                  '  ￥$reward',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(AppColors.AppDotColor),
                    fontSize: ScreenUtil().setSp(34),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return TaskDetailPage(pictureTag: "np$index", reward: '$reward');
        }));
      },
    );
  }
}

class PersonItem extends StatelessWidget {
  final int index;
  final String name;

  const PersonItem({Key key, @required this.index, @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: ScreenUtil().setWidth(260),
        margin: EdgeInsets.all(ScreenUtil().setWidth(15)),
        decoration: BoxDecoration(
          color: Color(AppColors.AppMainColor),
          borderRadius: BorderRadius.circular(AppStyle.appRadius),
          boxShadow: [
            BoxShadow(
                color: Color(AppColors.AppShadowColor),
                offset: Offset(0, 1),
                blurRadius: 4.0),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'headpicture$index',
              child: Container(
                width: ScreenUtil().setWidth(160),
                height: ScreenUtil().setWidth(160),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppMainColor),
                  borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                  border: Border.all(
                      color: Color(AppColors.AppSubtitleColor), width: 2),
                  image: DecorationImage(
                    image: AssetImage(AppStyle.userPicture2),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(35),
                color: Color(AppColors.AppTitleColor),
                fontWeight: FontWeight.bold,
                height: ScreenUtil().setWidth(4),
              ),
            ),
            Text(
              '${Random().nextInt(999)}m',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Color(AppColors.AppSubtitleColor),
                fontWeight: FontWeight.bold,
                height: ScreenUtil().setWidth(3),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return PersonalPage(
              headTag: 'headpicture$index',
              name: name,
              headUrl: AppStyle.userPicture2);
        }));
      },
    );
  }
}
