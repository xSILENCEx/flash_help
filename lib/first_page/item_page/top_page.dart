import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/first_page/detail_page/personal_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_words/english_words.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => new _TopPageState();
}

class _TopPageState extends State<TopPage> with AutomaticKeepAliveClientMixin {
  static const loadingTag = "##loading##";
  var _wordsData = <String>[loadingTag];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
      setState(() {});
    });
  }

  void _retrieveData(List<String> _wordsData) {
    new Future.delayed(Duration(seconds: 1)).then((e) {
      _wordsData.insertAll(_wordsData.length - 1, generateWordPairs().take(8).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _wordsData.insertAll(_wordsData.length - 1, generateWordPairs().take(8).map((e) => e.asPascalCase).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Flexible(
          child: new RefreshIndicator(
            backgroundColor: Color(AppColors.AppLabelColor),
            onRefresh: _onRefresh,
            color: Color(AppColors.AppWhiteColor),
            child: new ListView.separated(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(200),
              ),
              itemCount: _wordsData.length,
              itemBuilder: (context, index) {
//                if (index == 0)
//                  return new SortItem(title: '排序方式', sortList: _sortMethod);
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
                        style: TextStyle(color: Color(AppColors.AppTextColor1)),
                      ),
                    );
                  }
                }
                return new UserItem(
                  index: index,
                  title: _wordsData[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
//                if (index != 0)
                  return new Container(
                    height: ScreenUtil().setWidth(3),
                    color: Color(AppColors.AppDeepColor),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
                  );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class UserItem extends StatelessWidget {
  final int index;
  final String title;

  const UserItem({Key key, this.index, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      dense: true,
      leading: new Hero(
        tag: 'headpicture$index',
        child: new Container(
          width: ScreenUtil().setWidth(150),
          height: ScreenUtil().setWidth(150),
          decoration: BoxDecoration(
            color: Color(AppColors.AppDeepColor),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
            image: DecorationImage(
              image: AssetImage(AppStyle.userPicture1),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: Color(AppColors.AppWhiteColor), width: 2),
          ),
        ),
      ),
      title: new Text(
        title,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(40),
          color: Color(AppColors.AppTextColor2),
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: new Text(
        '这个人很懒，什么都没有留下',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Color(AppColors.AppTextColor),
          fontSize: ScreenUtil().setSp(35),
        ),
      ),
      trailing: new Container(
        padding: new EdgeInsets.all(3),
        child: new Text('${Random().nextInt(999)}m', style: TextStyle(color: Color(AppColors.AppWhiteColor), fontSize: ScreenUtil().setSp(35))),
        decoration: new BoxDecoration(color: Color(AppColors.AppLabelColor), borderRadius: BorderRadius.circular(AppStyle.appRadius / 4)),
      ),
      contentPadding: new EdgeInsets.only(
        left: ScreenUtil().setWidth(25),
        right: ScreenUtil().setWidth(25),
        top: ScreenUtil().setWidth(15),
        bottom: ScreenUtil().setWidth(15),
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new PersonalPage(
            headTag: 'headpicture$index',
            name: title,
            headUrl: null,
          );
        }));
      },
    );
  }
}
