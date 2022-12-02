import 'package:flutter/material.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Constants/sc_fonts.dart';

import '../../../Utils/Router/sc_router_helper.dart';

/// 我的-切换房号cell

class SCMineChangeAddressItem extends StatelessWidget {

  /// 家庭名称
  final String? houseName;
  /// 具体房号地址
  final String? address;

  Function? onTap;

  SCMineChangeAddressItem({Key? key, this.onTap, this.houseName, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: () {
        changeHouse();
      },
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Container(
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: houseItem()),
            const SizedBox(width: 30.0,),
            changeItem(),
          ],
        ),
      ),),
    );
  }

  /// 房号item
  Widget houseItem() {
    String houseNameString = houseName ?? '';
    String addressString = address ?? '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(houseNameString, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33,
        ),),
        const SizedBox(height: 6.0,),
        Text(addressString, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: const TextStyle(
          fontSize: SCFonts.f12,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33,
        ),),
      ],
    );
  }

  /// 切换item
  Widget changeItem() {
    return Row(
      children: [
        const Text('切换房屋', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: TextStyle(
          fontSize: SCFonts.f12,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66,
        ),),
        const SizedBox(width: 4.0,),
        Image.asset(SCAsset.iconMineDetailGrey, width: 12.0, height: 12.0, fit: BoxFit.cover,),
      ],
    );
  }

  /// 切换房屋
  changeHouse() {
    if (onTap != null) {
      onTap?.call();
    }
  }
}