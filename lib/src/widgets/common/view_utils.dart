import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
  return Container(margin: EdgeInsets.only(top: top, bottom: bottom, left: left, right: right), child: child);
}

double distortionBasedOnPage(double page, int index) {
  const SCALE_FRACTION = 0.3;
  const FULL_SCALE = 1.0;
  
  final diffPosition = page - index;
  double normalizedDistortion = (FULL_SCALE - (diffPosition.abs() * SCALE_FRACTION)).clamp(0.0, 1.0);
  return normalizedDistortion;
}

class RemoveDefaultScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

textStyleMedium({double fontSize, Color color = Colors.white}) {
  return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: color);
}

textStyleRegular({double fontSize, Color color = Colors.white}) {
  return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w400, color: color);
}

textStyleLight({double fontSize, Color color = Colors.white}) {
  return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w200, color: color);
}

_textStyle({double fontSize, fontWeight: FontWeight, Color color}) {
  return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight, fontFamily: 'Montserrat');
}

Size contentSizeByKey(GlobalKey key) {
  final RenderBox renderBox = key.currentContext.findRenderObject();
  final size = renderBox.size;
  return size;
}

backgroundImage({parentHeight: double, String url}) {
  return Hero(
    tag: url,
    child: Stack(
      children: <Widget>[
        FadeInImage.memoryNetwork(
          key: ValueKey(url),
          height: parentHeight,
          fit: BoxFit.cover,
          image: "https://image.tmdb.org/t/p/w200$url",
          placeholder: kTransparentImage,
        ),
        BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: new Container(
            height: parentHeight,
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
          ),
        )
      ],
    ),
  );
}

backgroundImageNotBlured({parentHeight: double, String url}) {
  return Hero(
    tag: url,
    child: Stack(
      children: <Widget>[
        FadeInImage.memoryNetwork(
          key: ValueKey(url),
          height: parentHeight,
          fit: BoxFit.cover,
          image: "https://image.tmdb.org/t/p/original$url",
          placeholder: kTransparentImage,
        ),
        Container(
          height: parentHeight,
          decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
        )
      ],
    ),
  );
}
