import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Toast {
  static OverlayEntry _overlayEntry; //toast靠它加到屏幕上
  static bool _showing = false; //toast是否正在showing
  static DateTime _startedTime; //开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static String _msg;

  static void toast(
    BuildContext context,
    String msg,
  ) async {
    assert(msg != null);
    _msg = msg;
    _startedTime = DateTime.now();
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
              //top值，可以改变这个值来改变toast在屏幕中的位置
              top: MediaQuery.of(context).size.height * 8 / 10,
              child: new Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: AnimatedOpacity(
                    opacity: _showing ? 1.0 : 0.0, //目标透明度
                    duration: _showing ? Duration(milliseconds: 100) : Duration(milliseconds: 400),
                    child: _showing ? _buildToastWidget() : null,
                  ),
                ),
              ),
            ),
      );
      overlayState.insert(_overlayEntry);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: 2000)); //等待两秒

    //2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= 2000) {
      _showing = false;
      _overlayEntry.markNeedsBuild();
    }
  }

  //toast绘制
  static _buildToastWidget() {
    return new Center(
      child: new Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(30), bottom: ScreenUtil().setHeight(30), left: ScreenUtil().setHeight(50), right: ScreenUtil().setHeight(50)),
        child: new Material(
          color: Color.fromARGB(0, 0, 0, 0),
          child: new Text(
            '$_msg',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(36),
            ),
          ),
        ),
        decoration: new BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(200)),
        ),
      ),
    );
  }
}
