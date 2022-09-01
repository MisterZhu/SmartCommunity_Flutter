import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

/// 首页-应用列表item

class SCHomeAllItem extends StatelessWidget {

  SCHomeAllItem({Key? key, required this.itemList}) : super(key: key);

  final List itemList;

  /// 列
  final int crossAxisCount = 5;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(
      color: SCColors.color_F5F5F5,
    ), child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        itemCount: itemList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return gridItem(context, index);
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(1);
        }),);
  }

  /// item
  Widget gridItem(BuildContext context, int index) {
    double scale = MediaQuery.of(context).size.width / 375.0;
    /// icon宽度
    double icon_size = 40.0 * scale;
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(itemList[index], width: icon_size, height: icon_size,),
          const SizedBox(
            height: 4.0,
          ),
          const SizedBox(
            height: 18.0,
            width: double.infinity,
            child: Text('业主维码', textAlign: TextAlign.center,overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.normal,
              color: SCColors.color_5E5F66
            ),),
          )
        ],
      ),
    );
  }
}