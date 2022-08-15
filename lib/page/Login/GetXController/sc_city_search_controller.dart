

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SCCitySearchController extends GetxController {

  /// 是否显示取消按钮
  bool isShowCancel = false;


  @override
  onInit() {
    super.onInit();
  }


  /// 是否正在搜索
  updateSearchStatus({bool status = false}) {
    isShowCancel = status;
    update();
  }

}