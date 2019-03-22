import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_classes.dart';
import 'package:flash_help/first_page/detail_page/personal_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatefulWidget {
  final String itemTag;
  final String userName;

  const ChatPage({Key key, this.itemTag, this.userName}) : super(key: key);

  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {
  String get _itemTag => widget.itemTag;
  String get _userName => widget.userName;

  TextEditingController _controllerEdit;
  ScrollController _controllerScroll;

  List<Msg> _listMsg = new List();

  FocusNode _focusNode = new FocusNode();

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      Toast.toast(context, '刷新成功');
      setState(() {});
    });
  }

  Future _sendMsg() async {
    _listMsg.add(new Msg(1, 1, _controllerEdit.text, new DateTime.now()));
    setState(() {});
    _controllerEdit.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _controllerScroll.animateTo(
        _controllerScroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  _onEditTab() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      _controllerScroll.animateTo(
        _controllerScroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    _controllerEdit = new TextEditingController();
    _controllerScroll = new ScrollController();
    _listMsg.add(new Msg(-1, 0, '这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息', new DateTime.now()));
    super.initState();
  }

  @override
  void dispose() {
    _controllerEdit.dispose();
    _controllerScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _position;
    return new Hero(
      tag: _itemTag,
      child: new Scaffold(
        backgroundColor: Color(AppColors.AppDeepColor),
        appBar: new AppBar(
          backgroundColor: Color(AppColors.AppWhiteColor),
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0.0,
          title: new Text(
            _userName,
            style: TextStyle(
              color: Color(AppColors.AppTextColor1),
              fontSize: ScreenUtil().setSp(55),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: new IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtil().setWidth(60),
              color: Color(AppColors.AppTextColor1),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.phone, color: Color(AppColors.AppTextColor1), size: ScreenUtil().setWidth(55)),
              onPressed: () {
                Toast.toast(context, '语音通话');
              },
            ),
            new IconButton(
              icon: Icon(Icons.person, color: Color(AppColors.AppTextColor1), size: ScreenUtil().setWidth(55)),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new PersonalPage(name: _userName, headTag: '666', headUrl: AppStyle.userPicture2);
                }));
              },
            ),
          ],
        ),
        body: new Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            new RefreshIndicator(
              child: new Listener(
                child: new ListView.separated(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(260), top: ScreenUtil().setWidth(100)),
                  shrinkWrap: false,
                  physics: BouncingScrollPhysics(),
                  itemCount: _listMsg.length,
                  controller: _controllerScroll,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildMsgItem(index, _listMsg[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return new Container(
                      height: ScreenUtil().setWidth(80),
                    );
                  },
                ),
                onPointerDown: (detail) {
                  _position = detail.position.dy;
                },
                onPointerUp: (detail) {
                  if (_position + ScreenUtil().setWidth(200) < detail.position.dy &&
                      _controllerScroll.offset > _controllerScroll.position.minScrollExtent) {
                    _focusNode.unfocus();
                  } else if (_position - ScreenUtil().setWidth(200) > detail.position.dy &&
                      _controllerScroll.offset >= _controllerScroll.position.maxScrollExtent) {
                    FocusScope.of(context).requestFocus(_focusNode);
                    Future.delayed(const Duration(milliseconds: 300), () {
                      _controllerScroll.animateTo(
                        _controllerScroll.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    });
                  }
                },
              ),
              onRefresh: _onRefresh,
            ),
            _buildMsgEditBox(),
          ],
        ),
      ),
    );
  }

  _buildMsgEditBox() {
    return new Container(
      height: ScreenUtil().setWidth(160),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(AppColors.AppWhiteColor),
        boxShadow: [
          BoxShadow(color: Color(AppColors.AppShadowColor2), blurRadius: 4.0),
        ],
      ),
      child: new Row(
        children: <Widget>[
          new Container(
            width: ScreenUtil().setWidth(110),
            height: ScreenUtil().setWidth(110),
            child: new FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              padding: EdgeInsets.all(0),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Toast.toast(context, '语音');
              },
              child: new Icon(Icons.mic, color: Color(AppColors.AppWhiteColor), size: ScreenUtil().setWidth(60)),
              color: Color(AppColors.AppLabelColor),
            ),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
          ),
          new Flexible(
            child: new Container(
              height: ScreenUtil().setWidth(110),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(20)),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              decoration: BoxDecoration(
                color: Color(AppColors.AppDeepColor),
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              child: new Row(
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                      focusNode: _focusNode,
                      style: TextStyle(fontSize: ScreenUtil().setSp(42), color: Color(AppColors.AppBlackColor1)),
                      textInputAction: TextInputAction.send,
                      controller: _controllerEdit,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: '输入并发送',
                        border: InputBorder.none,
                      ),
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {});
                      },
                      onEditingComplete: () {
                        if (_controllerEdit.text.length != 0) {
                          _sendMsg();
                        } else
                          FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onTap: () async {
                        await _onEditTab();
                      },
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                    width: ScreenUtil().setWidth(80),
                    height: ScreenUtil().setWidth(80),
                    child: new FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                      ),
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Toast.toast(context, '表情');
                      },
                      child: new Icon(Icons.mood, color: Color(AppColors.AppWhiteColor), size: ScreenUtil().setWidth(45)),
                      color: Color(AppColors.AppLabelColor3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
            width: ScreenUtil().setWidth(110),
            height: ScreenUtil().setWidth(110),
            child: new FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              padding: EdgeInsets.all(0),
              onPressed: () {
                if (_controllerEdit.text.length == 0) {
                  Toast.toast(context, '添加');
                } else {
                  _sendMsg();
                }
              },
              child: new Icon(_controllerEdit.text.length == 0 ? Icons.add : Icons.send,
                  color: Color(AppColors.AppWhiteColor), size: ScreenUtil().setWidth(60)),
              color: Color(AppColors.AppLabelColor2),
            ),
          ),
        ],
      ),
    );
  }

  _buildMsgItem(int index, Msg msg) {
    return msg.id == 0 ? _leftMsgBox(msg.msgContent, msg.uId, index) : _rightMsgBox(msg.msgContent, msg.uId, index);
  }

  _leftMsgBox(String content, int uId, int index) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(850)),
          child: new Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(50)),
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
                bottom: ScreenUtil().setHeight(30),
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30)),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppStyle.appRadius * 3),
                bottomLeft: Radius.circular(AppStyle.appRadius * 3),
                bottomRight: Radius.circular(AppStyle.appRadius * 3),
              ),
              color: Color(AppColors.AppWhiteColor),
              boxShadow: [
                BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 2), blurRadius: 5.0),
              ],
            ),
            child: new Text(
              content,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(42),
                color: Color(AppColors.AppTextColor2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _rightMsgBox(String content, int uId, int index) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(850)),
          child: new Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(50)),
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
                bottom: ScreenUtil().setHeight(30),
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30)),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppStyle.appRadius * 3),
                bottomLeft: Radius.circular(AppStyle.appRadius * 3),
                bottomRight: Radius.circular(AppStyle.appRadius * 3),
              ),
              color: Color(AppColors.AppLabelColor),
              boxShadow: [
                BoxShadow(color: Color(AppColors.AppLabelColor).withOpacity(0.3), offset: Offset(0, 2), blurRadius: 5.0),
              ],
            ),
            child: new Text(
              content,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(42),
                color: Color(AppColors.AppWhiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
