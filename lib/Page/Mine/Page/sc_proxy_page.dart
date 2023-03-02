import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_sp_utils.dart';
import '../GetXController/sc_setting_controller.dart';
import '../View/Setting/sc_proxy_view.dart';

/// 抓包设置page

class SCProxyPage extends StatefulWidget {
  @override
  SCProxyPageState createState() => SCProxyPageState();
}

class SCProxyPageState extends State<SCProxyPage> {

  SCSettingController state = Get.put(SCSettingController());

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "抓包设置",
        centerTitle: true,
        navBackgroundColor: SCColors.color_F2F3F5,
        elevation: 0,
        actions: [clearItem()],
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCProxyView(),
    );
  }

  /// 重置
  Widget clearItem() {
    return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        minSize: 60.0,
        child: const Text(
          '重置',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_4285F4,
          ),
        ),
        onPressed: () {
          SCSpUtil.remove(SCKey.kProxyMap);
          SCToast.showTip('重置成功，请重启APP');
          SCRouterHelper.back(null);
        });
  }

}