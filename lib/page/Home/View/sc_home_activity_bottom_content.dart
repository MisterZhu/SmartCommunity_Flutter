

import 'package:flutter/cupertino.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 活动cell图片下面的标题和内容，高度46

class SCHomeActivityBottomContent extends StatelessWidget {

  String title;
  String content;

  SCHomeActivityBottomContent({Key? key,
    required this.title,
    required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4.0,),
        SizedBox(
          height: 22.0,
          child: Text(
            title,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w500,
                color: SCColors.color_1B1D33),),
        ),
        const SizedBox(height: 2.0,),
        SizedBox(
          height: 18.0,
          child: Text(
            content,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99),),),
      ],
    );
  }
}