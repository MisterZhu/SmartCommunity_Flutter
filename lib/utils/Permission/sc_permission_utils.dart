import 'package:flutter/material.dart';
import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/constants/sc_key.dart';
import 'package:smartcommunity/sc_app.dart';
import 'package:smartcommunity/utils/sc_sp_utils.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import 'package:smartcommunity/widgets/Dialog/sc_base_dialog.dart';
import 'package:smartcommunity/widgets/Dialog/sc_dialog_utils.dart';

import '../../constants/sc_colors.dart';
import '../Router/sc_router_helper.dart';
import '../Router/sc_router_path.dart';

/// 权限管理工具

class SCPermissionUtils {
  /// 使用扫一扫
  static scanCode({Function? completionHandler}) async{
    Future.delayed(const Duration(seconds: 0), () async {
      SCUtils.getCurrentContext(completionHandler: (context) async {
        bool isShowAlert = SCSpUtil.getBool(SCKey.kIsShowScanCodeAlert);
        if (!isShowAlert) {
          SCDialogUtils.instance.showMiddleDialog(
            context: context,
            title: "温馨提示",
            content: SCDefaultValue.scanAlertMessage,
            customWidgetButtons: [
              defaultCustomButton(context,
                  text: '取消',
                  textColor: SCColors.color_1B1C33,
                  fontWeight: FontWeight.w400),
              defaultCustomButton(context,
                  text: '确定',
                  textColor: SCColors.color_1B1C33,
                  fontWeight: FontWeight.w400,
                  onTap: () async {
                    SCSpUtil.setBool(SCKey.kIsShowScanCodeAlert, true);
                    var result = await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
                    completionHandler?.call(result);
                  }),
            ],
          );
        } else {
          var result = await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
          completionHandler?.call(result);
        }
      });
    });
  }
}
