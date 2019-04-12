import 'package:flutter/material.dart';

Widget withScaffold({Widget body, String title}) {
  return Scaffold(
    backgroundColor: Colors.blueGrey,
    body: body,
  );
}

Widget addSymetricMargin({Widget child, double horizontal = 0.0, double vertical = 0.0}) {
  return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: child);
}

Widget addMargin({Widget child, double top = 0.0, double bottom = 0.0, double left = 0.0, double right = 0.0}) {
    return Container(
        margin: EdgeInsets.only(
            top: top,
            bottom: bottom,
            left: left,
            right: right
        ),
        child: child);
}

class RemoveDefaultScrollGlowBehavior extends ScrollBehavior {
    @override
    Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
        return child;
    }
}

textStyleMedium({double fontSize}) {
    return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w700);
}

textStyleRegular({double fontSize}) {
    return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w400);
}

textStyleLight({double fontSize}) {
    return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w200);
}

_textStyle({double fontSize, fontWeight: FontWeight}) {
    return TextStyle(fontSize: fontSize, color: Colors.white, fontWeight: fontWeight, fontFamily: 'Montserrat');
}

Size contentSizeByKey(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final size = renderBox.size;
    return size;
}