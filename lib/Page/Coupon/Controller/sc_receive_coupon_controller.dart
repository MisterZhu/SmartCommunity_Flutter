
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../Model/sc_coupon_model.dart';

/// 领取优惠券controller

class SCReceiveCouponController extends GetxController {

  int pageNum = 1;

  /// 可领取的优惠券
  List<SCCouponModel> receiveCouponList = [];


  @override
  onInit() {
    super.onInit();
    loadReceiveCouponData(isMore: false);
  }

  /// 可领的优惠券列表
  loadReceiveCouponData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "category": 0,
        "suitApplication": "",
        "suitClient": "",
        "suitScope": 0,
        "suitStore": 0,
        "voucherId": ""
      },
      "count": true,
      "last": true,
      "orderBy": [
        {
          "asc": true,
          "field": ""
        }
      ],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kReceiveCouponListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          List list = value['records'];
          if (isLoadMore == true) {
            receiveCouponList.addAll(List<SCCouponModel>.from(
                list.map((e) => SCCouponModel.fromJson(e)).toList()));
          } else {
            receiveCouponList = List<SCCouponModel>.from(
                list.map((e) => SCCouponModel.fromJson(e)).toList());
          }
          update();
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          if (isLoadMore) {
            pageNum--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }


  /// 领取优惠券
  receiveCoupon({required String voucherId, Function(bool success)? completeHandler}) {
    SCLoadingUtils.show();
    var params = {
      "suitApplication": "HotelMall",
      // "suitClient": "113308944543001",
      // "suitScope": 140,
      // "suitStore": 13069500599622,
      "voucherId": voucherId
    };
    SCHttpManager.instance.post(
        url: SCUrl.kReceiveCouponUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
          completeHandler?.call(false);
        });
  }

}

