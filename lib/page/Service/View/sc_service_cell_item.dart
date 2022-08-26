
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../GetXController/sc_service_controller.dart';

class SCServiceCellItem extends StatelessWidget {

  final int index;
  /// 头部标题
  final String? headerTitle;
  /// 是否显示编辑按钮
  final bool isShowEditBtn;

  SCServiceCellItem(
      {
        Key? key,
        this.index = 0,
        this.headerTitle = '',
        this.isShowEditBtn = true,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GetBuilder<SCServiceController>(builder: (state) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: SCColors.color_FFFFFF,
                  borderRadius: BorderRadius.circular(4.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  headerItem(1),
                  Offstage(
                    offstage: index == 0 ? !state.isExpansion : false,
                    child: itemsCell(1),
                  ),
                ],
              ),
            ),
          )
        ],
      );

    });
  }


  /*header*/
  Widget headerItem(int index) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 12, bottom: 12),
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(
            headerTitle ?? '',
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33,
            ),
          ),),
          headerRightContainer(),
        ],
      ),
    );
  }


  /*header-left*/
  Widget headerRightContainer() {
    SCServiceController state = Get.find<SCServiceController>();
    return GetBuilder<SCServiceController>(builder: (state){
      return Offstage(
        offstage: !isShowEditBtn,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              color: SCColors.color_FFFFFF,
              child: Text(
                state.isEditing ? '完成' : '编辑',
                maxLines: 1,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                  color: SCColors.color_FF6C00,
                ),),
              onPressed: (){
                state.updateEditStatus();
              },
            ),
            const SizedBox(width: 4.0,),
            GestureDetector(
                onTap: (){
                  log('首页应用收起展开=======${state.isExpansion}');
                  state.updateExpansionStatus();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: SCColors.color_FFFFFF,
                  child: Image.asset(state.isExpansion ? SCAsset.iconEditAppUpArrow : SCAsset.iconEditAppDownArrow, width: 16.0, height: 16.0,),
                )
            )
          ],
        ),
      );
    });
  }


  /*cell*/
  Widget itemsCell(int index) {
     int count = 10;
     double mainAxisSpacing = count > 5 ? 10 : 0;
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 2.0, bottom: 12),
        mainAxisSpacing: 8,
        crossAxisSpacing: 10,
        crossAxisCount: 5,
        shrinkWrap: true,
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return gridItem(count);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  Widget gridItem(int index) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        color: SCColors.color_FFFFFF,
        child: Column(
          children: [
            Image.asset(
              SCAsset.iconServiceQrCode,
              width: 36,
              height: 36,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '小区缴费',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: SCColors.color_5E5F66),
            )
          ],
        ),
      ),
    );
  }


}