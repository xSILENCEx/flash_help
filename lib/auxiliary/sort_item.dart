import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortItem extends StatefulWidget {
  final List<String> sortList;
  final String title;

  const SortItem({Key key, @required this.sortList, @required this.title}) : super(key: key);

  @override
  _SortItemState createState() => new _SortItemState();
}

class _SortItemState extends State<SortItem> {
  List<String> get _sortList => widget.sortList;
  String get _title => widget.title;

  int _chooseMethod = 0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil.screenWidthDp,
      height: ScreenUtil().setHeight(100),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '  $_title  ',
            style: TextStyle(
              color: Color(AppColors.AppTextColor1),
              fontSize: ScreenUtil().setSp(40),
              fontWeight: FontWeight.bold,
            ),
          ),
          new Flexible(
            child: new ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(15), bottom: ScreenUtil().setWidth(15)),
              scrollDirection: Axis.horizontal,
              itemCount: _sortList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildSortItem(index);
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(AppColors.AppWhiteColor),
//          border: Border(
//            top: BorderSide.none,
//            left: BorderSide.none,
//            right: BorderSide.none,
//            bottom: BorderSide(color: Color(AppColors.AppBorderColor),width: 0.1),
//          ),
      ),
    );
  }

  _buildSortItem(int index) {
    return new Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
      width: _sortList[index].length * ScreenUtil().setWidth(50),
      child: new FlatButton(
        padding: EdgeInsets.all(0),
        color: _chooseMethod == index ? Color(AppColors.AppLabelColor) : Color(AppColors.AppWhiteColor),
        onPressed: () {
          setState(() {
            _chooseMethod = index;
            Toast.toast(context, _sortList[index]);
          });
        },
        child: new Text(
          _sortList[index],
          style: TextStyle(
            color: _chooseMethod == index ? Color(AppColors.AppWhiteColor) : Color(AppColors.AppTextColor1),
            fontSize: ScreenUtil().setSp(34),
            height: ScreenUtil().setWidth(3),
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(AppColors.AppTextColor1), width: _chooseMethod == index ? 0.0 : 0.8),
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
        ),
      ),
    );
  }
}
