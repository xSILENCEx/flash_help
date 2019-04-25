import 'dart:math';

import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:english_words/english_words.dart';
import 'package:flash_help/basic_functions/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/search_bar.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_functions/chat_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MsgPage extends StatefulWidget {
  @override
  _MsgPageState createState() => _MsgPageState();
}

class _MsgPageState extends State<MsgPage> with AutomaticKeepAliveClientMixin {
  static const loadingTag = "##loading##"; //表尾标记
  var _wordsData = <String>[loadingTag];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _wordsData.insertAll(_wordsData.length - 1,
        generateWordPairs().take(12).map((e) => e.asPascalCase).toList());
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool s) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              pinned: true,
              leading: null,
              elevation: 0.0,
              expandedHeight: ScreenUtil().setWidth(600),
              title: Text(
                '消息',
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
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/coffe_b.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(140),
                                  height: ScreenUtil().setWidth(140),
                                  child: IconButton(
                                    icon: Icon(
                                      Boxicons.bxsUserDetail,
                                      color: Color(AppColors.AppThemeColor),
                                      size: ScreenUtil().setWidth(60),
                                    ),
                                    onPressed: () {},
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppStyle.appRadius * 10),
                                    color: Color(AppColors.AppMainColor),
                                  ),
                                ),
                                Text(
                                  '私信通知',
                                  style: TextStyle(
                                    color: Color(AppColors.AppMainColor),
                                    fontSize: ScreenUtil().setSp(34),
                                    height: ScreenUtil().setWidth(4),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(140),
                                  height: ScreenUtil().setWidth(140),
                                  child: IconButton(
                                    icon: Icon(
                                      Boxicons.bxsBell,
                                      color: Color(AppColors.AppThemeColor),
                                      size: ScreenUtil().setWidth(56),
                                    ),
                                    onPressed: () {},
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppStyle.appRadius * 10),
                                    color: Color(AppColors.AppMainColor),
                                  ),
                                ),
                                Text(
                                  '系统通知',
                                  style: TextStyle(
                                    color: Color(AppColors.AppMainColor),
                                    fontSize: ScreenUtil().setSp(34),
                                    height: ScreenUtil().setWidth(4),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(140),
                                  height: ScreenUtil().setWidth(140),
                                  child: IconButton(
                                    icon: Icon(
                                      Boxicons.bxsCoupon,
                                      color: Color(AppColors.AppThemeColor),
                                      size: ScreenUtil().setWidth(60),
                                    ),
                                    onPressed: () {},
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppStyle.appRadius * 10),
                                    color: Color(AppColors.AppMainColor),
                                  ),
                                ),
                                Text(
                                  '活动通知',
                                  style: TextStyle(
                                    color: Color(AppColors.AppMainColor),
                                    fontSize: ScreenUtil().setSp(34),
                                    height: ScreenUtil().setWidth(4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setWidth(50),
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setWidth(100),
                          ),
                          decoration: BoxDecoration(
                            color: Color(AppColors.AppMainColor),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppStyle.appRadius),
                              topRight: Radius.circular(AppStyle.appRadius),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(250)),
            itemCount: _wordsData.length,
            itemBuilder: (BuildContext context, int index) {
              return MsgBox(
                item: _wordsData[index],
                index: index,
                onTap: () {
                  _wordsData.removeAt(index);
                  Toast.toast(context, '删除成功');
                  setState(() {});
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: ScreenUtil().setWidth(2),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(100),
                    right: ScreenUtil().setWidth(100)),
                color: Color(AppColors.AppDeepColor),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MsgBox extends StatelessWidget {
  final String item;
  final int index;
  final VoidCallback onTap;

  const MsgBox({Key key, this.item, this.index, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: 'chatitem$index',
      child: Slidable(
        key: Key(item),
        child: Material(
          color: Color(AppColors.AppMainColor),
          child: ListTile(
            dense: true,
            leading: Container(
              width: ScreenUtil().setWidth(140),
              height: ScreenUtil().setWidth(140),
              decoration: BoxDecoration(
                color: Color(AppColors.AppDeepColor),
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                image: DecorationImage(
                  image: AssetImage(AppStyle.userPicture2),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              item,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40),
                fontWeight: FontWeight.bold,
                color: Color(AppColors.AppTitleColor),
              ),
            ),
            subtitle: Text(
              '最后一条消息的内容',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Color(AppColors.AppSubtitleColor),
              ),
            ),
            trailing: Text(
              '${Random().nextInt(23)}:${Random().nextInt(59)}',
              style: TextStyle(
                color: Color(AppColors.AppSubtitleColor),
                fontSize: ScreenUtil().setSp(35),
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: ScreenUtil().setWidth(25),
              right: ScreenUtil().setWidth(25),
              top: ScreenUtil().setWidth(15),
              bottom: ScreenUtil().setWidth(15),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return ChatPage(itemTag: 'chatitem$index', userName: item);
              }));
            },
          ),
        ),
        delegate: SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: '置顶',
            color: Color(AppColors.AppDotColor),
            icon: Boxicons.bxsToTop,
            onTap: () => {},
          ),
          new IconSlideAction(
            caption: '删除',
            color: Color(AppColors.AppWaringColor),
            icon: Boxicons.bxTrash,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
