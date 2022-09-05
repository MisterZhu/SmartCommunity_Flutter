import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/sc_select_house_block_model.dart';

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
}
