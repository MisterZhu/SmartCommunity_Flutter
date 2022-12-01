import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/sc_colors.dart';
import '../../../Utils/sc_utils.dart';

/// 第一套皮肤的导航栏

class SCHomeNav1Controller extends GetxController {
  /// 导航栏不透明度
  double opacity = 1.0;

  /// 导航栏默认高度
  double navigationHeight = 140.0;

  /// 导航栏背景颜色,默认白色
  Color navigationBackgroundColor = SCColors.color_FE8947;
  /// 导航栏状态，是否置顶
  bool navigationSticky = false;
  /// 导航栏置顶颜色,默认黑色
  Color navigationStickyColor = Colors.white;
  /// 未置顶颜色,默认白色
  Color navigationNormalColor = Colors.white;

  /// 项目名称
  String communityName = "请登录";

  /// 房号文本数字数量
  int titleMaxLength = 10;

  @override
  void onInit() {
    super.onInit();
    navigationHeight = 138.0 + SCUtils().getTopSafeArea();
  }

  /// 隐藏导航栏
  void hiddenNav({required bool isHidden}) {
    opacity = isHidden == true ? 0 : 1.0;
    update();
  }

  /// 修改导航栏透状态
  void changeNavigationState({double offset = 0.0}) {
    if (offset < 0.0) {
      opacity = 0;
    } else {
      opacity = 1.0;
    }

    if (offset > navigationHeight) {
      navigationSticky = true;
    }else {
      navigationSticky = false;
    }
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

  /// 修改导航栏高度
  changeNavigationHeight({required double height}) {
    navigationHeight = height;
    update();
  }
}