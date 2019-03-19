import 'package:flutter/material.dart';

class SearchHistoryDelegate extends FlowDelegate {
  var _margin = EdgeInsets.zero;

  SearchHistoryDelegate(this._margin);

  @override
  void paintChildren(FlowPaintingContext context) {
    var offsetX = _margin.left;
    var offsetY = _margin.top;
    var winSizeWidth = context.size.width;

    for (int i = 0; i < context.childCount; i++) {
      var w = offsetX + context.getChildSize(i).width + _margin.right;

      if (w < winSizeWidth) {
        context.paintChild(i, transform: new Matrix4.translationValues(offsetX, offsetY, 0.0));
        offsetX = w + _margin.left;
      } else {
        offsetX = _margin.left;
        offsetY += context.getChildSize(i).height + _margin.bottom + _margin.top;
        context.paintChild(i, transform: new Matrix4.translationValues(offsetX, offsetY, 0.0));
        offsetX += context.getChildSize(i).width + _margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }
}
