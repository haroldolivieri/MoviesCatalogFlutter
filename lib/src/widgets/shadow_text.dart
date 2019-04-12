import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizedShadowText extends StatelessWidget {
  final TextAlign textAlign;
  final String data;
  final TextStyle style;
  final int maxLines;

  AutoSizedShadowText(this.data, {this.style, this.maxLines, this.textAlign}) : assert(data != null);

  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: 2.0,
            left: 2.0,
            child: Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: AutoSizeText(
              data,
              maxLines: maxLines,
              textAlign: textAlign,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
