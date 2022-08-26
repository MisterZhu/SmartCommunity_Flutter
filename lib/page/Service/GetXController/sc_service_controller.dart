

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SCServiceController extends GetxController {

  /// 首页应用是否展开
  bool isExpansion = true;

  /// 是否正在编辑
  bool isEditing = false;


  /// 更新首页应用展开状态
  updateExpansionStatus() {
    isExpansion = !isExpansion;
    update();
  }

  /// 更新编辑状态
  updateEditStatus() {
    isEditing = !isEditing;
    update();
  }

}