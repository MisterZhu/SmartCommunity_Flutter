/// 首页皮肤2-GetxController
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/constants/sc_asset.dart';
import 'package:smartcommunity/constants/sc_colors.dart';
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/constants/sc_skin_value.dart';
import 'package:smartcommunity/page/Home/Model/sc_home_news_model.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
// import 'package:image_cropper/image_cropper.dart';

class SCHomeController2 extends GetxController {

  /// 背景图片scale
  double topNavBGImageScale = 782.0 / 384.0;
  /// 背景图片高度
  double topNavBGImageHeight = 168.0 - (SCUtils().getTopSafeArea() > 20 ? 10.0 : 40.0);

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

  /// 所有应用
  List allItemsList = [];

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
}