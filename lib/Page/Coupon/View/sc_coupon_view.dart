import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Coupon/View/sc_coupon_alert.dart';
import 'package:smartcommunity/Page/Coupon/View/sc_coupon_cell.dart';
import 'package:smartcommunity/Page/Coupon/View/sc_coupon_use_rules_alert.dart';
import '../../../Constants/sc_asset.dart';
import '../../../Utils/sc_utils.dart';
import '../Controller/sc_coupon_controller.dart';


/// 优惠券listview
class SCCouponView extends StatelessWidget {

  /// SCCouponController
  final SCCouponController state;

  final int status;

  SCCouponView({Key? key, required this.state, required this.status}) : super(key: key);

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: state.dataList.isNotEmpty ? listView() : emptyView()
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return SCCouponCell(
            status: status,
            name: '店铺优惠券',
            validity: '有效期至2022-05-05 12:00',
            money: '30',
            condition: '满200可用',
            getAction: () {
              showCouponAlert();
            },
            ruleAction: () {
              showUseRulesAlert();
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5);
  }

  /// emptyView
  Widget emptyView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 124.0,
        ),
        Image.asset(SCAsset.iconCouponEmpty, width: 144.0, height: 144.0,),
        const SizedBox(
          height: 2.0,
        ),
        const Text("暂无优惠券", style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99
        ),)
      ],
    );
  }

  /// 显示优惠券弹窗
  showCouponAlert() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCCouponAlert(
            getAction: (index) {

            },
          ));
    });
  }

  /// 显示使用规则弹窗
  showUseRulesAlert() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCCouponUseRulesAlert(
            content: '1、满200.00减15.00\n2、限酒店商城应用内使用\n3、限相关商品分类使用\n4、限手机号152 6768 8989使用\n5、有效期至2023-12-12 23:00:00有效',
            closeAction: () {
              Navigator.of(context).pop();
            },
          ));
    });
  }

  /// 下拉刷新
  Future onRefresh() async {
    state.loadData(
        isMore: false,
        completeHandler: (bool success, bool last) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    state.loadData(
        isMore: true,
        completeHandler: (bool success, bool last) {
          if (last) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        });
  }
}