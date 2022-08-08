import 'package:get/get.dart';
import 'package:smartcommunity/utils/Router/sc_router_pages.dart';

/// 路由-工具管理
class SCRouterHelper {
  /*通过code跳转页面*/
  static Future? codePage(int code, dynamic params) {
    params ??= '';
    String? path = SCRouterPages.pageCode[code];
    return Get.toNamed(path!, arguments: params);
  }

  /*通过code跳转页面并关闭上一个页面*/
  static Future? codeOffPage(int code, dynamic params) {
    params ??= '';
    String? path = SCRouterPages.pageCode[code];
    return Get.offAndToNamed(path!, arguments: params);
  }

  /*关闭所有页面*/
  static Future? codeOffAllPage(int code, dynamic params) {
    params ??= '';
    String? path = SCRouterPages.pageCode[code];
    return Get.offAllNamed(path!, arguments: params);
  }

  /*通过path跳转页面*/
  static Future? pathPage(String path, dynamic params) {
    params ??= '';
    return Get.toNamed(path, arguments: params);
  }

  /*返回上一页*/
  static void back(dynamic params) {
    params ??= '';
    Get.back(result: params);
  }
}