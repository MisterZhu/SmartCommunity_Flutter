import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_asset.dart';

/// 我的-GetXController

class SCMineController extends GetxController {
  /// 导航栏不透明度
  double opacity = 0.0;
  /// 导航栏背景颜色,默认白色
  Color navigationBackgroundColor = Colors.white;
  /// 导航栏状态，是否置顶
  bool navigationSticky = false;
  /// 导航栏组件颜色,默认黑色
  Color itemColor = SCColors.color_1B1D33;

  /// 我的资产-资产类型-选中index，默认0
  int propertyCurrentIndex = 0;

  /// 用户头像
  String headPicUrl = SCAsset.iconMineUserHead;

  /// 修改导航栏透状态
  void changeNavigationState({double offset = 0.0}) {
    double navigationOffset = MediaQueryData.fromWindow(window).padding.top + 44.0;
    if (offset > navigationOffset) {
      navigationSticky = true;
      opacity = 1.0;
    }else {
      navigationSticky = false;
      opacity = 0.0;
    }
    update();
  }

  /// 改变选中的资产类型index
  void changePropertyIndex({int index = 0}) {
    propertyCurrentIndex = index;
    update();
  }

  /// 更换用户头像
  changeUserHeadPic({required String url}) {
    headPicUrl = url;
    update();
  }
}