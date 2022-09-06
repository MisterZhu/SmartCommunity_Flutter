import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 首页-园区活动cell

class SCHomeCommunityActivity extends StatelessWidget {
  final String title = '园区活动';

  final List activityList;

  /// 图片宽度
  final double imageWidth = (SCUtils().getScreenWidth() - 56.0) / 3.0;

  SCHomeCommunityActivity({Key? key, required this.activityList})
      : super(key: key);

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
      child: SizedBox(
        height: titleHeight(),
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
      height: cellHeight() + 8,
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
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
      width: imageWidth,
      height: cellHeight(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          activityImageItem(index),
          Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0),
                    Color.fromRGBO(0, 0, 0, 0.6),
                  ],
                ),
              ),
              height: 30.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Text(
              '',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: SCColors.color_FFFFFF,
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 活动-image
  Widget activityImageItem(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.0),
      child: Image.asset(
        activityList[index],
        fit: BoxFit.cover,
      ),
    );
  }

  /// 标题文本高度
  double titleHeight() {
    return 22;
  }

  /// cell高度
  double cellHeight() {
    return imageWidth * 102.0 / 107.0;
  }
}
