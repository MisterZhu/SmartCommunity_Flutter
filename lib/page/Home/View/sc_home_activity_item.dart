import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_top_item.dart';

/// 首页-热门活动

class SCHomeActivityItem extends StatelessWidget {
  final String title = '热门活动';

  final List activityList;

  /// 标题字体大小
  final double titleFont = SCFonts.f14;

  /// 活动标题字体大小
  final double activityTitleFont = SCFonts.f14;

  /// 活动标题-顶部的间距
  final double activityTitleTopSpace = 7.0;

  /// 活动内容字体大小
  final double activityContentFont = SCFonts.f12;

  /// scale
  final double scale = 1.0;

  /// 图片大小
  final double imageSize = 108.0;

  /// listview-separator宽度
  final double separatorSize = 5.0;

  /// 点击回调
  final Function(int index)? onTap;

  const SCHomeActivityItem({Key? key, required this.activityList, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 6.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            titleItem(),
            activityListView(),
          ],
        ),
      ),
    );
  }

  /// title
  Widget titleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: SCHomeActivityTopItem(
        iconStyle: IconStyle.left,
        icon: '',
        title: title,
        tagStyle: TagStyle.right,
        tagText: '标签名称',
        tagFont: SCFonts.f10,
        tagHeight: 16.0,
        tagBgColor: SCColors.color_FF6C00,
        tagTextColor: SCColors.color_FFFFFF,
      ),
    );
  }

  /// 活动列表
  Widget activityListView() {
    return SizedBox(
      height: cellHeight(),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 6.0, right: 0, top: 0, bottom: 0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return activityCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: separatorSize,
            );
          },
          itemCount: activityList.length),
    );
  }

  /// cell
  Widget activityCell(int index) {
    return GestureDetector(
      onTap: () {
        itemTap(index: index);
      },
      child: SizedBox(
        width: imageSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            activityImageItem(index),
            SizedBox(
              height: activityTitleTopSpace,
            ),
            activityTitleItem(),
            activityContentItem(),
          ],
        ),
      ),
    );
  }

  /// 活动-image
  Widget activityImageItem(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(activityList[index], width: imageSize, height: imageSize,),
    );
  }

  /// 活动-title
  Widget activityTitleItem() {
    return SizedBox(
      height: activityTitleHeight(),
      child: Text('我是歌手', textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
        fontSize: activityTitleFont * scale,
        fontWeight: FontWeight.w400,
        color: SCColors.color_272625,
      ),),
    );
  }
  /// 活动-content
  Widget activityContentItem() {
    return SizedBox(
      height: activityContentHeight(),
      child: Text('流动是我旋律', textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
          fontSize: activityContentFont * scale,
          fontWeight: FontWeight.w400,
          color: SCColors.color_BABABA
      ),),
    );
  }

  /// 标题文本高度
  double titleHeight() {
    return (titleFont + 8) * scale;
  }

  /// cell高度
  double cellHeight() {
    double height = 0;
    height = imageSize + activityTitleTopSpace + activityTitleHeight() + activityContentHeight();
    return height;
  }

  /// 活动标题文本高度
  double activityTitleHeight() {
    return (activityTitleFont + 8) * scale;
  }

  /// 活动内容文本高度
  double activityContentHeight() {
    return (activityContentFont + 6) * scale;
  }

  /// item点击
  itemTap({required int index}) {
    if (onTap != null) {
      onTap?.call(index);
    }
  }
}
