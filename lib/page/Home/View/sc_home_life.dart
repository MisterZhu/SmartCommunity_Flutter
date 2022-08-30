import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

/// 首页-美好生活cell

class SCHomeLife extends StatelessWidget {
  final String title = '美好生活';

  final List activityList;

  /// 图片大小
  final double imageWidth = 156.0;

  final double imageHeight = 78.0;

  const SCHomeLife({Key? key, required this.activityList}) : super(key: key);

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
        child: Text(
          title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
        ),
      ),
    );
  }

  /// 活动列表
  Widget activityListView() {
    return SizedBox(
      height: 118.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 2.0, bottom: 0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return activityCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 8.0,
            );
          },
          itemCount: activityList.length),
    );
  }

  /// cell
  Widget activityCell(int index) {
    return Container(
      color: SCColors.color_FFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          activityImageItem(index),
          const SizedBox(
            height: 4.0,
          ),
          activityTitleItem(),
          const SizedBox(
            height: 12.0,
          ),
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
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,),
    );
  }

  /// 活动-title
  Widget activityTitleItem() {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 22.0,
      child: const Text('到家服务一应俱全', textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w500,
        color: SCColors.color_1B1D33,
      ),),
    );
  }

}
