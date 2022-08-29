import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// Copyright (c), 浙江慧享信息科技有限公司
/// FileName: sc_select_house_controller
/// Author: wang tao
/// Email: wangtao1@lvchengfuwu.com
/// Date: 2022/8/29 9:37
/// Description: 选择房号controller
class SCSelectHouseController extends GetxController {

  late PageController pageController;
  late int pageIndex;

  // 初始化pageController
  initPageController({required PageController pageController, required int pageIndex}){
    this.pageController = pageController;
    this.pageIndex = pageIndex;
    update();
  }

  // 切换tab
  switchTab({required int pageIndex}){
    this.pageIndex = pageIndex;
    pageController.jumpToPage(pageIndex);
    update();
  }
}
