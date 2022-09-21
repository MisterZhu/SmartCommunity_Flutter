
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/page/Service/View/sc_service_app_item.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../../../network/sc_config.dart';
import '../GetXController/sc_service_controller.dart';
import '../Model/sc_service_module_model.dart';

/// 全部应用cell
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
        leftSpace = 0.0;
        radius = 0.0;
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
          Expanded(child: Text(
            moduleModel.module?.name ?? '',
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

  /// header-Right
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
      if (section == 0) {
        list = state.regularAppList;
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

  Widget gridItem(Applets applets) {
    SCServiceController state = Get.find<SCServiceController>();
    bool hide = true;
    if (moduleModel.module?.id == '0') {
      /// 如果是常用应用
      hide = state.isEditing ? false : true;
    } else {
      if (state.isEditing) {
        hide = state.regularAppList.any((element) => applets.id == element.id);
      }
    }
    return GestureDetector(
      onTap: (){
        if (!hide) {
          if (section == 0) {
            log('常用应用删除');
            state.deleteRegularApp(applets);
          } else {
            log('应用添加');
            state.addRegularApp(applets);
          }
        }
        if (!state.isEditing) {
          if (tapAction != null) {
            tapAction?.call(applets.name ?? '');
          }
        }
      },
      child: Container(
        color: SCColors.color_FFFFFF,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            topIconItem(applets, hide),
            const SizedBox(
              height: 4,
            ),
            Text(
              applets.name ?? '',
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

  Widget topIconItem(Applets model, bool hide) {
    String url = SCConfig.getImageUrl(model.icon?.fileKey ?? '');
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 42,
          height: 42,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Image.asset(
              model.icon?.name ?? '',
              width: 36,
              height: 36,
          )),
        addOrDeleteIconItem(model, hide),
      ],
    );
  }

  /// 右上角的+/-图标
  Widget addOrDeleteIconItem(Applets model, bool hide) {
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