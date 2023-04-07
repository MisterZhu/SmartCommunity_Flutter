import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Controller/sc_message_controller.dart';
import '../View/sc_message_listview.dart';

/// 消息page

class SCMessagePage extends StatefulWidget {
  @override
  SCMessagePageState createState() => SCMessagePageState();
}

class SCMessagePageState extends State<SCMessagePage> {

  /// SCMessageController
  late SCMessageController controller;

  /// SCMessageController - tag
  String controllerTag = '';

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCMessagePage).toString());
    controller = Get.put(SCMessageController(), tag: controllerTag);
    controller.loadData(isMore: false);
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMessagePage).toString(), controllerTag);
    controller.dispose();
    refreshController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "消息",
        centerTitle: true,
        navBackgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCMessageController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCMessageListView(state: state, refreshController: refreshController,);
          }),
    );
  }
}

