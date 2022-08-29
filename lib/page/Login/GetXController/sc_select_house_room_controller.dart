import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_building_model.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_room_model.dart';
import 'package:smartcommunity/page/Login/Model/SelectHouse/demo_sc_house_unit_model.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_building_controller
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/22 15:26
/// Description: 选择房号 - 房号
class SCSelectHouseRoomController extends GetxController {


  /// 房号级别的list
  List<DemoSCHouseRoomModel> houseCommunityList = [];
  /// 房号级别 - 搜索结果
  List<DemoSCHouseRoomModel> searchResultList = [];

  /// 刷新数据 - 选择房号 房号级别
  updateRoomList({required List<DemoSCHouseRoomModel> list}){
    houseCommunityList = list;
    update();
  }

  /// 刷新数据 - 选择房号 房号级别
  updateSearchList({required List<DemoSCHouseRoomModel> list}){
    searchResultList = list;
    update();
  }
}