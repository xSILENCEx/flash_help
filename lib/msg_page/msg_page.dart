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
    _wordsData.insertAll(_wordsData.length - 1,
        generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
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
      appBar: AppBar(
        leading: null,
        elevation: 0.0,
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
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.separated(
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(250)),
          itemCount: _wordsData.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildMsgBox(_wordsData[index], index + 1);
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
    );
  }

  _buildMsgBox(String item, int index) {
    return Hero(
      tag: 'chatitem$index',
      child: Dismissible(
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
        background: Center(
          child: Text('侧滑删除'),
        ),
        onDismissed: (direction) {
          _wordsData.removeAt(index - 1);
          Toast.toast(context, '删除成功');
          setState(() {});
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
