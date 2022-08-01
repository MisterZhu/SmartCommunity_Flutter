import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 首页-网格图片item

class SCHomeGridImageItem extends StatelessWidget {

  /// 图片list,最多三张图片
  final List imageList;

  /// 图片点击回调
  Function(int index)? onTap;

  /// 图片宽度
  final double imageWidth;

  /// 图片高度
  final double imageHeight;

  SCHomeGridImageItem(
      {Key? key, this.imageWidth = 686.0, this.imageHeight = 148.0, required this.imageList, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    int crossAxisCount = 1;
    if (imageList.length <= 1) {
      crossAxisCount = 1;
    } else {
      crossAxisCount = 2;
    }
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
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
          borderRadius: BorderRadius.circular(6.0),
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