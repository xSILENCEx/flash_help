import 'package:flutter/material.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskLabelPage extends StatefulWidget {
  @override
  _TaskLabelPageState createState() => new _TaskLabelPageState();
}

class _TaskLabelPageState extends State<TaskLabelPage> {
  List<String> _taskLabels = ['取件', '外卖', '洗衣', '排队', '功课', '修图', '手工', '代购', '其它'];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
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
    return new RefreshIndicator(
      backgroundColor: Color(AppColors.AppLabelColor),
      onRefresh: _onRefresh,
      color: Colors.white,
      child: new GridView.builder(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(50),
          bottom: ScreenUtil().setWidth(250),
          left: ScreenUtil().setWidth(50),
          right: ScreenUtil().setWidth(50),
        ),
        itemCount: _taskLabels.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemBuilder: (BuildContext context, int index) {
          return _buildLabelItem(index);
        },
      ),
    );
  }

  _buildLabelItem(int index) {
    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          new Container(
            height: ScreenUtil().setWidth(320),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppStyle.appRadius),
                topRight: Radius.circular(AppStyle.appRadius),
              ),
              image: DecorationImage(
                image: AssetImage('images/task_label.jpg'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(color: Color(AppColors.AppShadowColor2),blurRadius: 3.0),
              ],
            ),
          ),
          new Flexible(
            child: new Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(AppColors.AppWhiteColor),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(AppStyle.appRadius),
                  bottomLeft: Radius.circular(AppStyle.appRadius),
                ),
                boxShadow: [
                  BoxShadow(color: Color(AppColors.AppShadowColor2),blurRadius: 3.0),
                ],
              ),
              child: Text('#${_taskLabels[index]}', style: TextStyle(color: Color(AppColors.AppLabelColor), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      onTap:(){
        Toast.toast(context, _taskLabels[index]);
      },
    );
  }
}
