

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SCSearchCommunityController extends GetxController {

  /// 是否显示取消按钮
  bool isShowCancel = false;

  /// 输入框node
  FocusNode node = FocusNode();

  @override
  onInit() {
    super.onInit();
  }


  /// 是否显示取消按钮
  updateCancelButtonStatus({bool status = false}) {
    isShowCancel = status;
    update();
  }

  /// 关闭键盘
  hideKeyboard() {
    node.unfocus();
  }

}