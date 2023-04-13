import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Coupon/View/sc_coupon_alert.dart';
import 'package:smartcommunity/Page/Coupon/View/sc_coupon_cell.dart';
import 'package:smartcommunity/Page/Coupon/View/sc_coupon_use_rules_alert.dart';
import '../../../Constants/sc_asset.dart';
import '../../../Utils/sc_utils.dart';
import '../Controller/sc_my_coupon_controller.dart';
import '../Model/sc_coupon_model.dart';


/// 优惠券listview
class SCCouponView extends StatelessWidget {

  /// SCMyCouponController
  final SCMyCouponController state;

  final int status;

  /// RefreshController
  final RefreshController refreshController;

  SCCouponView({Key? key, required this.state, required this.status, required this.refreshController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SCCouponModel> list = [];
    /// status，0未使用，1已使用，2已失效，3获取按钮，4已领取
    if (status == 0) {
      list = state.myCouponList;
    } else if (status == 1) {
      list = state.usedCouponList;
    } else if (status == 2) {
      list = state.expiredCouponList;
    }
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: list.isNotEmpty ? listView(list) : emptyView()
    );
  }

  /// listView
  Widget listView(List<SCCouponModel> list) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          /// model.state状态：0-未使用/1-已预扣/2-已使用/3-已过期/4-已作废
          SCCouponModel model = list[index];
          String time = formatDate(DateTime.parse(model.gmtExpire ?? ''), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
          return SCCouponCell(
            status: status,
            name: model.title,
            validity: '有效期至$time',
            money: '${model.deductAmount}',
            condition: model.subTitle,
            ruleAction: () {
              showUseRulesAlert(model.instructions ?? '');
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: list.length);
  }

  /// emptyView
  Widget emptyView() {
    if (state.loadCompleted == true) {
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
    } else {
      return const SizedBox();
    }
  }

  /// 显示使用规则弹窗
  showUseRulesAlert(String value) {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCCouponUseRulesAlert(
            content: value,
            closeAction: () {
              Navigator.of(context).pop();
            },
          ));
    });
  }

  /// 下拉刷新
  Future onRefresh() async {
    /// status，0未使用，1已使用，2已失效，3获取按钮，4已领取
    if (status == 0) {
      state.loadMyCouponData(
          isMore: false,
          completeHandler: (bool success, bool last) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    } else if (status == 1) {
      state.loadUsedCouponData(
          isMore: false,
          completeHandler: (bool success, bool last) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    } else if (status == 2) {
      state.loadExpiredCouponData(
          isMore: false,
          completeHandler: (bool success, bool last) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    }
  }

  /// 上拉加载
  void loadMore() async {
    /// status，0未使用，1已使用，2已失效，3获取按钮，4已领取
    if (status == 0) {
      state.loadMyCouponData(
          isMore: true,
          completeHandler: (bool success, bool last) {
            if (last) {
              refreshController.loadNoData();
            } else {
              refreshController.loadComplete();
            }
          });
    } else if (status == 1) {
      state.loadUsedCouponData(
          isMore: true,
          completeHandler: (bool success, bool last) {
            if (last) {
              refreshController.loadNoData();
            } else {
              refreshController.loadComplete();
            }
          });
    } else if (status == 2) {
      state.loadExpiredCouponData(
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
}