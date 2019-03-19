import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _editingController;

  List<String> _hList = new List();

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    _editingController = new TextEditingController();
    _hList.add('流浪地球');
    _ready();
    super.initState();
  }

  void _ready() {
    Future.delayed(const Duration(milliseconds: 200), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(AppColors.AppLabelColor),
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: null,
        title: new Container(
          alignment: Alignment.centerLeft,
          height: ScreenUtil().setWidth(100),
          decoration: BoxDecoration(
            color: Color(AppColors.AppWhiteColor3),
            borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
          ),
          child: new Row(
            children: <Widget>[
              new IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: ScreenUtil().setWidth(45),
                  color: Color(AppColors.AppTextColor1),
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pop(context);
                },
                padding: EdgeInsets.all(0),
              ),
              new Flexible(
                child: new TextField(
                  focusNode: _focusNode,
                  style: TextStyle(fontSize: ScreenUtil().setSp(42), color: Color(AppColors.AppTextColor1)),
                  textInputAction: TextInputAction.search,
                  controller: _editingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: '热搜词',
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                  onEditingComplete: () {
                    if (_editingController.text.length > 0) {
                      setState(() {
                        _hList.add(_editingController.text);
                        _editingController.clear();
                      });
                    }
                  },
                ),
              ),
              new IconButton(
                icon: Icon(
                  Icons.close,
                  size: ScreenUtil().setWidth(45),
                  color: Color(AppColors.AppTextColor1),
                ),
                onPressed: () {
                  if (_editingController.text.length > 0) {
                    _editingController.clear();
                  }
                },
                padding: EdgeInsets.all(0),
              ),
            ],
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
            child: new Text(
              '搜索历史',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(42),
                fontWeight: FontWeight.bold,
                color: Color(AppColors.AppTextColor1),
              ),
            ),
          ),
          new Container(
            child: new Wrap(
              children: _buildHisItem(_hList),
            ),
          ),
        ],
      ),
    );
  }

  _buildHisItem(List<String> hisList) {
    List<Widget> _hisList = new List<Widget>();

    for (int i = 0; i < hisList.length; i++) {
      _hisList.add(
        new Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
          child: new Chip(
            labelPadding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
            label: Text(hisList[i]),
            onDeleted: () {
              setState(() {
                _hisList.removeAt(i);
                _hList.removeAt(i);
              });
            },
            deleteIcon: Icon(Icons.cancel, size: ScreenUtil().setWidth(50), color: Color(AppColors.AppTextColor1)),
          ),
        ),
      );
    }
    return _hisList;
  }
}
