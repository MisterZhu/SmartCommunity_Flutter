
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// 优惠券controller
class SCCouponController extends GetxController {

  int pageNum = 1;

  int currentIndex = 0;

  List dataList = ['1'];

  /// 数据加载完成
  bool loadCompleted = false;

  @override
  onInit() {
    super.onInit();
    loadData();
  }


  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      //SCLoadingUtils.show();
    }
  }
}
