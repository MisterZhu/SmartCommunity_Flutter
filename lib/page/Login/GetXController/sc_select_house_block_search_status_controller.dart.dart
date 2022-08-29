import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_block_search_status_controller.dart.dart
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 14:23
/// Description: 苑层级搜索状态controller
class SCSelectHouseBlockSearchStatusController extends GetxController {

  /// 苑层级 - 搜索是否显示取消
  bool isShowCancel = false;


  /// 刷新搜索状态
  updateSearchStatus({bool isShowCancel = false}){
    this.isShowCancel = isShowCancel;
    update();
  }


}
