

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 首页活动cell图片下半部分半透明的标签

class SCHomeActivityBottomTag extends StatelessWidget {

  final String title;

  const SCHomeActivityBottomTag({Key? key, required this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 0),
            Color.fromRGBO(0, 0, 0, 0.6),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        child: Text(
          title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            color: SCColors.color_FFFFFF,
            fontSize: SCFonts.f12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}