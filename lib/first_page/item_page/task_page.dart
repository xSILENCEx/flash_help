import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/first_page/detail_page/task_detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => new _RewardPageState();
}

class _RewardPageState extends State<RewardPage> with AutomaticKeepAliveClientMixin {
  static const loadingTag = "##loading##"; //表尾标记
  var _wordsData = <String>[loadingTag];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
      setState(() {});
    });
  }

  void _retrieveData(List<String> _wordsData) {
    new Future.delayed(Duration(seconds: 1)).then((e) {
      _wordsData.insertAll(_wordsData.length - 1, generateWordPairs().take(3).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _wordsData.insertAll(_wordsData.length - 1, generateWordPairs().take(3).map((e) => e.asPascalCase).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      backgroundColor: Color(AppColors.AppLabelColor),
      onRefresh: _onRefresh,
      color: Color(AppColors.AppWhiteColor),
      child: new ListView.separated(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setWidth(250),
        ),
        itemCount: _wordsData.length,
        itemBuilder: (context, index) {
//          if (index == 0) return new SortItem(sortList: _sortMethod, title: '查看类型');
          if (_wordsData[index] == loadingTag) {
            if (_wordsData.length - 1 < 100) {
              _retrieveData(_wordsData);
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 3.0)),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          return new TaskItem(
            index: index,
            credit: Random().nextInt(999),
            distance: Random().nextInt(999),
            reward: double.parse(Random().nextInt(999).toString()),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
//          if (index != 0)
            return new Container(
              height: ScreenUtil().setWidth(20),
              color: Color(AppColors.AppDeepColor),
            );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TaskItem extends StatelessWidget {
  final int index;
  final int credit;
  final int distance;
  final double reward;

  const TaskItem({Key key, @required this.index, @required this.credit, @required this.distance, @required this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _url = 'images/task_main.jpeg';
    return new InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new TaskDetailPage(pictureTag: "pic$index", reward: '$reward');
        }));
      },
      child: new Column(
        children: <Widget>[
          new Hero(
            tag: "pic$index",
            child: new Material(
              child: Container(
                height: ScreenUtil().setWidth(350),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppDeepColor),
                  image: DecorationImage(image: AssetImage(_url), fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(AppStyle.appRadius), topRight: Radius.circular(AppStyle.appRadius)),
                ),
                margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
            child: new Text(
              '任务标题  任务简介任务简介介任务简介任务简介介任务简介介介任务简介介任务简介任务简介任介任任务简介任务简介任任务简务简介任务简介任务简介任务简介任务简介任务简介任务简介任务',
              style: TextStyle(fontSize: ScreenUtil().setSp(38), color: Color(AppColors.AppTextColor1)),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              softWrap: true,
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
                  fontSize: ScreenUtil().setSp(35),
                  color: Color(AppColors.AppTextColor2),
                ),
              ),
              new Text(
                '   ￥$reward   ${Random().nextInt(999)}m',
                style: TextStyle(fontSize: ScreenUtil().setSp(41), color: Color(AppColors.AppTextColor2), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          new Container(
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            color: Color(AppColors.AppBorderColor),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
          ),
          new OperationBar(),
        ],
      ),
    );
  }
}

class OperationBar extends StatefulWidget {
  @override
  _OperationBarState createState() => new _OperationBarState();
}

class _OperationBarState extends State<OperationBar> {
  bool _good = false, _star = false;
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Flexible(
            child: new IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  size: ScreenUtil().setWidth(56),
                  color: Color(_good ? AppColors.AppLabelColor : AppColors.AppBorderColor),
                ),
                onPressed: () {
                  setState(() {
                    _good = !_good;
                  });
                })),
        new Flexible(
            child: new IconButton(
                icon: Icon(
                  _star ? Icons.star : Icons.star_border,
                  size: ScreenUtil().setWidth(58),
                  color: Color(_star ? AppColors.AppLabelColor : AppColors.AppBorderColor),
                ),
                onPressed: () {
                  setState(() {
                    _star = !_star;
                  });
                })),
        new Flexible(
            child: new IconButton(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  size: ScreenUtil().setWidth(56),
                  color: Color(AppColors.AppBorderColor),
                ),
                onPressed: () {
                  Toast.toast(context, '评论');
                })),
        new Flexible(
            child: new IconButton(
                icon: Icon(
                  Icons.reply,
                  size: ScreenUtil().setWidth(56),
                  color: Color(AppColors.AppBorderColor),
                ),
                onPressed: () {
                  Toast.toast(context, '转发');
                })),
      ],
    );
  }
}
