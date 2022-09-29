import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartcommunity/page/Home/View/sc_home_activity_top_item.dart';

import '../../../constants/sc_colors.dart';
import '../../../constants/sc_fonts.dart';

/// 首页-网格图片，2等分，多行

class SCHomeGridImageGroup extends StatelessWidget {

  final String title;

  /// 图片list
  final List imageList;

  /// 图片点击回调
  Function(int index)? onTap;

  /// 图片宽度
  final double imageWidth;

  /// 图片高度
  final double imageHeight;

  SCHomeGridImageGroup({Key? key,
    this.imageWidth = 324.0,
    this.imageHeight = 120.0,
    required this.title,
    required this.imageList,
    this.onTap}) : super(key: key);

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
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            titleItem(),
            gridView(),
          ],
        ),
      ),
    );
  }

  /// title
  Widget titleItem() {
    if (title == '') {
      return const SizedBox(height: 8.0,);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
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
      );
    }
  }

  Widget gridView() {
    int crossAxisCount = 1;
    if (imageList.length <= 1) {
      crossAxisCount = 1;
    } else {
      crossAxisCount = 2;
    }
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 0.0, bottom: 0.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        itemCount: imageList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return gridItem(url: imageList[index], index: index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// 网格item
  Widget gridItem({required String url, required int index}) {
    double imageScale = imageWidth / imageHeight;
    return AspectRatio(
      aspectRatio: imageScale,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: GestureDetector(
            onTap: () {
              onTap?.call(index);
            },
            child: Image.asset(
              url,
              fit: BoxFit.cover,
            ),
          )
      ),
    );
  }
}