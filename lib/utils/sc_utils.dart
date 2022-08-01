import 'dart:ui';

import 'package:flutter/material.dart';

/// 工具类

class SCUtils {

  /*获取状态栏高度*/
  double getStatusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  /*获取屏幕宽度*/
  double getScreenWidth() {
    return MediaQueryData.fromWindow(window).size.width;
  }

  /*获取屏幕高度*/
  double getScreenHeight() {
    return MediaQueryData.fromWindow(window).size.height;
  }

  /*获取屏幕底部安全距离*/
  double getBottomSafeArea() {
    return MediaQueryData.fromWindow(window).padding.bottom;
  }

}