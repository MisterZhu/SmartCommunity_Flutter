/// 首页皮肤2-GetxController
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/constants/sc_skin_value.dart';
import 'package:smartcommunity/page/Home/Model/sc_home_news_model.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

import '../../../constants/sc_type_define.dart';
// import 'package:image_cropper/image_cropper.dart';

class SCHomeController2 extends GetxController {

  /// 背景图片scale
  double topNavBGImageScale = 782.0 / 384.0;
  /// 背景图片高度
  double topNavBGImageHeight = 168.0 - (SCUtils().getTopSafeArea() > 20 ? 0.0 : 30.0);

  /// 导航栏不透明度
  double opacity = 1.0;

  /// 导航栏默认offset
  double navigationOffset = 64.0;

  /// 导航栏背景颜色,默认白色
  Color navigationBackgroundColor = SCColors.color_FE8947;
  /// 导航栏状态，是否置顶
  bool navigationSticky = false;
  /// 导航栏置顶颜色,默认白色
  Color navigationStickyColor = Colors.white;
  /// 未置顶颜色,默认白色
  Color navigationNormalColor = Colors.white;

  /// 项目名称
  String communityName = "请登录";

  /// 所有应用
  List allItemsList = [];

  /// listView数据
  List listViewData = [];

  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    allItemsList = [
      SCAsset.iconItem1,
      SCAsset.iconItem2,
      SCAsset.iconItem3,
      SCAsset.iconItem4,
      SCAsset.iconItem5,
      SCAsset.iconItem6,
      SCAsset.iconItem7,
      SCAsset.iconItem8,
      SCAsset.iconItem9,
      SCAsset.iconItem10
    ];
    listViewData =  [
      /// banner
      {'type': SCTypeDefine.SC_HOME_TYPE_BANNER, 'data': []},

      /// 应用列表
      {'type': SCTypeDefine.SC_HOME_TYPE_ALLITEMS, 'data': []},

      /// 图片
      {'type': SCTypeDefine.SC_HOME_TYPE_COMMUNITY, 'data': []},

      /// 热门活动
      {'type': SCTypeDefine.SC_HOME_TYPE_LIFE, 'data': []},

      /// 精选商品
      {'type': SCTypeDefine.SC_HOME_TYPE_GOODS, 'data': []},
    ];
    // navigationOffset = 44.0 + SCUtils().getTopSafeArea();
    navigationOffset = topNavBGImageHeight;
  }

  /// 修改导航栏透状态
  void changeNavigationState({double offset = 0.0}) {
    if (offset > navigationOffset) {
      opacity = 0.0;
      navigationSticky = true;
    } else {
      opacity = 1.0;
      navigationSticky = false;
    }

    update();
  }

  /// 重置数据
  void resetAllData() {
    opacity = 1.0;
    navigationOffset = 64.0;
    navigationBackgroundColor = SCColors.color_FE8947;
    navigationSticky = false;
    navigationStickyColor = Colors.white;
    navigationNormalColor = Colors.white;
    update();
  }

  /// 修改项目名称
  changeCommunityName({required String name}) {
    if (name.isEmpty) {
      communityName = "请登录";
    } else {
      communityName = name;
    }
    update();
  }

  @override
  onClose() {
    super.onClose();
    refreshController.dispose();
  }

}