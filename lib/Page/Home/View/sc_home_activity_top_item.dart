

import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Home/View/sc_home_tag_item.dart';
import '../../../Constants/sc_asset.dart';

/// 顶部的icon、标题、tag标签
// icon样式
enum IconStyle {
  // 标题左边没有icon
  none,
  // 标题左边有icon
  left,
}

// tag标签样式
enum TagStyle {
  // 没有tag标签
  none,
  // tag标签在标题后面
  left,
  // tag标签在右侧
  right,
}

class SCHomeActivityTopItem extends StatelessWidget {

  /// icon样式
  final IconStyle iconStyle;
  /// 标签样式
  final TagStyle tagStyle;

  final String title;
  final String? icon;
  final String tagText;
  final double tagFont;
  final double tagHeight;
  final Color tagBgColor;
  final Color tagTextColor;

  const SCHomeActivityTopItem({Key? key,
    required this.iconStyle,
    required this.icon,
    required this.title,
    required this.tagStyle,
    required this.tagText,
    this.tagHeight = 16.0,
    this.tagFont = SCFonts.f10,
    required this.tagBgColor,
    required this.tagTextColor,})
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
          iconItem(),
          titleItem(),
          const SizedBox(width: 8.0,),
          tagItem(),
        ],
      ),
    );
  }

  /// 标题前面的icon
  Widget iconItem() {
    return Offstage(
      offstage: iconStyle == IconStyle.none ? true : false,
      child: Padding(
          padding: const EdgeInsets.only(right: 6.0,),
          child: Image.asset(SCAsset.iconScan, width: 22.0, height: 22.0, color: SCColors.color_FCD6AD,)),
    );
  }

  /// 标题
  Widget titleItem() {
    if (tagStyle == TagStyle.left) {
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

  /// 标签item
  Widget tagItem() {
    return Offstage(
      offstage: tagStyle == TagStyle.none ? true : false,
      child: SCHomeTagItem(
          title: tagText,
          tagFont: tagFont,
          height: tagHeight,
          textColor: tagTextColor,
          backgroundColor: tagBgColor),
    );
  }
}