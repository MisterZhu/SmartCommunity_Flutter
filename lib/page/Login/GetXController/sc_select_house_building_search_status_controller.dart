import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_building_search_status_controller
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/22 15:58
/// Description: 幢层级搜索状态controller
class SCSelectHouseBuildingSearchStatusController extends GetxController {

  /// 苑层级 - 搜索是否显示取消
  bool isShowCancel = false;


  /// 刷新搜索状态
  updateSearchStatus({bool isShowCancel = false}){
    this.isShowCancel = isShowCancel;
    update();
  }


}