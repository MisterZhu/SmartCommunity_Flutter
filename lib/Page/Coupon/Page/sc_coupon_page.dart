import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Controller/sc_coupon_controller.dart';
import '../View/sc_coupon_top_item.dart';
import '../View/sc_coupon_view.dart';

/// 优惠券page

class SCCouponPage extends StatefulWidget {
  @override
  SCCouponPageState createState() => SCCouponPageState();
}

class SCCouponPageState extends State<SCCouponPage> with SingleTickerProviderStateMixin {

  /// SCCouponController
  late SCCouponController controller;

  /// SCMessageController - tag
  String controllerTag = '';

  late TabController tabController;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  List tabList = ['未使用', '已使用', '已失效',];

  @override
  initState() {
    super.initState();
    tabController = TabController(length: tabList.length, vsync: this);
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCCouponPage).toString());
    controller = Get.put(SCCouponController(), tag: controllerTag);
    controller.loadData();
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCCouponPage).toString(), controllerTag);
    controller.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "优惠券",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SCCouponTopItem(tabController: tabController, titleList: tabList, height: 44.0, descAction: () {

            },),
            Expanded(child: TabBarView(
                controller: tabController,
                children: [
                  SCCouponView(state: controller, status: 0, refreshController: refreshController,),
                  SCCouponView(state: controller, status: 1, refreshController: refreshController,),
                  SCCouponView(state: controller, status: 2, refreshController: refreshController,),
                ])
            ),
          ],
        )
    );
  }
}

