import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

/// 首页-应用列表item

class SCHomeAllItem extends StatelessWidget {
  SCHomeAllItem({Key? key, required this.itemList, required this.bgColor, this.onTap,})
      : super(key: key);
  final List itemList;

  /// 列
  final int crossAxisCount = 5;

  Color bgColor = SCColors.color_F5F5F5;
  /// 点击回调
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 10.0, bottom: 2.0),
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            itemCount: itemList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return gridItem(context, index);
            },
            staggeredTileBuilder: (int index) {
              return StaggeredTile.fit(1);
            }),
      ),
    );
  }

  /// item
  Widget gridItem(BuildContext context, int index) {
    double scale = MediaQuery.of(context).size.width / 375.0;

    /// icon宽度
    double icon_size = 40.0 * scale;
    return GestureDetector(
      onTap: () {
        itemTap(index: index);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              itemList[index],
              width: icon_size,
              height: icon_size,
            ),
            const SizedBox(
              height: 4.0,
            ),
            const SizedBox(
              height: 18.0,
              width: double.infinity,
              child: Text(
                '业主维码',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.normal,
                    color: SCColors.color_5E5F66),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 应用点击
  itemTap({required int index}) {
    if (onTap != null) {
      onTap?.call(index);
    }
  }
}
