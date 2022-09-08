

import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../network/sc_http_manager.dart';
import '../../../network/sc_url.dart';
import '../../../utils/Loading/sc_loading_utils.dart';
import '../../../utils/Toast/sc_toast.dart';
import '../Model/sc_my_house_model.dart';

class SCMyHouseController extends GetxController {

  /// 我的房号列表
  List<SCMyHouseModel> dataList = [];


  /// 更新我的房号列表数据源
  updateHouseList({required List<SCMyHouseModel> list}) {
    dataList = list;
    update();
  }


  loadData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMyHouseUrl,
        success: (value) {
          log('我的房号列表===$value');
          dataList = List<SCMyHouseModel>.from(value.map((e) => SCMyHouseModel.fromJson(e)).toList());
          updateHouseList(list: dataList);
        },
        failure: (value) {
          String message = value['message'];
          SCToast.showTip(message);
        });
  }


}