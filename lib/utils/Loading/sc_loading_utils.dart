import 'package:flutter_easyloading/flutter_easyloading.dart';

/// 加载显示工具类

class SCLoadingUtils {

  /// 显示加载框
  static show({String? text}) {
    if (text == null) {
      EasyLoading.show();
    } else {
      EasyLoading.show(status: text);
    }
  }

  /// 隐藏加载框
  static hide() {
    EasyLoading.dismiss(animation: true);
  }

  /// 成功提示
  static success({String? text}) {
    EasyLoading.showSuccess(text ?? '');
  }

  /// 失败提示
  static failure({String? text}) {
    EasyLoading.showError(text ?? '');
  }

  /// 信息提示
  static info({String? text}) {
    EasyLoading.showInfo(text ?? '');
  }

  /// 初始化loading配置
  static initLoading() {
    EasyLoading.instance.toastPosition = EasyLoadingToastPosition.center;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.dark;
    EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
    EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.opacity;
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.circle;
  }
}