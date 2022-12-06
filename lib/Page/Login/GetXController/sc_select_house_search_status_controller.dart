import 'dart:developer';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_search_status_controller.dart
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 14:23
/// Description: 搜索状态controller
class SCSelectHouseSearchStatusController extends GetxController {

  /// 搜索是否显示取消
  bool isShowCancel = false;

  String pageName = '';

  String tag = '';

  @override
  onInit() {
    super.onInit();
    getCurrentTag();
  }

  /// 刷新搜索状态
  updateSearchStatus({bool isShowCancel = false}) {
    this.isShowCancel = isShowCancel;
    update();
  }

}
