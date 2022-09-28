
import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/constants/sc_asset.dart';

import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';

/// 登录页面顶部item

class SCLoginHeader extends StatelessWidget {
  const SCLoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        bgImageItem(),
        titleItem()
      ],
    );
  }

  /// 背景图片
  Widget bgImageItem() {
    double imageScale = 750 / 474.0;
    return AspectRatio(
      aspectRatio: imageScale,
      child: Image.asset(
        SCAsset.iconLoginTopBg,
        fit: BoxFit.fill,
      ),
    );
  }

  /// 文字item
  Widget titleItem() {
    return const Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 35.0, top: 0.0),
      child: Text('欢迎进入邑生活',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f22,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1C33,
        ),),
    );
  }
}