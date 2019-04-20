import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flash_help/basic_classes.dart';
import 'package:flash_help/first_page/detail_page/personal_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';

class ChatPage extends StatefulWidget {
  final String itemTag;
  final String userName;

  const ChatPage({Key key, this.itemTag, this.userName}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  String get _itemTag => widget.itemTag;
  String get _userName => widget.userName;

  TextEditingController _controllerEdit;
  ScrollController _controllerScroll;

  List<Msg> _listMsg = List();

  FocusNode _focusNode = FocusNode();

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      Toast.toast(context, '刷新成功');
      setState(() {});
    });
  }

  Future _sendMsg() async {
    _listMsg.add(Msg(1, 1, _controllerEdit.text, DateTime.now()));
    _controllerEdit.clear();
    setState(() {});
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
    _controllerEdit = TextEditingController();
    _controllerScroll = ScrollController();
    _listMsg.add(Msg(
        -1,
        0,
        '这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息这是一条测试消息',
        DateTime.now()));
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
    return Hero(
      tag: _itemTag,
      child: Scaffold(
        backgroundColor: Color(AppColors.AppDeepColor),
        appBar: AppBar(
          backgroundColor: Color(AppColors.AppMainColor),
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            _userName,
            style: TextStyle(
              color: Color(AppColors.AppTitleColor),
              fontSize: ScreenUtil().setSp(55),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtil().setWidth(60),
              color: Color(AppColors.AppTitleColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone,
                  color: Color(AppColors.AppTitleColor),
                  size: ScreenUtil().setWidth(55)),
              onPressed: () {
                Toast.toast(context, '语音通话');
              },
            ),
            IconButton(
              icon: Icon(Icons.person,
                  color: Color(AppColors.AppTitleColor),
                  size: ScreenUtil().setWidth(55)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return PersonalPage(
                      name: _userName,
                      headTag: '666',
                      headUrl: AppStyle.userPicture2);
                }));
              },
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            RefreshIndicator(
              child: Listener(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                      bottom: ScreenUtil().setWidth(260),
                      top: ScreenUtil().setWidth(100)),
                  shrinkWrap: false,
                  physics: BouncingScrollPhysics(),
                  itemCount: _listMsg.length,
                  controller: _controllerScroll,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildMsgItem(index, _listMsg[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: ScreenUtil().setWidth(80),
                    );
                  },
                ),
                onPointerDown: (detail) {
                  _position = detail.position.dy;
                },
                onPointerUp: (detail) {
                  if (_position + ScreenUtil().setWidth(200) <
                          detail.position.dy &&
                      _controllerScroll.offset >
                          _controllerScroll.position.minScrollExtent) {
                    _focusNode.unfocus();
                  } else if (_position - ScreenUtil().setWidth(200) >
                          detail.position.dy &&
                      _controllerScroll.offset >=
                          _controllerScroll.position.maxScrollExtent) {
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
    return Container(
      height: ScreenUtil().setWidth(160),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(AppColors.AppMainColor),
        boxShadow: [
          BoxShadow(color: Color(AppColors.AppShadowColor), blurRadius: 4.0),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(110),
            height: ScreenUtil().setWidth(110),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              padding: EdgeInsets.all(0),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Toast.toast(context, '语音');
              },
              child: Icon(Icons.mic,
                  color: Color(AppColors.AppMainColor),
                  size: ScreenUtil().setWidth(60)),
              color: Color(AppColors.AppThemeColor),
            ),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
          ),
          Flexible(
            child: Container(
              height: ScreenUtil().setWidth(110),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(60),
                  right: ScreenUtil().setWidth(20)),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              decoration: BoxDecoration(
                color: Color(AppColors.AppDeepColor),
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      focusNode: _focusNode,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(42),
                          color: Color(AppColors.AppTitleColor)),
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
                      onEditingComplete: () async {
                        if (_controllerEdit.text.length != 0) {
                          await _sendMsg();
                        } else
                          FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onTap: () async {
                        await _onEditTab();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                    width: ScreenUtil().setWidth(80),
                    height: ScreenUtil().setWidth(80),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppStyle.appRadius * 40),
                      ),
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Toast.toast(context, '表情');
                      },
                      child: Icon(Icons.mood,
                          color: Color(AppColors.AppMainColor),
                          size: ScreenUtil().setWidth(45)),
                      color: Color(AppColors.AppDotColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20)),
            width: ScreenUtil().setWidth(110),
            height: ScreenUtil().setWidth(110),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
              ),
              padding: EdgeInsets.all(0),
              onPressed: () async {
                if (_controllerEdit.text.length == 0) {
                  Toast.toast(context, '添加');
                } else {
                  await _sendMsg();
                }
              },
              child: Icon(
                  _controllerEdit.text.length == 0
                      ? Icons.add
                      : Boxicons.bxsSend,
                  color: Color(AppColors.AppMainColor),
                  size: ScreenUtil().setWidth(60)),
              color: Color(AppColors.AppThemeColor2),
            ),
          ),
        ],
      ),
    );
  }

  _buildMsgItem(int index, Msg msg) {
    return msg.id == 0
        ? _leftMsgBox(msg.msgContent, msg.uId, index)
        : _rightMsgBox(msg.msgContent, msg.uId, index);
  }

  _leftMsgBox(String content, int uId, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(850)),
          child: Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setWidth(30),
                left: ScreenUtil().setWidth(50)),
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
                bottom: ScreenUtil().setHeight(30),
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppStyle.appRadius * 3),
                bottomLeft: Radius.circular(AppStyle.appRadius * 3),
                bottomRight: Radius.circular(AppStyle.appRadius * 3),
              ),
              color: Color(AppColors.AppMainColor),
              boxShadow: [
                BoxShadow(
                    color: Color(AppColors.AppShadowColor),
                    offset: Offset(0, 2),
                    blurRadius: 5.0),
              ],
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(42),
                color: Color(AppColors.AppTitleColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _rightMsgBox(String content, int uId, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(850)),
          child: Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(50)),
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
                bottom: ScreenUtil().setHeight(30),
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppStyle.appRadius * 3),
                bottomLeft: Radius.circular(AppStyle.appRadius * 3),
                bottomRight: Radius.circular(AppStyle.appRadius * 3),
              ),
              color: Color(AppColors.AppThemeColor),
              boxShadow: [
                BoxShadow(
                    color: Color(AppColors.AppThemeColor).withOpacity(0.3),
                    offset: Offset(0, 2),
                    blurRadius: 5.0),
              ],
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(42),
                color: Color(AppColors.AppMainColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
