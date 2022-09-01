
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Mine/View/ToggleHouses/sc_mine_house_tag_item.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_fonts.dart';
import '../../GetXController/sc_current_house_controller.dart';
import '../../Model/sc_current_house_review_model.dart';

/// 当前房屋-审核列表cell

class SCCurrentHouseReviewItem extends StatelessWidget {

  SCCurrentHouseReviewItem({Key? key, required this.reviewList}) : super(key: key);

  final List<SCCurrentHouseReviewModel>? reviewList;

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 0, top: 8.0, bottom: 0),
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: contentItem(),
    );
  }

  /// body
  Widget contentItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topBtnItem(),
        listView(),
      ],
    );
  }

  Widget topBtnItem() {
    return GetBuilder<SCCurrentHouseController>(builder: (state) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                state.updateSelectIndex(0);
                log('点击了已审核');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                child: Text(
                  '已审核',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: state.selectIndex == 0 ?  FontWeight.w600 : FontWeight.w400,
                      color: state.selectIndex == 0 ? SCColors.color_1B1D33 : SCColors.color_5E5E66),
                ),
              ),
            ),
            const SizedBox(width: 40,),
            GestureDetector(
              onTap: (){
                state.updateSelectIndex(1);
                log('点击了未审核');
              },
              child: Text(
                '未审核',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: state.selectIndex == 1 ?  FontWeight.w600 : FontWeight.w400,
                    color: state.selectIndex == 1 ? SCColors.color_1B1D33 : SCColors.color_5E5E66),
              ),
            ),
          ],
        ),
      );
    });

  }

  Widget listView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
            itemBuilder: (BuildContext context, int index) {
              SCCurrentHouseReviewModel model = reviewList![index];
              return cellItem(model);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 0.5, color: SCColors.color_EDEDF0,);
            },
            itemCount: reviewList?.length ?? 0),
      ],
    );
  }

  Widget cellItem(SCCurrentHouseReviewModel model) {
    SCCurrentHouseController state = Get.find<SCCurrentHouseController>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 14, bottom: 14, right: 28),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: leftItem(model)),
              const SizedBox(width: 20.0,),
              Offstage(
                offstage: state.selectIndex == 0 ? true : false,
                child: Image.asset(SCAsset.iconMineHouseReviewArrow, width: 16.0, height: 16.0,),
              )
            ]
        ),
      ),
    );
  }

  Widget leftItem(SCCurrentHouseReviewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        topItem(model),
        SizedBox(
          height: model.type == 3 ? 11.0 : 0.0,
        ),
        Offstage(
          offstage: model.type == 3 ? false : true,
          child: Container(
            color: SCColors.color_FFFFFF,
            child: Text(
              '租期结束时间：${model.endDate ?? ''}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: SCFonts.f12,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_8D8E99),
            ),
          ),
        ),
      ],
    );
  }

  Widget topItem(SCCurrentHouseReviewModel model) {
    String typeString;
    Color bgColor;
    Color textColor;
    /// type:人员类型-----暂定------1=业主，2=家属，3=租客,4=朋友
    if (model.type == 1) {
      typeString = '业主';
      bgColor = SCColors.color_E7F1FF;
      textColor = SCColors.color_1677FF;
    } else if (model.type == 2) {
      typeString = '家属';
      bgColor = SCColors.color_FFEBEC;
      textColor = SCColors.color_FF1D32;
    } else if (model.type == 3) {
      typeString = '租客';
      bgColor = SCColors.color_E3FFF1;
      textColor = SCColors.color_00C365;
    } else {
      typeString = '朋友';
      bgColor = SCColors.color_F2F3F5;
      textColor = SCColors.color_8D8E99;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SCMineHouseTagItem(name: typeString, bgColor: bgColor, textColor: textColor),
        const SizedBox(width: 10,),
        Text(
          model.name ?? '',
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5E66),
        ),
        const SizedBox(width: 10,),
        Text(
          '(${model.mobile ?? ''})',
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99),
        ),
      ],

    );
  }

}