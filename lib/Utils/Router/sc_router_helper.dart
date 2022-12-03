import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_pages.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../Page/Login/Page/sc_login_page.dart';

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

  /*通过path跳转页面
  * 默认页面跳转都需要做登录验证
  * 如果页面需要去掉登录验证，params需要传参removeLoginCheck=true
  */
  static Future? pathPage(String path, dynamic params) {
    params ??= '';
    List<String> noLoginPathList = [
      SCRouterPath.codeLoginPath,
    ];

    /// 是否去掉登录验证
    if (params is Map) {
      var removeLoginCheck = params["removeLoginCheck"];
      if (removeLoginCheck == true) {
        noLoginPathList.add(path);
      }
    }

    /// 是否需要登录，默认需要
    bool isNeedLogin = true;
    for (String subPath in noLoginPathList) {
      if (path == subPath) {
        isNeedLogin = false;
        break;
      }
    }
    if (isNeedLogin == true && SCScaffoldManager.instance.isLogin == false) {
      presentLoginPage();
      return null;
    }

    return Get.toNamed(path, arguments: params);
  }

  /*通过path跳转页面,关闭所有页面*/
  static Future? pathOffAllPage(String path, dynamic params) {
    params ??= '';
    return Get.offAllNamed(path, arguments: params);
  }

  /*present方式打开登录页面*/
  static void presentLoginPage() {
    SCUtils.getCurrentContext(completionHandler: (context) async {
      Navigator.push(context, MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) {
            return SCLoginPage(showCloseBtn: true);
          }),
      );
    });
  }

  /*返回上一页*/
  static void back(dynamic params) {
    params ??= '';
    Get.back(result: params);
  }

  /*跳转到下一个页面，下一个页面返回到指定页面*/
  static void offUntil(Widget page, String routeName, Map arguments, String backRouteName) {
    Get.offUntil(
        GetPageRoute(
            page: () => page,
            routeName: routeName,
            settings: RouteSettings(arguments: arguments)),
            (Route<dynamic> route) {
          GetPageRoute currentRoute = route as GetPageRoute;
          if (currentRoute.routeName == null) {
            RouteSettings settings = route.settings;
            if (settings.name == backRouteName) {
              return true;
            } else {
              return false;
            }
          } else {
            if (currentRoute.routeName == backRouteName) {
              return true;
            } else {
              return false;
            }
          }
        });
  }
}