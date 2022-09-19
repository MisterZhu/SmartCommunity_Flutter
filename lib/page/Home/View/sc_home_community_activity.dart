import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_bottom_content.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_bottom_tag.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_image_tag.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_top_item.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 首页-园区活动cell，图片大小106*102

class SCHomeCommunityActivity extends StatelessWidget {
  final String title = '园区活动';
  /// cell样式类型，1=图片下面没有标题，2=图片下面有标题内容
  final int cellType;

  final List activityList;

  /// cell点击事件
  final Function(int index)? tapAction;

  /// 图片宽度
  final double imageWidth = (SCUtils().getScreenWidth() - 56.0) / 3.0;

  /// 图片下面内容的高度
  final double bottomContentHeight = 46.0;

  SCHomeCommunityActivity({Key? key,
    required this.cellType,
    required this.activityList,
    this.tapAction
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(6.0)),
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
        iconType: 0,
        icon: '',
        title: title,
        tagType: 1,
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
          padding:
          const EdgeInsets.only(left: 6.0, right: 6, top: 2, bottom: 6),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return activityCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 6.0,
            );
          },
          itemCount: activityList.length > 3 ? 3 : activityList.length),
    );
  }

  /// cell
  Widget activityCell(int index) {
    return GestureDetector(
      onTap: () {
        if (tapAction != null) {
          tapAction?.call(index);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topItem(index),
          bottomItem(),
        ],
      ),
    );
  }

  /// 上面的图片、标签
  Widget topItem(int index) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
      width: imageWidth,
      height: imageHeight(),
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: activityImageItem(index)),
          Positioned(
            top: 0.0,
            right: 5.5,
            child: Offstage(
              offstage: index == 0 ? false : true,
              child: SCHomeActivityImageTag(title: '图片标签'),
          )),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: SCHomeActivityBottomTag(title: '图片底部的标签')),
        ],
      ),
    );
  }

  /// 活动-image
  Widget activityImageItem(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset(
        activityList[index],
        fit: BoxFit.cover,
      ),
    );
  }

  /// 底部的标题、内容
  bottomItem() {
    if (cellType == 1) {
      return Container();
    } else if (cellType == 2){
      return SizedBox(
          width: imageWidth,
          height: bottomContentHeight,
          child: SCHomeActivityBottomContent(
            title: '标题名称名称',
            content: '标题内容内容内容',
          )
      );
    } else {
      return Container();
    }
  }

  /// 图片的高度
  double imageHeight() {
    return imageWidth * 102.0 / 107.0;
  }

  /// cell高度
  double cellHeight() {
    if (cellType == 1) {
      return imageHeight() + 8; /// 这里的8是cell上下的间距
    } else if (cellType == 2) {
      return imageHeight() + bottomContentHeight + 8;
    }
    return imageHeight() + 8;
  }
}
