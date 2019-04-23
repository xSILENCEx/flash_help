import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/first_page/detail_page/task_detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';

class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => new _RewardPageState();
}

const List<Map<String, dynamic>> ORDERS = [
  {"title": "综合排序"},
  {"title": "报酬最高"},
  {"title": "离我最近"},
  {"title": "人气最高"},
];

const int ORDER_INDEX = 0;

const List<Map<String, dynamic>> TYPES = [
  {"title": "全部类型", "id": 0},
  {"title": "只看现金", "id": 1},
  {"title": "只看积分", "id": 2},
  {"title": "只看无偿", "id": 3},
];

const int TYPE_INDEX = 0;

const List<Map<String, dynamic>> LABELS = [
  {"title": "全部标签", "id": 0},
  {"title": "外卖", "id": 1},
  {"title": "洗衣", "id": 2},
  {"title": "排队", "id": 3},
  {"title": "聊天", "id": 4},
  {"title": "功课", "id": 5},
  {"title": "手工", "id": 6},
  {"title": "代购", "id": 7},
  {"title": "修图", "id": 8},
];

const int LABEL_INDEX = 0;

class _RewardPageState extends State<RewardPage>
    with AutomaticKeepAliveClientMixin {
  static const loadingTag = "##loading##"; //表尾标记
  var _wordsData = <String>[loadingTag];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
      Toast.toast(context, '刷新成功');
      setState(() {});
    });
  }

  void _retrieveData(List<String> _wordsData) {
    new Future.delayed(Duration(seconds: 1)).then((e) {
      _wordsData.insertAll(_wordsData.length - 1,
          generateWordPairs().take(3).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _wordsData.insertAll(_wordsData.length - 1,
        generateWordPairs().take(3).map((e) => e.asPascalCase).toList());
    super.initState();
  }

  DropdownMenu _buildDropdownMenu() {
    return new DropdownMenu(
      maxMenuHeight: kDropdownMenuItemHeight *
          ScreenUtil().setWidth(100), //  activeIndex: activeIndex,
      menus: [
        new DropdownMenuBuilder(
          builder: (BuildContext context) {
            return new DropdownListMenu(
              selectedIndex: TYPE_INDEX,
              data: TYPES,
              itemBuilder: buildCheckItem,
            );
          },
          height: kDropdownMenuItemHeight * TYPES.length +
              ScreenUtil().setWidth(100),
        ),
        new DropdownMenuBuilder(
          builder: (BuildContext context) {
            return new DropdownListMenu(
              selectedIndex: ORDER_INDEX,
              data: ORDERS,
              itemBuilder: buildCheckItem,
            );
          },
          height: kDropdownMenuItemHeight * ORDERS.length +
              ScreenUtil().setWidth(100),
        ),
        new DropdownMenuBuilder(
          builder: (BuildContext context) {
            return new DropdownListMenu(
              selectedIndex: LABEL_INDEX,
              data: LABELS,
              itemBuilder: buildCheckItem,
            );
          },
          height: kDropdownMenuItemHeight * LABELS.length +
              ScreenUtil().setWidth(100),
        ),
      ],
    );
  }

  DropdownHeader _buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return new DropdownHeader(
      height: ScreenUtil().setWidth(100),
      onTap: onTap,
      titles: [TYPES[TYPE_INDEX], ORDERS[ORDER_INDEX], LABELS[LABEL_INDEX]],
    );
  }

  Widget _buildFixHeaderDropdownMenu() {
    return new DefaultDropdownMenuController(
      child: new Column(
        children: <Widget>[
          _buildDropdownHeader(),
          new Expanded(
            child: new Stack(
              children: <Widget>[
                RefreshIndicator(
                  backgroundColor: Color(AppColors.AppThemeColor),
                  onRefresh: _onRefresh,
                  color: Color(AppColors.AppMainColor),
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      bottom: ScreenUtil().setWidth(250),
                    ),
                    itemCount: _wordsData.length,
                    itemBuilder: (context, index) {
                      if (_wordsData[index] == loadingTag) {
                        if (_wordsData.length - 1 < 100) {
                          _retrieveData(_wordsData);
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child:
                                  CircularProgressIndicator(strokeWidth: 3.0),
                            ),
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
                        reward: double.parse(
                          Random().nextInt(999).toString(),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return new Container(
                        height: ScreenUtil().setWidth(20),
                        color: Color(AppColors.AppDeepColor),
                      );
                    },
                  ),
                ),
                _buildDropdownMenu(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildFixHeaderDropdownMenu();
  }

  @override
  bool get wantKeepAlive => true;
}

class TaskItem extends StatelessWidget {
  final int index;
  final int credit;
  final int distance;
  final double reward;

  const TaskItem(
      {Key key,
      @required this.index,
      @required this.credit,
      @required this.distance,
      @required this.reward})
      : super(key: key);

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
                  image: DecorationImage(
                      image: AssetImage(_url), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(AppStyle.appRadius),
                ),
                margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30)),
            child: new Text(
              '任务标题  任务简介任务简介介任务简介任务简介介任务简介介介任务简介介任务简介任务简介任介任任务简介任务简介任任务简务简介任务简介任务简介任务简介任务简介任务简介任务简介任务',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(34),
                  color: Color(AppColors.AppSubtitleColor)),
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
                  fontSize: ScreenUtil().setSp(34),
                  color: Color(AppColors.AppTitleColor),
                ),
              ),
              new Text(
                '   ￥$reward   ',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(34),
                    color: Color(AppColors.AppDotColor),
                    fontWeight: FontWeight.bold),
              ),
              new Text(
                '距离：${Random().nextInt(999)}m',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(34),
                    color: Color(AppColors.AppTitleColor),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          new Container(
            width: double.infinity,
            height: ScreenUtil().setWidth(1),
            color: Color(AppColors.AppDeepColor),
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(50),
                right: ScreenUtil().setWidth(50)),
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
  bool _like = false, _star = false;
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Flexible(
            child: new IconButton(
                icon: Icon(
                  _like ? Boxicons.bxsLike : Boxicons.bxLike,
                  size: ScreenUtil().setWidth(56),
                  color: Color(_like
                      ? AppColors.AppThemeColor
                      : AppColors.AppSubtitleColor),
                ),
                onPressed: () {
                  setState(() {
                    _like = !_like;
                  });
                })),
        new Flexible(
            child: new IconButton(
                icon: Icon(
                  _star ? Boxicons.bxsStar : Boxicons.bxStar,
                  size: ScreenUtil().setWidth(64),
                  color: Color(_star
                      ? AppColors.AppThemeColor
                      : AppColors.AppSubtitleColor),
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
                  color: Color(AppColors.AppSubtitleColor),
                ),
                onPressed: () {
                  Toast.toast(context, '评论');
                })),
        new Flexible(
            child: new IconButton(
                icon: Icon(
                  Icons.reply,
                  size: ScreenUtil().setWidth(56),
                  color: Color(AppColors.AppSubtitleColor),
                ),
                onPressed: () {
                  Toast.toast(context, '转发');
                })),
      ],
    );
  }
}
