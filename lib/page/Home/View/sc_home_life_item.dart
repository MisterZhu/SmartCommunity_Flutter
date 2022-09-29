import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_bottom_content.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_image_tag.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_top_item.dart';

import '../../../constants/sc_enum.dart';

/// 首页-美好生活cell

class SCHomeLifeItem extends StatelessWidget {

  /// cell样式类型
  final SCHomeCellBottomContentType cellType;

  final String title = '美好生活就是时尚';

  final List dataList;

  /// 图片宽度
  final double imageWidth = 156.0;
  /// 图片高度
  final double imageHeight = 78.0;
  /// 图片下面内容的高度
  final double bottomContentHeight = 46.0;

  /// cell点击事件
  final Function(int index)? tapAction;

  SCHomeLifeItem({Key? key, required this.cellType, required this.dataList, this.tapAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
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
      child: SizedBox(
        height: 22.0,
        child: SCHomeActivityTopItem(
          iconStyle: IconStyle.left,
          icon: '',
          title: title,
          tagStyle: TagStyle.left,
          tagText: '标签名称',
          tagFont: SCFonts.f10,
          tagHeight: 16.0,
          tagBgColor: SCColors.color_FF6C00,
          tagTextColor: SCColors.color_FFFFFF,
        ),
      ),
    );
  }

  /// 活动列表
  Widget activityListView() {
    return SizedBox(
      height: cellHeight(),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 2.0, bottom: 6),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return activityCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 8.0,
            );
          },
          itemCount: dataList.length),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topItem(index),
          bottomItem(),
        ],
      ),
    );
  }


  Widget topItem(int index) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
      width: imageWidth,
      height: imageHeight,
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
        ],
      ),
    );
  }

  /// 活动-image
  Widget activityImageItem(int index) {
    double imageScale = imageWidth / imageHeight;
    return AspectRatio(
      aspectRatio: imageScale,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.asset(
            dataList[index],
            fit: BoxFit.cover,
          ),
      ),
    );
  }

  /// 活动-title
  Widget activityTitleItem() {
    return Container(
      alignment: Alignment.centerLeft,
      color: SCColors.color_FFFFFF,
      height: 22.0,
      child: const Text('到家服务一应俱全',
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33,
      ),),
    );
  }

  /// 底部的标题、内容
  bottomItem() {
    if (cellType == SCHomeCellBottomContentType.bottomContent){
      return SizedBox(
          width: imageWidth,
          height: bottomContentHeight,
          child: SCHomeActivityBottomContent(
            title: '标题名称名称水果一首歌谷是',
            content: '标题内容内容内容是你房号交话费',
          )
      );
    } else {
      return Container();
    }
  }

  /// cell高度
  double cellHeight() {
    if (cellType == SCHomeCellBottomContentType.bottomContent) {
      return imageHeight + bottomContentHeight + 8;
    } else {
      return imageHeight + 8;
    }
  }

}
