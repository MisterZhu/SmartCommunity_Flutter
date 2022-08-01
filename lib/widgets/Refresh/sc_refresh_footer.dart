import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:smartcommunity/constants/sc_colors.dart';

///EasyRefresh 自定义 footer
class SCRefreshFooter extends ClassicalFooter {
  /// Key
  final Key? key;

  /// 方位
  final AlignmentGeometry? alignment;

  /// 提示加载文字
  final String loadText;

  /// 准备加载文字
  final String loadReadyText;

  /// 正在加载文字
  final String loadingText;

  /// 加载完成文字
  final String loadedText;

  /// 加载失败文字
  final String loadFailedText;

  /// 没有更多文字
  final String noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showInfo;

  /// 更多信息
  final String infoText;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  /// 更多信息文字颜色
  final Color infoColor;

  SCRefreshFooter({
    extent = 60.0,
    triggerDistance = 70.0,
    float = false,
    completeDuration = const Duration(seconds: 1),
    enableInfiniteLoad = true,
    enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.loadText = "上拉加载",
    this.loadReadyText = "释放加载",
    this.loadingText = "加载中...",
    this.loadedText = "加载完成",
    this.loadFailedText = "加载失败",
    this.noMoreText = "没有更多",
    this.showInfo = true,
    this.infoText = "更新时间 %T",
    this.bgColor = Colors.transparent,
    this.textColor = SCColors.easyRefreshTextColor,
    this.infoColor = SCColors.easyRefreshTextColor,
  }) : super(
          extent: extent,
          triggerDistance: triggerDistance,
          float: float,
          completeDuration: completeDuration,
          enableInfiniteLoad: enableInfiniteLoad,
          enableHapticFeedback: enableHapticFeedback,
        );
}
