import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_building_model.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_building_controller
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/22 15:26
/// Description: 选择房号 - 幢
class SCSelectHouseBuildingController extends GetxController {


  /// 幢级别的list
  List<DemoSCHouseBuildingModel> houseCommunityList = [];
  /// 幢级别 - 搜索结果
  List<DemoSCHouseBuildingModel> searchResultList = [];

  /// 刷新数据 - 选择房号 幢级别
  updateHouseBuildingList({required List<DemoSCHouseBuildingModel> list}){
    houseCommunityList = list;
    update();
  }

  /// 刷新数据 - 选择房号 幢级别
  updateSearchList({required List<DemoSCHouseBuildingModel> list}){
    searchResultList = list;
    update();
  }
}