

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constants/sc_fonts.dart';

/// 标签item

class SCHomeTagItem extends StatelessWidget {

  /// 标签最大宽度,默认100.0
  final double maxWidth;

  final String title;
  final double tagFont;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  /// scale
  final double scale = 1.0;

  const SCHomeTagItem({Key? key,
    required this.title,
    this.maxWidth = 100.0,
    this.height = 16.0,
    this.tagFont = SCFonts.f10,
    required this.backgroundColor,
    required this.textColor})
      : super(key: key);

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
      child: LimitedBox(
        maxWidth: maxWidth,
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
      ),
    );
  }
}
