

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../constants/sc_asset.dart';
import '../Model/sc_service_model.dart';

class SCServiceController extends GetxController {

  /// 首页应用是否展开，默认展开
  bool isExpansion = true;

  /// 是否正在编辑，默认不编辑
  bool isEditing = false;

  /// 首页app数量
  int homeAppCount = 5;

  /// 搜索的数据源
  List<SCServiceModel> appList = [];



  @override
  onInit() {
    super.onInit();
    var testList = [
      {'id': '0', 'name': '业主二维码', 'icon': SCAsset.iconServiceQrCode, 'added': false},
      {'id': '1', 'name': '公务用车', 'icon': SCAsset.iconServiceCar, 'added': false},
      {'id': '2', 'name': '积分管理', 'icon': SCAsset.iconServiceIntegral, 'added': false},
      {'id': '3', 'name': '报事报修', 'icon': SCAsset.iconServiceReport, 'added': false},
      {'id': '4', 'name': '小区缴费', 'icon': SCAsset.iconServicePay, 'added': false},
      {'id': '5', 'name': '家庭理财', 'icon': SCAsset.iconServiceFinance, 'added': false},
      {'id': '6', 'name': '社区社群', 'icon': SCAsset.iconServiceCommunity, 'added': false},
      {'id': '7', 'name': '工单调度', 'icon': SCAsset.iconServiceSchedule, 'added': false},
      {'id': '8', 'name': '权益优惠', 'icon': SCAsset.iconServiceDiscount, 'added': false},
      {'id': '9', 'name': '周边楼盘', 'icon': SCAsset.iconServiceSurrounding, 'added': false},
    ];

    appList = testList.map((e) => SCServiceModel.fromJson(e)).toList();
  }

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

  deleteHomeApp(String id) {
    homeAppCount--;
    update();
  }

  addHomeApp(String id) {
    homeAppCount++;
    update();
  }

}