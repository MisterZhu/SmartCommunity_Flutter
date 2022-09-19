

import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/page/Home/View/sc_home_tag_item.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 顶部的icon、标题、tag标签

class SCHomeActivityTopItem extends StatelessWidget {

  /// icon样式类型，0=标题左边没有icon，1=标题左边有icon，
  late int iconType;
  /// tag标签样式类型，0=没有tag标签，1=tag标签在标题后面，2=tag标签在右侧
  late int tagType;

  String title;
  String? icon;
  String tagText;
  double tagFont = SCFonts.f10;
  double tagHeight = 16.0;
  Color tagBgColor;
  Color tagTextColor;

  SCHomeActivityTopItem({Key? key,
    required this.iconType,
    required this.icon,
    required this.title,
    required this.tagType,
    required this.tagText,
    required this.tagFont,
    required this.tagHeight,
    required this.tagBgColor,
    required this.tagTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return SizedBox(
      height: 22.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Offstage(
            offstage: iconType == 0 ? true : false,
            child: Padding(
                padding: const EdgeInsets.only(right: 6.0,),
                child: Image.asset(SCAsset.iconScan, width: 22.0, height: 22.0, color: SCColors.color_FCD6AD,)),
          ),
          titleItem(),
          const SizedBox(width: 8.0,),
          Offstage(
            offstage: tagType == 0 ? true : false,
            child: SCHomeTagItem(
                title: tagText,
                tagFont: tagFont,
                height: tagHeight,
                textColor: tagTextColor,
                backgroundColor: tagBgColor),
          )
        ],
      ),
    );
  }

  /// 标题
  Widget titleItem() {
    if (tagType == 1) {
      return textItem();
    } else {
      return Expanded(child: textItem());
    }
  }

  Widget textItem() {
    /// 最多显示6个字
    String text = title.length > 6 ? title.substring(0, 6) : title;
    return Text(
      text,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }
}