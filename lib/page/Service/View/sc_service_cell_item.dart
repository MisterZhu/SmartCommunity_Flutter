
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../GetXController/sc_service_controller.dart';
import '../Model/sc_service_model.dart';

class SCServiceCellItem extends StatelessWidget {

  final int section;
  /// 头部标题
  final String? headerTitle;
  /// 是否显示编辑按钮
  final bool isShowEditBtn;

  final List<SCServiceModel>? list;

  SCServiceCellItem(
      {
        Key? key,
        this.section = 0,
        this.headerTitle = '',
        this.isShowEditBtn = true,
        this.list,
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
                    offstage: section == 0 ? !state.isExpansion : false,
                    child: itemsCell(),
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
        mainAxisSize: MainAxisSize.min,
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
  Widget itemsCell() {
    SCServiceController state = Get.find<SCServiceController>();
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 5.5, right: 5.5, top: 3.0, bottom: 2.0),
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        crossAxisCount: 5,
        shrinkWrap: true,
        itemCount: section == 0 ? state.homeAppList.length : list?.length ?? 0,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          SCServiceModel model;
          if (section == 0) {
            model = state.homeAppList![index];
          } else {
            model = list![index];
          }
          return gridItem(model);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  Widget gridItem(SCServiceModel model) {
    SCServiceController state = Get.find<SCServiceController>();
    bool hide = true;
    if (section == 0) {
      hide = state.isEditing ? false : true;
    } else {
      if (state.isEditing) {
        hide = state.homeAppList.any((element) => model.id == element.id);
      }
    }
    return GestureDetector(
      onTap: (){
        if (!hide) {
          if (section == 0) {
            log('首页应用删除');
            state.deleteHomeApp(model);
          } else {
            log('应用添加');
            state.addHomeApp(model);
          }
        }
      },
      child: Container(
        color: SCColors.color_FFFFFF,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            topIconItem(model, hide),
            const SizedBox(
              height: 4,
            ),
            Text(
              model.name ?? '',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: SCColors.color_5E5F66),
            )
          ],
        ),
      ),
    );
  }

  Widget topIconItem(SCServiceModel model, bool hide) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 42,
          height: 42,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Image.asset(
              model.icon ?? '',
              width: 36,
              height: 36,
          )),
        addOrDeleteIconItem(model, hide),
      ],
    );
  }

  Widget addOrDeleteIconItem(SCServiceModel model, bool hide) {
    return Offstage(
      /// offstage = true（隐藏）
      offstage: hide,
      child: Container(
        width: 16,
        height: 16,
        color: Colors.transparent,
        child: Image.asset(section == 0 ? SCAsset.iconEditAppDelete : SCAsset.iconEditAppAdd, width: 16.0, height: 16.0,),
      ),
    );
  }


}