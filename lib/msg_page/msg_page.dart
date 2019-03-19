import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/search_bar.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_functions/chat_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsgPage extends StatefulWidget {
  @override
  _MsgPageState createState() => new _MsgPageState();
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
    _wordsData.insertAll(_wordsData.length - 1, generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
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
      appBar: new SearchBar(),
      body: new RefreshIndicator(
        onRefresh: _onRefresh,
        child: new ListView.separated(
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(250)),
          itemCount: _wordsData.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildMsgBox(_wordsData[index], index + 1);
          },
          separatorBuilder: (BuildContext context, int index) {
            return new Container(
              height: ScreenUtil().setWidth(2),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(100), right: ScreenUtil().setWidth(100)),
              color: Color(AppColors.AppDeepColor),
            );
          },
        ),
      ),
    );
  }

  _buildMsgBox(String item, int index) {
    return new Hero(
      tag: 'chatitem$index',
      child: new Dismissible(
        key: new Key(item),
        child: new Material(
          color: Color(AppColors.AppWhiteColor),
          child: new ListTile(
            dense: true,
            leading: new Container(
              width: ScreenUtil().setWidth(150),
              height: ScreenUtil().setWidth(150),
              decoration: BoxDecoration(
                color: Color(AppColors.AppDeepColor),
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                image: DecorationImage(
                  image: AssetImage(AppStyle.userPicture2),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Color(AppColors.AppWhiteColor), width: 2),
              ),
            ),
            title: new Text(
              item,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: new Text('最后一条消息的内容'),
            trailing: new Text(
              '${Random().nextInt(23)}:${Random().nextInt(59)}',
              style: TextStyle(
                color: Color(AppColors.AppTextColor1),
                fontSize: ScreenUtil().setSp(35),
              ),
            ),
            contentPadding: new EdgeInsets.only(
              left: ScreenUtil().setWidth(25),
              right: ScreenUtil().setWidth(25),
              top: ScreenUtil().setWidth(15),
              bottom: ScreenUtil().setWidth(15),
            ),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return new ChatPage(itemTag: 'chatitem$index', userName: item);
              }));
            },
          ),
        ),
        background: new Center(
          child: new Text('侧滑删除'),
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
