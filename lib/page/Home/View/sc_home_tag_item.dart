

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/sc_fonts.dart';

/// 标签item

class SCHomeTagItem extends StatelessWidget {

  SCHomeTagItem({Key? key,
    required this.title,
    required this.tagFont,
    required this.height,
    required this.backgroundColor,
    required this.textColor})
      : super(key: key);

  String title;
  double tagFont = SCFonts.f10;
  double height = 16.0;
  Color backgroundColor;
  Color textColor;
  /// scale
  final double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    /// 最多显示6个字
    String text = title.length > 6 ? title.substring(0, 6) : title;
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(2.0)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        strutStyle: StrutStyle(
          fontSize: tagFont * scale,
          height: 1.1,
          forceStrutHeight: true,
        ),
        style: TextStyle(
            fontSize: tagFont * scale,
            color: textColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
