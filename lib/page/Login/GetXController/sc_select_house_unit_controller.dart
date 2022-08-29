import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_building_model.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_unit_model.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_building_controller
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/22 15:26
/// Description: 选择房号 - 单元
class SCSelectHouseUnitController extends GetxController {


  /// 单元级别的list
  List<DemoSCHouseUnitModel> houseCommunityList = [];
  /// 单元级别 - 搜索结果
  List<DemoSCHouseUnitModel> searchResultList = [];

  /// 刷新数据 - 选择房号 单元级别
  updateHouseUnitList({required List<DemoSCHouseUnitModel> list}){
    houseCommunityList = list;
    update();
  }

  /// 刷新数据 - 选择房号 单元级别
  updateSearchList({required List<DemoSCHouseUnitModel> list}){
    searchResultList = list;
    update();
  }
}