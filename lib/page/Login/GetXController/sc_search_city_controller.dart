

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SCSearchCityController extends GetxController {

  /// 是否显示取消按钮
  bool isShowCancel = false;


  @override
  onInit() {
    super.onInit();
  }


  /// 是否显示取消按钮
  updateCancelButtonStatus({bool status = false}) {
    isShowCancel = status;
    update();
  }

}