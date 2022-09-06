import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_fonts.dart';

/// 我的-切换房号cell

class SCMineChangeAddressItem extends StatelessWidget {

  Function? onTap;

  SCMineChangeAddressItem({Key? key, this.onTap}) : super(key: key);

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
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: houseItem()),
            SizedBox(width: 30.0,),
            changeItem(),
          ],
        ),
      ),),
    );
  }

  /// 房号item
  Widget houseItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('李某某的家庭', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33,
        ),),
        SizedBox(height: 6.0,),
        Text('慧享生活馆1幢-1单元-201慧享生活馆1幢-1单元-201慧享生活馆1幢-1单元-201慧享生活馆1幢-1单元-201慧享生活馆1幢-1单元-201慧享生活馆1幢-1单元-201', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: TextStyle(
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
       Text('切换房屋', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: TextStyle(
         fontSize: SCFonts.f12,
         fontWeight: FontWeight.w400,
         color: SCColors.color_5E5F66,
       ),),
       SizedBox(width: 4.0,),
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