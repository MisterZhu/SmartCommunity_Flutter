
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../Model/sc_coupon_model.dart';

/// 我的优惠券controller

class SCMyCouponController extends GetxController {

  int pageNum1 = 1;

  int pageNum2 = 1;

  int pageNum3 = 1;

  /// 我的优惠券
  List<SCCouponModel> myCouponList = [];

  /// 已使用优惠券
  List<SCCouponModel> usedCouponList = [];


  /// 已失效优惠券
  List<SCCouponModel> expiredCouponList = [];

  /// 数据加载完成
  bool loadCompleted = false;

  @override
  onInit() {
    super.onInit();
  }

  /// 我的优惠券列表
  loadMyCouponData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum1++;
    } else {
      pageNum1 = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {
            "map": {},
            "method": 0,
            "name": "",
            "value": {}
          }
        ],
        "specialMap": {},
        "specialMap2": {
          "additionalProperties1": {
            "map": {},
            "method": 0,
            "name": "",
            "value": {}
          }
        }
      },
      "count": true,
      "last": false,
      "orderBy": [
        {
          "asc": true,
          "field": ""
        }
      ],
      "pageNum": pageNum1,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kMyCouponListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadCompleted = true;
          List list = value['records'];
          if (isLoadMore == true) {
            myCouponList.addAll(List<SCCouponModel>.from(
                list.map((e) => SCCouponModel.fromJson(e)).toList()));
          } else {
            myCouponList = List<SCCouponModel>.from(
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
          loadCompleted = true;
          if (isLoadMore) {
            pageNum1--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 已使用优惠券列表
  loadUsedCouponData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum2++;
    } else {
      pageNum2 = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {
            "map": {},
            "method": 1,
            "name": "vu.state",
            "value": "2"
          },
        ],
        // "specialMap": {},
        // "specialMap2": {
        //   "additionalProperties1": {
        //     "map": {},
        //     "method": 0,
        //     "name": "",
        //     "value": {}
        //   }
        // }
      },
      "count": true,
      "last": false,
      "orderBy": [
        {
          "asc": true,
          "field": ""
        }
      ],
      "pageNum": pageNum2,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kMyCouponListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadCompleted = true;
          List list = value['records'];
          if (isLoadMore == true) {
            usedCouponList.addAll(List<SCCouponModel>.from(
                list.map((e) => SCCouponModel.fromJson(e)).toList()));
          } else {
            usedCouponList = List<SCCouponModel>.from(
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
          loadCompleted = true;
          if (isLoadMore) {
            pageNum2--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 已失效优惠券列表
  loadExpiredCouponData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum3++;
    } else {
      pageNum3 = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {
            "map": {},
            "method": 15,
            "name": "vu.state",
            "value": ["3", "4"]
          },
        ],
        // "specialMap": {},
        // "specialMap2": {
        //   "additionalProperties1": {
        //     "map": {},
        //     "method": 0,
        //     "name": "",
        //     "value": {}
        //   }
        // }
      },
      "count": true,
      "last": false,
      "orderBy": [
        {
          "asc": true,
          "field": ""
        }
      ],
      "pageNum": pageNum3,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kMyCouponListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadCompleted = true;
          List list = value['records'];
          if (isLoadMore == true) {
            expiredCouponList.addAll(List<SCCouponModel>.from(
                list.map((e) => SCCouponModel.fromJson(e)).toList()));
          } else {
            expiredCouponList = List<SCCouponModel>.from(
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
          loadCompleted = true;
          if (isLoadMore) {
            pageNum3--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

}
