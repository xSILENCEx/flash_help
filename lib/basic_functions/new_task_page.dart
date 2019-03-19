import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flash_help/auxiliary/content.dart';
import 'package:flash_help/auxiliary/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:amap_location/amap_location.dart';
//import 'package:simple_permissions/simple_permissions.dart';

class NewTaskPage extends StatefulWidget {
  @override
  _NewTaskPageState createState() => new _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController _controllerTaskName = new TextEditingController();
  TextEditingController _controllerTaskInfo = new TextEditingController();
  TextEditingController _controllerTaskReward = new TextEditingController();

  FocusNode _focusNode = new FocusNode();

  List<String> _taskClass = ['现金', '积分', '无偿'];
  int _chooseClass = 0;
  double _taskMoney = 0.00;
  int _taskIntegral = 0;
  String _location;

  List<String> _taskLabels = ['取件', '外卖', '洗衣', '排队', '功课', '修图', '手工', '代购', '其它'];
  List<bool> _isTaskChosen;

  List<String> _timeLimit = ['时间不限', '限定时间'];
  int _chooseLimit = 0;

  List<String> _picturePath = new List();

  bool _isLocationOpen = true;

  DateTime _pickTime;

  @override
  void initState() {
    super.initState();
    _isTaskChosen = new List(_taskLabels.length);
    _isTaskChosen.fillRange(0, _isTaskChosen.length, false);
    _pickTime = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerTaskName.dispose();
    _controllerTaskInfo.dispose();
    _controllerTaskReward.dispose();
//    AMapLocationClient.shutdown();
  }

