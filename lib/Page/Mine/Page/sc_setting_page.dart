import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/Constants/sc_colors.dart';
import 'package:smartcommunity/Page/Mine/View/Setting/sc_setting_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../Constants/sc_fonts.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Widgets/Dialog/sc_base_dialog.dart';
import '../../../Widgets/Dialog/sc_dialog_utils.dart';
import '../GetXController/sc_setting_controller.dart';

/// 设置page

class SCSettingPage extends StatefulWidget {
  @override
  SCSettingState createState() => SCSettingState();
}

class SCSettingState extends State<SCSettingPage> {

  SCSettingController state = Get.put(SCSettingController());

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: "设置", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F5F5F5,
      child: SCSettingListView(logoff: () {
        showLogoffConfirmDialog();
      },),
    );
  }

  showLogoffConfirmDialog() {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      title: '申请注销账户',
      content: '正在请求注销钱包账户，注销后将无法使用',
      isNeedCloseDiaLog: true,
      customWidgetButtons: [
        defaultCustomButton(
            context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        TextButton(
            onPressed: () {
                Navigator.of(context).pop();
                /// 跳转到注销账户页面
                SCRouterHelper.pathPage(SCRouterPath.applyLogoffPath, null);
            },
            child: const Text(
                '确认注销',
                style: TextStyle(
                    color: SCColors.color_FF6C00,
                    fontSize: SCFonts.f16)))
      ],
    );
  }

}