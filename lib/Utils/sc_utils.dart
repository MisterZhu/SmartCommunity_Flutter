import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import '../Constants/sc_asset.dart';
import '../sc_app.dart';
import 'package:sc_uikit/sc_uikit.dart';

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

  /*获取屏幕顶部安全距离*/
  double getTopSafeArea() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  /*关闭键盘*/
  hideKeyboard({required BuildContext context}) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /*验证手机号*/
  bool checkPhone({required String phone}) {
    return RegExp(SCDefaultValue.phoneReg).hasMatch(phone);
  }

  /*验证姓名*/
  bool checkName({required String name, bool? isShowTip}) {
    bool showTip = isShowTip ?? false;
    if (name.isEmpty) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputNameTip);
      }
      return false;
    }
    if (name.trim().length < 2) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputNameErrorTip);
      }
      return false;
    }
    return true;
  }

  /*验证身份证*/
  checkIDCard({required String idNumber, bool? isShowTip}) {
    bool showTip = isShowTip ?? false;
    if (idNumber.isEmpty) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputIDCardTip);
      }
      return false;
    }

    RegExp cardReg = RegExp(SCDefaultValue.idCardReg);
    if (!cardReg.hasMatch(idNumber)) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputIDCardErrorTip);
      }
      return false;
    }
    return true;
  }

  /*计算文字宽宽高*/
  static Size boundingTextSize(
      BuildContext context, String text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text == null || text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: Localizations.localeOf(context),
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  /*修改状态栏颜色*/
  changeStatusBarStyle({required SystemUiOverlayStyle style}) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /*获取当前context*/
  static getCurrentContext(
      {Function(BuildContext context)? completionHandler}) {
    Future.delayed(const Duration(seconds: 0), () async {
      BuildContext context = navigatorKey.currentState!.overlay!.context;
      completionHandler?.call(context);
    });
  }

  /*图片展示widget*/
  static Widget imageWidget(
      {required String url, double? width, double? height, BoxFit? fit, Widget? placeholder}) {
    if (url.contains('http')) {
      return CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => placeholder ?? const SizedBox(),
          errorWidget: (context, url, error) => const Icon(Icons.error));
    } else {
      return Image.asset(
        url.isEmpty ? SCAsset.iconMineUserDefault : url,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  /*获取性别num*/
  static int getGenderNumber({required String genderString}) {
    if (genderString == '男') {
      return 1;
    } else {
      return 2;
    }
  }

  /*获取性别string*/
  static String getGenderString({required int gender}) {
    if (gender == 1) {
      return '男';
    } else {
      return '女';
    }
  }

  /*flutter调用h5*/
  String flutterCallH5({required String h5Name, required var params}) {
    var jsonParams = jsonEncode(params);
    return "$h5Name('$jsonParams')";
  }
}
