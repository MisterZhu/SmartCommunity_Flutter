import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Model/demo_sc_house_community_model.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_controller.dart
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/17 14:23
/// Description: 选择房号Controller
class SCSelectHouseController extends GetxController {

  /// 苑级别的list
  List<DemoSCHouseCommunityModel> houseCommunityList = [];
  /// 苑层级 - 搜索是否显示取消
  bool isShowCancel = false;
  /// 苑层级 - 搜索结果
  List<DemoSCHouseCommunityModel> searchResultList = [];

  /// 刷新数据 - 选择房号 苑级别
  updateHouseCommunityList(List<DemoSCHouseCommunityModel> list){
    houseCommunityList = list;
    update();
  }

  /// 刷新搜索状态
  updateSearchStatus({bool isShowCancel = false}){
    this.isShowCancel = isShowCancel;
    update();
  }

  /// 刷新数据 - 选择房号 苑级别
  updateSearchList(List<DemoSCHouseCommunityModel> list){
    searchResultList = list;
    update();
  }
}
