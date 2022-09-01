import 'dart:math';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Mine/View/ToggleHouses/sc_mine_house_tag_item.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_colors.dart';
import '../../../../constants/sc_fonts.dart';
import '../../Model/sc_current_house_info_model.dart';

/// 当前房屋-房屋信息cell
class SCCurrentHouseInfoItem extends StatelessWidget {
  List nameList = ['房号', '房屋类型', '户主', '本人身份', '租期'];

  SCCurrentHouseInfoModel infoModel;

  SCCurrentHouseInfoItem({Key? key, required this.infoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0),
          image: const DecorationImage(
              fit: BoxFit.fill, image: AssetImage(SCAsset.iconMineHouseBg))),
      child: contentItem(),
    );
  }

  Widget contentItem() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF.withOpacity(0.7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '房屋信息',
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w500,
                  color: SCColors.color_1B1D33),
            ),
            contentListView(),
          ],
        ),
      ),
    );
  }

  Widget contentListView() {
    List valueList = [
      infoModel.houseNumber,
      infoModel.houseType == 0 ? '' : '',
      infoModel.owner,
      infoModel.identity == 1 ? '业主' : '租户', /// 测试数据
      infoModel.endDate
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(top: 20, left: 0, right: 0, bottom: 8),
            itemBuilder: (BuildContext context, int index) {
              String name = nameList[index];
              int? type = 0;
              String content = valueList[index];
              if (name == '房屋类型') {
                type = infoModel.houseType as int?;
                content = '住宅';

                ///  测试数据
              }
              return contentCellItem(type!, name, content);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: infoModel.identity == 1 ? 4 : 5)
      ],
    );
  }

  Widget contentCellItem(int type, String name, String content) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          textAlign: TextAlign.left,
          maxLines: 1,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66),
        ),
        rightItem(type, content),
      ],
    );
  }

  Widget rightItem(int type, String content) {
    if (type == 0) {
      return Text(
        content,
        textAlign: TextAlign.right,
        maxLines: 1,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66),
      );
    } else {
      /// type:房屋类型-----暂定------1=住宅，2=企业，3=学校
      Color bgColor;
      Color textColor;
      if (type == 1) {
        bgColor = SCColors.color_FFF0D5;
        textColor = SCColors.color_FEA500;
      } else if (type == 2) {
        bgColor = SCColors.color_E3FFF1;
        textColor = SCColors.color_00C365;
      } else {
        bgColor = SCColors.color_F2F3F5;
        textColor = SCColors.color_8D8E99;
      }
      return SCMineHouseTagItem(
          name: content, bgColor: bgColor, textColor: textColor);
    }
  }
}
