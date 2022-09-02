

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';
/// 我的房号cell
class SCMyRoomNumberItem extends StatelessWidget {

  List roomList = [];

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: leftItem()),
          const SizedBox(width: 20.0,),
          rightItem()
      ],
    )
    );
  }

  Widget leftItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleItem(),
        const SizedBox(
          height: 2,
        ),
        Text(
          '樱花苑-11幢-1单元-101室樱花苑-11幢',
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66),
        ),
      ],
    );
  }

  Widget titleItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '慧享科技',
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
        ),
        const SizedBox(width: 8.0,),
        Image.asset(SCAsset.iconMineHouseVerify, width: 46.0, height: 18.0,),
      ],
    );
  }

  /// 右边的切换按钮
  Widget rightItem() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: 54,
        height: 32,
        color: SCColors.color_FFFFFF,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(SCAsset.iconMineHouseToggle, width: 14.0, height: 14.0,),
            const SizedBox(width: 8.0,),
            const Text(
              '切换',
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: SCColors.color_FF6C00,
              ),),
          ],
        ),
      ),
      onPressed: () {
        /// 切换
      },
    );
  }
}