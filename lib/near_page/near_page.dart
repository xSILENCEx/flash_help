import 'dart:math';

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
  _NearPageState createState() => new _NearPageState();
}

class _NearPageState extends State<NearPage> {
  List<String> _sweeperUrl = [
    'http://img02.sogoucdn.com/app/a/200716/34a5d3dcd1e4a161467d6255e61b2652',
    'http://tc.sinaimg.cn/maxwidth.800/tc.service.weibo.com/mmbiz_qpic_cn/e097afcb83c69e3f0af7b677e19bfa04.jpg',
    'http://img.mp.itc.cn/upload/20160825/1d77345e8fe84a6280ec74bc7db885ab_th.jpg'
  ];

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
    return new Scaffold(
      backgroundColor: Color(AppColors.AppDeepColor),
      appBar: new SearchBar(),
      body: new RefreshIndicator(
        child: new ListView(
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(250)),
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              height: ScreenUtil().setHeight(360),
              child: new Swiper(
                itemCount: _sweeperUrl.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: new BoxDecoration(
                      color: Color(AppColors.AppWhiteColor),
                      borderRadius: BorderRadius.circular(AppStyle.appRadius),
                      image: DecorationImage(image: NetworkImage(_sweeperUrl[index]), fit: BoxFit.cover),
                    ),
                  );
                },
                autoplay: true,
              ),
            ),
            new Container(
              height: ScreenUtil().setWidth(30),
            ),
            new Material(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      '附近的人',
                      style: TextStyle(
                        color: Color(AppColors.AppTextColor2),
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: null,
                    trailing: new Icon(
                      Icons.arrow_forward_ios,
                      size: ScreenUtil().setWidth(45),
                      color: Color(AppColors.AppTextColor),
                    ),
                    contentPadding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(20),
                      left: ScreenUtil().setWidth(20),
                    ),
                    dense: true,
                    onTap: () {
                      Toast.toast(context, '查看更多');
                    },
                  ),
                  new Container(
                    height: ScreenUtil().setWidth(360),
                    width: double.infinity,
                    child: new ListView.builder(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                      physics: BouncingScrollPhysics(),
                      itemCount: _personNum,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return new PersonItem(index: index, name: WordPair.random().asPascalCase);
                      },
                    ),
                  ),
                ],
              ),
              color: Color(AppColors.AppWhiteColor),
            ),
            new Container(
              height: ScreenUtil().setWidth(30),
            ),
            new Material(
              color: Color(AppColors.AppWhiteColor),
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      '附近的悬赏',
                      style: TextStyle(
                        color: Color(AppColors.AppTextColor2),
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: null,
                    trailing: new Icon(
                      Icons.arrow_forward_ios,
                      size: ScreenUtil().setWidth(45),
                      color: Color(AppColors.AppTextColor),
                    ),
                    contentPadding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(20),
                      left: ScreenUtil().setWidth(20),
                    ),
                    dense: true,
                    onTap: () {
                      Toast.toast(context, '查看更多');
                    },
                  ),
                  new Container(
                    height: ScreenUtil().setWidth(780),
                    child: new ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return new TaskItem(index: index, reward: Random().nextInt(999).toDouble());
                      },
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              height: ScreenUtil().setWidth(30),
            ),
            new ListView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _buildAddItem();
                }),
          ],
        ),
        onRefresh: _onRefresh,
      ),
    );
  }

  _buildAddItem() {
    return new Container(
      height: ScreenUtil().setHeight(360),
      width: double.infinity,
      decoration: new BoxDecoration(
        color: Color(AppColors.AppWhiteColor),
        borderRadius: BorderRadius.circular(AppStyle.appRadius),
      ),
      margin: EdgeInsets.all(5),
      child: new Center(child: Text('活动广告位')),
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
    return new InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: new Container(
        margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
          color: Color(AppColors.AppWhiteColor),
          borderRadius: BorderRadius.circular(AppStyle.appRadius),
          boxShadow: [
            BoxShadow(color: Color(AppColors.AppShadowColor2), blurRadius: 5.0),
          ],
        ),
        width: ScreenUtil().setWidth(650),
        child: new Column(
          children: <Widget>[
            new Hero(
              tag: 'np$index',
              child: new Material(
                color: Colors.transparent,
                child: new Container(
                  height: ScreenUtil().setWidth(360),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(_url), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(AppStyle.appRadius), topRight: Radius.circular(AppStyle.appRadius)),
                    boxShadow: [
                      BoxShadow(color: Color(AppColors.AppShadowColor2), offset: Offset(0.0, 0.0), blurRadius: 3.0),
                    ],
                  ),
                ),
              ),
            ),
            new Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(30)),
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: new Text(
                '任务标题  任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介任务简介',
                style: TextStyle(fontSize: ScreenUtil().setSp(38), color: Color(AppColors.AppTextColor1)),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              decoration: BoxDecoration(
                color: Color(AppColors.AppDeepColor),
                borderRadius: BorderRadius.circular(AppStyle.appRadius),
              ),
            ),
            new Row(
              children: <Widget>[
                new Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setWidth(100),
                  margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppDeepColor),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                    border: Border.all(
                      color: Color(AppColors.AppBorderColor),
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppStyle.userPicture1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                new Text(
                  '信用度 ${Random().nextInt(999)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(AppColors.AppTextColor2),
                    fontSize: ScreenUtil().setSp(35),
                  ),
                ),
                new Text(
                  '  ￥$reward',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(AppColors.AppTextColor2),
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new TaskDetailPage(pictureTag: "np$index", reward: '$reward');
        }));
      },
    );
  }
}

class PersonItem extends StatelessWidget {
  final int index;
  final String name;

  const PersonItem({Key key, @required this.index, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: new Container(
        width: ScreenUtil().setWidth(260),
        margin: EdgeInsets.all(ScreenUtil().setWidth(15)),
        decoration: BoxDecoration(
          color: Color(AppColors.AppWhiteColor),
          borderRadius: BorderRadius.circular(AppStyle.appRadius),
          boxShadow: [
            BoxShadow(color: Color(AppColors.AppShadowColor2), offset: Offset(0, 1), blurRadius: 4.0),
          ],
        ),
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Hero(
              tag: 'headpicture$index',
              child: new Container(
                width: ScreenUtil().setWidth(160),
                height: ScreenUtil().setWidth(160),
                decoration: new BoxDecoration(
                  color: Color(AppColors.AppWhiteColor),
                  borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                  border: Border.all(color: Color(AppColors.AppBorderColor), width: 2),
                  image: DecorationImage(
                    image: AssetImage(AppStyle.userPicture2),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            new Text(
              name,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(35),
                color: Color(AppColors.AppTextColor2),
                fontWeight: FontWeight.bold,
                height: ScreenUtil().setWidth(4),
              ),
            ),
            new Text(
              '${Random().nextInt(999)}m',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Color(AppColors.AppTextColor),
                fontWeight: FontWeight.bold,
                height: ScreenUtil().setWidth(3),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new PersonalPage(headTag: 'headpicture$index', name: name, headUrl: AppStyle.userPicture2);
        }));
      },
    );
  }
}
