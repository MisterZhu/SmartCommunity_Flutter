

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../Constants/sc_colors.dart';
import '../../../Constants/sc_enum.dart';
import '../../../Constants/sc_fonts.dart';

/// 首页-网格图片item，4等分，宽高1：1，1行

class SCHomeGridImageItem extends StatelessWidget {

  /// cell样式类型
  final SCHomeCellBottomContentType cellType;

  /// 图片list，最多4个
  final List imageList;

  /// 图片点击回调
  Function(int index)? onTap;

  /// 图片宽度
  final double imageWidth;

  /// 图片高度
  final double imageHeight;

  SCHomeGridImageItem(
      {Key? key,
        this.imageWidth = 160.0,
        this.imageHeight = 160.0,
        this.cellType = SCHomeCellBottomContentType.noBottomContent,
        required this.imageList,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 8.0,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: imageList.length > 4 ? 4 : imageList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return gridCell(url: imageList[index], index: index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// cell
  Widget gridCell({required String url, required int index}) {
    return GestureDetector(
      onTap: () {
        onTap?.call(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gridItem(url: imageList[index], index: index),
          bottomItem(),
        ],
      ),
    );
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

  /// 底部的标题、内容
  bottomItem() {
    if (cellType == SCHomeCellBottomContentType.bottomContent){
      return const Padding(
        padding: EdgeInsets.only(top: 4.0, left: 4.0, bottom: 0.0),
        child: Text(
          '标题标题',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
        ),
      );
    } else {
      return Container();
    }
  }

}