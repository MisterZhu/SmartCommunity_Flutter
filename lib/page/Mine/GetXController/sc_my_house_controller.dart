
import 'dart:developer';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../skin/Tools/sc_scaffold_manager.dart';
import '../../../utils/Loading/sc_loading_utils.dart';
import '../../../utils/Toast/sc_toast.dart';
import '../Model/sc_my_house_model.dart';

class SCMyHouseController extends GetxController {

  /// 我的房号列表
  List<SCMyHouseModel> dataList = [];

  String? housingId = SCScaffoldManager.instance.user.housingId;

  /// 更新当前的房号id
  updateCurrentHousingId(String? id) {
    housingId = id;
    update();
  }

  /// 更新我的房号列表数据
  updateHouseList({required List<SCMyHouseModel> list}) {
    dataList = list;
    update();
  }

  /// 加载数据
  loadMyHouseData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMyHouseUrl,
        success: (value) {
          dataList = List<SCMyHouseModel>.from(value.map((e) => SCMyHouseModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
        });
  }

}