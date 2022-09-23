
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/sc_asset.dart';
import '../../../constants/sc_colors.dart';
import '../../../network/sc_config.dart';
import '../GetXController/sc_service_controller.dart';
import '../Model/sc_service_module_model.dart';

/// 单个appitem

class SCServiceAppItem extends StatelessWidget {

  final bool isRegularApp;

  final int section;

  final Applets applets;

  /// 按钮点击事件
  final Function(String title)? appTapAction;

  const SCServiceAppItem({
    Key? key,
    required this.isRegularApp,
    required this.section,
    required this.applets,
    this.appTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    SCServiceController state = Get.find<SCServiceController>();
    bool? hide = true;
    if (isRegularApp) {
      /// 如果是常用应用
      hide = state.isEditing ? false : true;
    } else {
      if (state.isEditing) {
        List<Applets>? regularApplets = state.regularModuleModel.applets;
        hide = regularApplets?.any((element) => applets.id == element.id);
      }
    }
    return GestureDetector(
      onTap: (){
        if (!hide!) {
          if (section == 0) {
            log('常用应用删除');
            state.deleteRegularApp(applets);
          } else {
            log('应用添加');
            state.addRegularApp(applets);
          }
        }
        if (!state.isEditing) {
          if (appTapAction != null) {
            appTapAction?.call(applets.name ?? '');
          }
        }
      },
      child: Container(
        color: SCColors.color_FFFFFF,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            topIconItem(applets, hide!),
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