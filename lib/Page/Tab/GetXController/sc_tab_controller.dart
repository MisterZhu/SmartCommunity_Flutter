

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Constants/sc_asset.dart';
import '../../../Network/sc_config.dart';
import '../../../Skin/Model/sc_home_visitor_decoration_model.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Skin/Tools/sc_skin_config.dart';
import '../../../Utils/sc_utils.dart';
import '../../Find/Page/sc_find_page.dart';
import '../../Home/GetXController/sc_home_controller1.dart';
import '../../Home/Page/sc_home_page.dart';
import '../../Mine/Page/sc_mine_page.dart';
import '../../Service/Page/sc_service_page.dart';


/// tab controller

class SCTabController extends GetxController {

  List<Widget> pageList = [
    SCHomePage(),
    // SCServicePage(),
    // SCFindPage(),
    SCMinePage()
  ];

  List<BottomNavigationBarItem> tabbarItems = [
    BottomNavigationBarItem(
      icon: Image.asset(SCAsset.iconNormalHome),
      activeIcon: Image.asset(SCAsset.iconSelectedHome),
      label: '首页',
    ),
    // BottomNavigationBarItem(
    //   icon: Image.asset(SCAsset.iconNormalService),
    //   activeIcon: Image.asset(SCAsset.iconSelectedService),
    //   label: '服务',
    // ),
    // BottomNavigationBarItem(
    //   icon: Image.asset(SCAsset.iconNormalFind),
    //   activeIcon: Image.asset(SCAsset.iconSelectedFind),
    //   label: '发现',
    // ),
    BottomNavigationBarItem(
      icon: Image.asset(SCAsset.iconNormalMine),
      activeIcon: Image.asset(SCAsset.iconSelectedMine),
      label: '我的',
    )
  ];

  @override
  onInit() {
    super.onInit();
    getVisitorDecorationData();
  }

  /// 获取装修数据
  getVisitorDecorationData() {
    SCHomeController1 homeState1 = Get.find<SCHomeController1>();
    SCSkinConfig.getVisitorDecorationData(successHandler: (){
      updateTabBarItems();
      homeState1.updateHomeDecorationData();

    });
  }

  /// 更新tabBarItems
  updateTabBarItems() {
    // if (SCScaffoldManager.instance.isLogin) {
    //
    // } else {
    SCHomeVisitorDecorationModel visitorDecorationModel = SCScaffoldManager.instance.visitorDecorationModel;
    List<NavigationList>? tabList = visitorDecorationModel.overallDecoration?.bottomNavigation?.navigationList;
    if (tabList != null) {
      pageList = [];
      tabbarItems = [];
      for (NavigationList tab in tabList) {
        if (tab.title == '首页') {
          pageList.add(SCHomePage());
          String normalIcon = SCAsset.iconNormalHome;
          if (tab.iconInfo?.unchecked != null) {
            normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
          }
          String selectIcon = SCAsset.iconSelectedHome;
          if (tab.iconInfo?.checked != null) {
            selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
          }
          tabbarItems.add(BottomNavigationBarItem(
            icon: SCUtils.imageWidget(url: normalIcon),
            activeIcon: SCUtils.imageWidget(url: selectIcon),
            label: '首页',
          ));
        } else if (tab.title == '服务') {
          pageList.add(SCServicePage());
          String normalIcon = SCAsset.iconNormalService;
          if (tab.iconInfo?.unchecked != null) {
            normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
          }
          String selectIcon = SCAsset.iconSelectedService;
          if (tab.iconInfo?.checked != null) {
            selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
          }
          tabbarItems.add(BottomNavigationBarItem(
            icon: SCUtils.imageWidget(url: normalIcon),
            activeIcon: SCUtils.imageWidget(url: selectIcon),
            label: '服务',
          ));
        } else if (tab.title == '发现') {
          pageList.add(SCFindPage());
          String normalIcon = SCAsset.iconNormalFind;
          if (tab.iconInfo?.unchecked != null) {
            normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
          }
          String selectIcon = SCAsset.iconSelectedFind;
          if (tab.iconInfo?.checked != null) {
            selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
          }
          tabbarItems.add(BottomNavigationBarItem(
            icon: SCUtils.imageWidget(url: normalIcon),
            activeIcon: SCUtils.imageWidget(url: selectIcon),
            label: '发现',
          ));
        } else if (tab.title == '我的') {
          pageList.add(SCMinePage());
          String normalIcon = SCAsset.iconNormalMine;
          if (tab.iconInfo?.unchecked != null) {
            normalIcon = SCConfig.getImageUrl(tab.iconInfo?.unchecked ?? '');
          }
          String selectIcon = SCAsset.iconSelectedMine;
          if (tab.iconInfo?.checked != null) {
            selectIcon = SCConfig.getImageUrl(tab.iconInfo?.checked ?? '');
          }
          tabbarItems.add(BottomNavigationBarItem(
            icon: SCUtils.imageWidget(url: normalIcon),
            activeIcon: SCUtils.imageWidget(url: selectIcon),
            label: '我的',
          ));
        }
      }
      //  }
    }
    update();
  }
}