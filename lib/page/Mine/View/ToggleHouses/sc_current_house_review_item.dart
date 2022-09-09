import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/page/Mine/Model/Sc_current_house_info_data_model.dart';
import 'package:smartcommunity/page/Mine/View/ToggleHouses/sc_mine_house_tag_item.dart';
import 'package:smartcommunity/utils/Toast/sc_toast.dart';
import 'package:smartcommunity/widgets/Dialog/sc_base_dialog.dart';
import 'package:smartcommunity/widgets/Dialog/sc_bottom_sheet_model.dart';
import 'package:smartcommunity/widgets/Dialog/sc_dialog_utils.dart';

import '../../../../constants/sc_asset.dart';
import '../../../../constants/sc_fonts.dart';
import '../../GetXController/sc_current_house_controller.dart';
import '../../Model/sc_current_house_review_model.dart';

/// 当前房屋-审核列表cell

class SCCurrentHouseReviewItem extends StatelessWidget {
  SCCurrentHouseReviewItem({Key? key, required this.reviewList})
      : super(key: key);

  final List<AdoptMembers>? reviewList;

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
        contentWidget(),
      ],
    );
  }

  /// 已审核/未审核 按钮
  Widget topBtnItem() {
    return GetBuilder<SCCurrentHouseController>(builder: (state) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                state.updateSelectIndex(0);
                log('点击了已审核');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                child: Text(
                  '已审核',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: state.selectReviewIndex == 0
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: state.selectReviewIndex == 0
                          ? SCColors.color_1B1D33
                          : SCColors.color_5E5E66),
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            GestureDetector(
              onTap: () {
                state.updateSelectIndex(1);
                log('点击了未审核');
              },
              child: Text(
                '未审核',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: state.selectReviewIndex == 1
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: state.selectReviewIndex == 1
                        ? SCColors.color_1B1D33
                        : SCColors.color_5E5E66),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget contentWidget() {
    if (reviewList == null || reviewList?.length == 0) {
      return emptyView();
    } else {
      return listView();
    }
  }

  Widget listView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
            itemBuilder: (BuildContext context, int index) {
              AdoptMembers model = reviewList![index];
              return GestureDetector(
                child: cellItem(model),
                onTap: () {
                  // 未审核用户
                  SCCurrentHouseController state =
                      Get.find<SCCurrentHouseController>();
                  int index = state.selectReviewIndex;
                  if (index == 1) {
                    showBottomDialog(context);
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 0.5,
                color: SCColors.color_EDEDF0,
              );
            },
            itemCount: reviewList?.length ?? 0),
      ],
    );
  }

  /// 暂无数据布局
  Widget emptyView() {
    return Container(
      height: 400,
      child: Center(
        child: Text('暂无数据'),
      ),
    );
  }

  /// cell
  Widget cellItem(AdoptMembers model) {
    SCCurrentHouseController state = Get.find<SCCurrentHouseController>();
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 14, bottom: 14, right: 28),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: leftItem(model)),
              const SizedBox(
                width: 20.0,
              ),
              Offstage(
                offstage: state.selectReviewIndex == 0 ? true : false,
                child: Image.asset(
                  SCAsset.iconMineHouseReviewArrow,
                  width: 16.0,
                  height: 16.0,
                ),
              )
            ]),
      ),
    );
  }

  Widget leftItem(AdoptMembers model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        topItem(model),
        SizedBox(
          height: model.identityId == '3' ? 11.0 : 0.0,
        ),
        Offstage(
          // 只有租客才显示租期结束时间
          offstage: model.identityId == '3' ? false : true,
          child: Container(
            color: SCColors.color_FFFFFF,
            child: Text(
              '租期结束时间：${model.gmtLiveEnd ?? ''}',
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

  Widget topItem(AdoptMembers model) {
    String? typeString = model.identity;
    Color bgColor;
    Color textColor;

    /// identityId :人员类型  1 -- 房东  2 -- 代理人  3 -- 租客  4 -- 业主  5 -- 家属
    String? identityId = model.identityId;
    if (identityId == "1") {
      // 房东
      bgColor = SCColors.color_D7F4F8;
      textColor = SCColors.color_07ACC2;
    } else if (identityId == "2") {
      // 代理人
      bgColor = SCColors.color_FFECDF;
      textColor = SCColors.color_F06D0F;
    } else if (identityId == "3") {
      // 租客
      bgColor = SCColors.color_E3FFF1;
      textColor = SCColors.color_00C365;
    } else if (identityId == "4") {
      // 业主
      bgColor = SCColors.color_E7F1FF;
      textColor = SCColors.color_1677FF;
    } else if (identityId == "5") {
      // 家属
      bgColor = SCColors.color_FFEBEC;
      textColor = SCColors.color_FF1D32;
    } else {
      bgColor = SCColors.color_F2F3F5;
      textColor = SCColors.color_8D8E99;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SCMineHouseTagItem(
            name: typeString!, bgColor: bgColor, textColor: textColor),
        const SizedBox(
          width: 10,
        ),
        Text(
          model.name ?? '',
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5E66),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          '(${model.phone ?? ''})',
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99),
        ),
      ],
    );
  }

  showBottomDialog(BuildContext context) {
    List<SCBottomSheetModel> dataList = [];
    SCBottomSheetModel scBottomSheetModel1 = SCBottomSheetModel(
        title: '通过',
        color: SCColors.color_1B1C33,
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w400);
    SCBottomSheetModel scBottomSheetModel2 = SCBottomSheetModel(
        title: '拒绝',
        color: SCColors.color_1B1C33,
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w400);
    SCBottomSheetModel scBottomSheetModel3 = SCBottomSheetModel(
        title: '修改租期',
        color: SCColors.color_1B1C33,
        fontSize: SCFonts.f16,
        fontWeight: FontWeight.w400);
    dataList.add(scBottomSheetModel1);
    dataList.add(scBottomSheetModel2);
    dataList.add(scBottomSheetModel3);

    SCDialogUtils.instance.showBottomDialog(
      context: context,
      dataList: dataList,
      isShowCancel: true,
      onTap: (index, context) {
        if (index == 0 || index == 1) {
          showConfirmDialog(context, index);
        } else if (index == 2) {
          SCToast.showTip('功能正在开发中……');
        }
      },
    );
  }

  /// 确认弹窗
  showConfirmDialog(BuildContext context, int index) {
    print('${index == 0 ? '审核通过' : '拒绝'}');
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      title: index == 0 ? '审核通过' : '拒绝',
      content: index == 0 ? '确认通过该申请？' : '确认拒绝该申请？',
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        TextButton(
            onPressed: () {
              if (index == 0) {
                SCToast.showTip('通过');
              } else {
                SCToast.showTip('拒绝');
              }
            },
            child: Text('确定',
                style: TextStyle(
                    color: SCColors.color_FF6C00, fontSize: SCFonts.f16)))
      ],
    );
  }

  /// 审核通过
  confirmPass() {
    SCCurrentHouseController state = Get.find<SCCurrentHouseController>();
    state.confirmPass();
  }

  /// 审核拒绝
  confirmReject() {
    SCCurrentHouseController state = Get.find<SCCurrentHouseController>();
    state.confirmReject();
  }
}
