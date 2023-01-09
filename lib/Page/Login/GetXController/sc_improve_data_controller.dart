
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';

/// 完善资料controller

class SCImproveDataController extends GetxController {

  bool showInputNameAlert = false;

  String? name;

  String? birthday;

  String? gender;

  /// 更新是否显示输入姓名弹窗
  updateInputNameAlertStatus() {
    showInputNameAlert = !showInputNameAlert;
    update();
  }

  /// 更新姓名
  updateName(String str) {
    name = str;
    update();
  }

  /// 更新生日
  updateBirthday(String str) {
    birthday = str;
    update();
  }

  /// 更新性别
  updateGender(String str) {
    gender = str;
    update();
  }

  postData() {
    SCRouterHelper.pathOffAllPage(SCRouterPath.tabPath, null);

  }

}