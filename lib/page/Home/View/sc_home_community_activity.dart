import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_bottom_content.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_bottom_tag.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_image_tag.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_top_item.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 首页-园区活动cell，最多3个，图片大小107*102

class SCHomeCommunityActivity extends StatelessWidget {

  final String title = '园区活动';

  /// cell样式类型，1=图片下面没有标题，2=图片下面有标题内容
  final int cellType;

  final List activityList;

  /// cell点击事件
  final Function(int index)? tapAction;

  /// 图片的宽度
  final double imageWidth;

  /// 图片的高度
  final double imageHeight;

  /// 图片宽度
  double cellWidth = (SCUtils().getScreenWidth() - 56.0) / 3.0;

  SCHomeCommunityActivity({Key? key,
    this.imageWidth = 107.0,
    this.imageHeight = 102.0,
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
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 2.0, bottom: 0.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        crossAxisCount: activityList.length > 3 ? 3 : activityList.length,
        shrinkWrap: true,
        itemCount: activityList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return activityCell(index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
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
    return SizedBox(
      width: cellWidth,
      height: cellHeight(),
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
    double imageScale = imageWidth / imageHeight;
    return AspectRatio(
      aspectRatio: imageScale,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.asset(
            activityList[index],
            fit: BoxFit.cover,
          )
      ),
    );
  }

  /// 底部的标题、内容
  bottomItem() {
    if (cellType == 1) {
      return Container();
    } else if (cellType == 2){
      return SCHomeActivityBottomContent(
        title: '标题名称名称',
        content: '标题内容内容内容',
      );
    } else {
      return Container();
    }
  }

  cellHeight() {
    double imageScale = imageWidth / imageHeight;
    return cellWidth / imageScale;
  }

}