  Future<void> _ready() async {
    if (_isLocationOpen) {
      try {
        print('正在尝试定位...');
//        await AMapLocationClient.startup(new AMapLocationOption(desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
//        var l = await AMapLocationClient.getLocation(true);
//        print(l.isSuccess());
//        _location = l.citycode;
      } catch (e) {
        print(e);
      }
    }
  }

//  void _checkPermission() async {
//    bool hasPermission = await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
//    if (!hasPermission) {
//      PermissionStatus requestPermissionResult = await SimplePermissions.requestPermission(Permission.WhenInUseLocation);
//      if (requestPermissionResult.index != 4) {
//        Toast.toast(context, '获取定位权限失败');
//        return;
//      }
//    }
//    AMapLocationClient.onLocationUpate.listen((AMapLocation loc) {
//      if (!mounted) return;
//    });
//
//    AMapLocationClient.startLocation();
//  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      builder: (context, child) {
        return new Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            leading: new IconButton(
                icon: Icon(Icons.close, color: Color(AppColors.AppLabelColor), size: ScreenUtil().setWidth(60)),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('发布新的悬赏', style: TextStyle(fontSize: ScreenUtil().setSp(50))),
            elevation: 0.2,
            actions: <Widget>[
              new IconButton(
                  icon: Icon(Icons.help_outline, color: Color(AppColors.AppLabelColor), size: ScreenUtil().setWidth(60)),
                  onPressed: () {
                    Toast.toast(context, '帮助');
                  }),
            ],
          ),
          body: new ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(250)),
            children: <Widget>[
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
                child: new TextField(
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: '悬赏标题',
                    border: InputBorder.none,
                  ),
                  controller: _controllerTaskName,
                  style: TextStyle(fontSize: ScreenUtil().setSp(42), color: Color(AppColors.AppTextColor1)),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                ),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppLightColor),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(AppStyle.appRadius), topRight: Radius.circular(AppStyle.appRadius)),
                  boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                ),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(30)),
              ),
              new Container(
                width: double.infinity,
                height: 0.5,
                color: Color(AppColors.AppBorderColor),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
              ),
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
                child: new TextField(
                  maxLength: 300,
                  maxLines: 6,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: '悬赏描述',
                    border: InputBorder.none,
                  ),
                  controller: _controllerTaskInfo,
                  style: TextStyle(fontSize: ScreenUtil().setSp(42), color: Color(AppColors.AppTextColor1)),
                ),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppLightColor),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppStyle.appRadius), bottomRight: Radius.circular(AppStyle.appRadius)),
                  boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                ),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
              ),
              new Container(
                width: double.infinity,
                height: ScreenUtil().setWidth(300),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(30)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                child: new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _picturePath.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _picturePath.length)
                      return _buildAddPicture();
                    else
                      return _buildPictureItem(index);
                  },
                  scrollDirection: Axis.horizontal,
                ),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppLightColor),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(AppStyle.appRadius), topRight: Radius.circular(AppStyle.appRadius)),
                  boxShadow: [
                    new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0),
                  ],
                ),
              ),
              new Container(
                width: double.infinity,
                height: 0.5,
                color: Color(AppColors.AppBorderColor),
                margin: EdgeInsets.only(left: 5, right: 5),
              ),
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15)),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppLightColor),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppStyle.appRadius), bottomRight: Radius.circular(AppStyle.appRadius)),
                  boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(
                          _isLocationOpen ? Icons.location_on : Icons.location_off,
                          color: Color(_isLocationOpen ? AppColors.AppLabelColor : AppColors.AppDeepColor),
                          size: ScreenUtil().setWidth(50),
                        ),
                        new Text(_isLocationOpen ? '$_location' : '已隐藏当前位置', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                      ],
                    ),
                    new FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLocationOpen = !_isLocationOpen;
                        });
                      },
                      child: new Text(_isLocationOpen ? '隐藏发布位置' : '显示发布位置', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                    ),
                  ],
                ),
              ),
              new Container(
                height: ScreenUtil().setWidth(150),
                margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppLightColor),
                  borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text('任务类型', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                    new ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                      scrollDirection: Axis.horizontal,
                      itemCount: _taskClass.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildClassItem(index);
                      },
                    ),
                  ],
                ),
              ),
              _chooseClass < 2
                  ? new Container(
                      height: ScreenUtil().setWidth(150),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(
                        color: Color(AppColors.AppLightColor),
                        borderRadius: BorderRadius.circular(AppStyle.appRadius),
                        boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                      ),
                      child: new FlatButton(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                        onPressed: () {
                          _buildDialog();
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('悬赏${_taskClass[_chooseClass]}', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                            new Text(_chooseClass == 0 ? '￥$_taskMoney' : '$_taskIntegral', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppStyle.appRadius),
                        ),
                      ),
                    )
                  : new Container(),
              new Container(
                height: ScreenUtil().setWidth(150),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(30)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppLightColor),
                  borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text('任务标签  ', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                    new Flexible(
                      child: new ListView.builder(
                        padding: EdgeInsets.only(top: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _taskLabels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildTaskLabelList(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: ScreenUtil().setWidth(150),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(30)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                  color: Color(AppColors.AppLightColor),
                  borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text('时间限制', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                    new ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                      scrollDirection: Axis.horizontal,
                      itemCount: _timeLimit.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildTimeLimitItem(index);
                      },
                    ),
                  ],
                ),
              ),
              _chooseLimit > 0
                  ? new Container(
                      height: ScreenUtil().setWidth(150),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(
                        color: Color(AppColors.AppLightColor),
                        borderRadius: BorderRadius.circular(AppStyle.appRadius),
                        boxShadow: [new BoxShadow(color: Color(AppColors.AppShadowColor), offset: Offset(0, 1), blurRadius: 2.0)],
                      ),
                      child: new FlatButton(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                        onPressed: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              if (date.isAfter(_pickTime)) {
                                setState(() {
                                  _pickTime = date;
                                });
                              } else {
                                Toast.toast(context, '不能早于当前时间');
                              }
                            },
                            currentTime: _pickTime,
                            locale: LocaleType.zh,
                            theme: DatePickerTheme(
                              cancelStyle: TextStyle(color: Color(AppColors.AppBlackColor1), fontSize: 16),
                              itemStyle: TextStyle(color: Color(AppColors.AppLabelColor), fontSize: 18),
                              doneStyle: TextStyle(color: Color(AppColors.AppLabelColor), fontSize: 16),
                              backgroundColor: Color(AppColors.AppWhiteColor),
                            ),
                          );
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('点击设置', style: TextStyle(fontSize: ScreenUtil().setSp(40))),
                            new Text(
                              '${_pickTime.year} 年 ${_pickTime.month.toString().padLeft(2, '0')} 月 ${_pickTime.day.toString().padLeft(2, '0')} 日 ${_pickTime.hour.toString().padLeft(2, '0')}:${_pickTime.minute.toString().padLeft(2, '0')}:00  之前',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                              ),
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppStyle.appRadius),
                        ),
                      ),
                    )
                  : new Container(),
            ],
          ),
          bottomNavigationBar: new Container(
            child: new RaisedButton(
              color: Color(AppColors.AppLabelColor),
              child: new Text('确认发布', style: TextStyle(color: Color(AppColors.AppWhiteColor))),
              onPressed: () {
                Toast.toast(context, '暂未开放');
              },
            ),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(AppColors.AppBorderColor), width: 0.5),
                bottom: BorderSide.none,
                left: BorderSide.none,
                right: BorderSide.none,
              ),
            ),
          ),
        );
      },
      future: _ready(),
    );
  }

  _buildClassItem(int index) {
    return new Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
      width: ScreenUtil().setWidth(110),
      child: new FlatButton(
        padding: EdgeInsets.all(0),
        color: _chooseClass == index ? Color(AppColors.AppLabelColor) : Color(AppColors.AppWhiteColor),
        onPressed: () {
          setState(() {
            _chooseClass = index;
          });
        },
        child: new Text(
          _taskClass[index],
          style: TextStyle(
              color: _chooseClass == index ? Color(AppColors.AppWhiteColor) : Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(35)),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(AppColors.AppTextColor1), width: _chooseClass == index ? 0.0 : 1.0),
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
        ),
      ),
    );
  }

  _buildTaskLabelList(int index) {
    return new Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
      width: _taskLabels[index].length * ScreenUtil().setWidth(55),
      child: new FlatButton(
        padding: EdgeInsets.all(0),
        color: _isTaskChosen[index] ? Color(AppColors.AppLabelColor) : Color(AppColors.AppWhiteColor),
        onPressed: () {
          setState(() {
            _isTaskChosen[index] = !_isTaskChosen[index];
          });
        },
        child: new Text(_taskLabels[index],
            style: TextStyle(
                color: _isTaskChosen[index] ? Color(AppColors.AppWhiteColor) : Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(35))),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(AppColors.AppTextColor1), width: _isTaskChosen[index] ? 0.0 : 1.0),
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
        ),
      ),
    );
  }

  _buildTimeLimitItem(int index) {
    return new Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
      width: _timeLimit[index].length * ScreenUtil().setWidth(52),
      child: new FlatButton(
        padding: EdgeInsets.all(0),
        color: _chooseLimit == index ? Color(AppColors.AppLabelColor) : Color(AppColors.AppWhiteColor),
        onPressed: () {
          setState(() {
            _chooseLimit = index;
            Toast.toast(context, _timeLimit[index]);
          });
        },
        child: new Text(_timeLimit[index],
            style: TextStyle(
                color: _chooseLimit == index ? Color(AppColors.AppWhiteColor) : Color(AppColors.AppTextColor1), fontSize: ScreenUtil().setSp(35))),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(AppColors.AppTextColor1), width: _chooseLimit == index ? 0.0 : 1.0),
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
        ),
      ),
    );
  }

  _checkRewardInput() {
    if (_controllerTaskReward.text.length > 0 && num.parse(_controllerTaskReward.text) > 0) {
      if (_chooseClass == 0) {
        _taskMoney = double.parse(_controllerTaskReward.text);
      } else
        _taskIntegral = num.parse(_controllerTaskReward.text);
    }
    _controllerTaskReward.clear();
  }

  _buildPictureItem(int index) {
    return new Container(
      width: ScreenUtil().setWidth(240),
      decoration: BoxDecoration(
        color: Color(AppColors.AppDeepColor),
        borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
      ),
      margin: EdgeInsets.only(right: 5),
      child: new FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
        ),
        padding: EdgeInsets.all(0),
        onPressed: () {
          Toast.toast(context, '点击了第$index张图片');
        },
        child: new Container(
          alignment: Alignment.topRight,
          child: new Container(
            width: ScreenUtil().setWidth(60),
            height: ScreenUtil().setWidth(60),
            child: new FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppStyle.appRadius * 40),
                  bottomRight: Radius.circular(AppStyle.appRadius * 40),
                  bottomLeft: Radius.circular(AppStyle.appRadius * 40),
                  topRight: Radius.circular(AppStyle.appRadius * 10),
                ),
              ),
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  _picturePath.removeAt(index);
                });
                Toast.toast(context, '取消第$index张图片');
              },
              child: new Icon(
                Icons.close,
                color: Color(AppColors.AppLightColor),
                size: 10,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(AppColors.AppLabelColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppStyle.appRadius * 40),
                bottomRight: Radius.circular(AppStyle.appRadius * 40),
                bottomLeft: Radius.circular(AppStyle.appRadius * 40),
                topRight: Radius.circular(AppStyle.appRadius * 10),
              ),
            ),
            margin: EdgeInsets.all(2),
          ),
        ),
      ),
    );
  }

  _buildAddPicture() {
    return new Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(300) - 20,
      decoration: BoxDecoration(
        color: Color(AppColors.AppDeepColor),
        borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
      ),
      margin: EdgeInsets.only(right: 5),
      child: new FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.appRadius / 2),
        ),
        onPressed: () {
          setState(() {
            _picturePath.add('哈哈哈哈');
          });
          Toast.toast(context, '添加一张图片');
        },
        child: new Container(
          width: double.infinity,
          height: double.infinity,
          child: new Icon(
            Icons.add,
            color: Color(AppColors.AppLabelColor),
          ),
        ),
      ),
    );
  }

  _buildDialog() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return new Material(
          color: Color(AppColors.AppTranslateColor),
          child: new InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
              _controllerTaskReward.clear();
            },
            child: new ListView(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                    color: Color(AppColors.AppWhiteColor),
                    borderRadius: BorderRadius.circular(AppStyle.appRadius),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        _chooseClass == 0 ? '金额' : '积分数量',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(40),
                          color: Color(AppColors.AppTextColor2),
                        ),
                      ),
                      new Container(
                        width: double.infinity,
                        height: ScreenUtil().setWidth(2),
                        color: Color(AppColors.AppTextColor),
                        margin: EdgeInsets.only(top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(60)),
                      ),
                      new Container(
                        height: ScreenUtil().setWidth(120),
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(80),
                          right: ScreenUtil().setWidth(80),
                          bottom: ScreenUtil().setWidth(40),
                        ),
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60)),
                        decoration: BoxDecoration(
                          color: Color(AppColors.AppDeepColor),
                          borderRadius: BorderRadius.circular(AppStyle.appRadius * 40),
                        ),
                        child: new TextField(
                          autofocus: true,
                          style: TextStyle(fontSize: ScreenUtil().setSp(38), color: Color(AppColors.AppTextColor1)),
                          controller: _controllerTaskReward,
                          decoration: InputDecoration(
                            hintText: _chooseClass == 0 ? '￥$_taskMoney' : '$_taskIntegral',
                            border: InputBorder.none,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onEditingComplete: () {
                            Navigator.pop(context);
                            _checkRewardInput();
                          },
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                            child: new FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppStyle.appRadius),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                _controllerTaskReward.clear();
                              },
                              child: new Text(
                                '取消',
                                style: TextStyle(
                                  color: Color(AppColors.AppLabelColor),
                                  fontSize: ScreenUtil().setSp(46),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Color(AppColors.AppTranslateColor),
                              padding: EdgeInsets.all(0),
                            ),
                            fit: FlexFit.tight,
                          ),
                          new Flexible(
                            child: new FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppStyle.appRadius),
                              ),
                              onPressed: () {
                                _checkRewardInput();
                                Navigator.pop(context);
                              },
                              child: new Text(
                                '确定',
                                style: TextStyle(
                                  color: Color(AppColors.AppLabelColor),
                                  fontSize: ScreenUtil().setSp(46),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: Color(AppColors.AppTranslateColor),
                              padding: EdgeInsets.all(0),
                            ),
                            fit: FlexFit.tight,
                          ),
                        ],
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(500), left: ScreenUtil().setWidth(160), right: ScreenUtil().setWidth(160)),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
