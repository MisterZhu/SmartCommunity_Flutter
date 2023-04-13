import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/sc_utils.dart';
import '../Controller/sc_my_coupon_controller.dart';
import '../Controller/sc_receive_coupon_controller.dart';
import '../View/sc_coupon_alert.dart';
import '../View/sc_coupon_top_item.dart';
import '../View/sc_coupon_view.dart';

/// 优惠券page

class SCMyCouponPage extends StatefulWidget {
  @override
  SCMyCouponPageState createState() => SCMyCouponPageState();
}

class SCMyCouponPageState extends State<SCMyCouponPage> with SingleTickerProviderStateMixin {

  /// SCMyCouponController
  late SCMyCouponController controller;

  /// SCMessageController - tag
  String controllerTag = '';

  late TabController tabController;

  /// RefreshController
  RefreshController refreshController1 = RefreshController(initialRefresh: false);

  /// RefreshController
  RefreshController refreshController2 = RefreshController(initialRefresh: false);

  /// RefreshController
  RefreshController refreshController3 = RefreshController(initialRefresh: false);

  List tabList = ['未使用', '已使用', '已失效',];

  SCReceiveCouponController receiveCouponController = SCReceiveCouponController();

  @override
  initState() {
    super.initState();
    tabController = TabController(length: tabList.length, vsync: this);
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCMyCouponPage).toString());
    controller = Get.put(SCMyCouponController(), tag: controllerTag);
    controller.loadMyCouponData();
    controller.loadUsedCouponData();
    controller.loadExpiredCouponData();

  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMyCouponPage).toString(), controllerTag);
    controller.dispose();
    refreshController1.dispose();
    refreshController2.dispose();
    refreshController3.dispose();
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

  Widget testItem() {
    return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        minSize: 60.0,
        child: const Text(
          '领券',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_4285F4,
          ),
        ),
        onPressed: () {
          showCouponAlert();
        });
  }

  /// 显示领取优惠券弹窗
  showCouponAlert() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCCouponAlert(controller: receiveCouponController));
    });
  }
  /// body
  Widget body() {
    return GetBuilder<SCMyCouponController>(
      tag: controllerTag,
      init: controller,
      builder: (state) {
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
                      /// status，0未使用，1已使用，2已失效，3获取按钮，4已领取
                      SCCouponView(state: controller, status: 0, refreshController: refreshController1,),
                      SCCouponView(state: controller, status: 1, refreshController: refreshController2,),
                      SCCouponView(state: controller, status: 2, refreshController: refreshController3,),
                    ])
                ),
              ],
            )
        );
      },
    );
  }
}

