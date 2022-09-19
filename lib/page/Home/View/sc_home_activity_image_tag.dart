

import 'package:flutter/cupertino.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 图片右上角的标签

class SCHomeActivityImageTag extends StatelessWidget {

  final String title;

  const SCHomeActivityImageTag({Key? key, required this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    /// 最多显示6个字
    String text = title.length > 6 ? title.substring(0, 6) : title;
    return Container(
      height: 18.0,
      decoration: const BoxDecoration(
        color: SCColors.color_ABABAB,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          color: SCColors.color_FFFFFF,
          fontSize: SCFonts.f12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}