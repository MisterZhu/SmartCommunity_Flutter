
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Service/View/sc_service_app_item.dart';
import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../GetXController/sc_service_controller.dart';
import '../Model/sc_service_module_model.dart';

/// 单个模块应用cell
class SCServiceCellItem extends StatelessWidget {

  final int section;

  final SCServiceModuleModel moduleModel;

  /// 按钮点击事件
  final Function(String title)? tapAction;

  SCServiceCellItem(
      {
        Key? key,
        this.section = 0,
        required this.moduleModel,
        this.tapAction,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GetBuilder<SCServiceController>(builder: (state) {
      double leftSpace = 16.0;
      double radius = 4.0;
      if (state.skinStyle == 1) {
        leftSpace = 4.0;
        radius = 0.0;
      }
      bool showItems = true;
      /// 是否是常用应用，暂定id=0为常用应用，后面根据接口返回的数据再定
      bool isRegularApp = moduleModel.module?.id == '0' ? true : false;
      if (isRegularApp && !state.isExpansion) {
        showItems = false;
      }
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: leftSpace),
            child: Container(
              decoration: BoxDecoration(
                  color: SCColors.color_FFFFFF,
                  borderRadius: BorderRadius.circular(radius)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  headerItem(),
                  Offstage(
                    offstage: !showItems,
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

  /// header
  Widget headerItem() {
    return Container(
      padding: const EdgeInsets.only(left: 12.0, right: 10.0, top: 12.0, bottom: 12.0),
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
          headerLeftContainer(),
          headerRightContainer(),
        ],
      ),
    );
  }

  /// header-left
  Widget headerLeftContainer() {
    return Expanded(
      child: Text(
        moduleModel.module?.name ?? '',
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33,
        ),
    ));
  }

  /// header-right
  Widget headerRightContainer() {
    return GetBuilder<SCServiceController>(builder: (state){
      return Offstage(
        offstage: moduleModel.module?.id == '0' ? false : true, /// 如果是常用应用显示右边的编辑
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

  /// cell
  Widget itemsCell() {
    List<Applets>?list = [];
    /// 是否是常用应用，暂定id=0为常用应用，后面根据接口返回的数据再定
    bool isRegularApp = moduleModel.module?.id == '0' ? true : false;
    return GetBuilder<SCServiceController>(builder: (state){
      if (isRegularApp) {
        list = state.regularModuleModel.applets;
      } else {
        list = moduleModel.applets;
      }
      return StaggeredGridView.countBuilder(
          padding: const EdgeInsets.only(left: 5.5, right: 5.5, top: 3.0, bottom: 2.0),
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          crossAxisCount: 5,
          shrinkWrap: true,
          itemCount: list?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Applets applets = list![index];
            return SCServiceAppItem(
              isRegularApp: isRegularApp,
              section: section,
              applets: applets,
              appTapAction: (title) {
                if (tapAction != null) {
                  tapAction?.call(title);
                }
              },
            );
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          });
    });
  }

}