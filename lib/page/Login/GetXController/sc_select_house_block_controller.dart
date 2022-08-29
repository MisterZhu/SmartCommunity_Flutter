import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Model/SelectHouse/demo_sc_house_block_model.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_block_controller
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/19 17:38
/// Description: 选择房号 - 苑
class SCSelectHouseBlockController extends GetxController {

  /// 苑级别的list
  List<DemoSCHouseBlockModel> houseCommunityList = [];
  /// 苑层级 - 搜索结果
  List<DemoSCHouseBlockModel> searchResultList = [];

  /// 刷新数据 - 选择房号 苑级别
  updateHouseCommunityList({required List<DemoSCHouseBlockModel> list}){
    houseCommunityList = list;
    update();
  }

  /// 刷新数据 - 选择房号 苑级别
  updateSearchList({required List<DemoSCHouseBlockModel> list}){
    searchResultList = list;
    update();
  }
}