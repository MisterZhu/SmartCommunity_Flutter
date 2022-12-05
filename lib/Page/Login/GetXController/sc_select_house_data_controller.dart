import 'dart:developer';
import 'dart:math';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Login/Model/SelectHouse/sc_select_house_block_model.dart';
import 'package:smartcommunity/Utils/Loading/sc_loading_utils.dart';
import 'package:smartcommunity/Utils/Toast/sc_toast.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_block_controller
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/19 17:38
/// Description: 选择房号
class SCSelectHouseDataController extends GetxController {
  /// 导航栏数据
  List<ScSelectHouseModel> navigatorList = [];

  /// 列表数据
  List<ScSelectHouseModel> dataList = [];

  /// 搜索结果
  List<ScSelectHouseModel> searchResultList = [];

  String pageName = '';

  String tag = '';

  @override
  onInit() {
    super.onInit();
    getCurrentTag();
  }

  /// 导航栏数据
  updateNavigatorList({required List<ScSelectHouseModel> list}) {
    navigatorList = list;
    update();
  }

  /// 刷新数据
  updateDataList({required List<ScSelectHouseModel> list}) {
    dataList = list;
    update();
  }

  /// 刷新数据
  updateSearchList({required List<ScSelectHouseModel> list}) {
    searchResultList = list;
    update();
  }

  /// 加载数据
  loadHouseInfo({required String communityId, String? currentId, Function? callback}) {
    var params;
    if (currentId == null || currentId == '') {
      params = {'communityId': communityId};
    } else {
      params = {'communityId': communityId, 'currentId': currentId};
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kGetSpaceNodesUrl,
        params: params,
        success: (value) {
          List<ScSelectHouseModel> dataList = List<ScSelectHouseModel>.from(
              value.map((e) => ScSelectHouseModel.fromJson(e)).toList());
          print("SCSelectHouseDataController中获取数据--> $dataList");
          updateDataList(list: dataList == null ? [] : dataList);

          if(callback != null) {
            callback.call();
          }
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
          updateDataList(list: []);
        });
  }

}
