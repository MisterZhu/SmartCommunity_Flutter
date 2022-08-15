import 'package:get/get.dart';
import 'package:smartcommunity/page/Guide/Page/sc_base_privacy_page.dart';
import 'package:smartcommunity/page/Guide/Page/sc_guide_page.dart';
import 'package:smartcommunity/page/Home/Page/sc_home_page.dart';
import 'package:smartcommunity/page/Login/Page/sc_login_page.dart';
import 'package:smartcommunity/page/Tab/Page/sc_tab_page.dart';

import '../../page/Login/Page/sc_select_city_page.dart';
import 'sc_router_path.dart';

/// 路由-pages
class SCRouterPages {
  /*根据path使用路由*/
  static final List<GetPage> getPages = [
    /*tab*/
    GetPage(name: SCRouterPath.tabPath, page: () => SCTabPage()),
    /*验证码登录*/
    GetPage(name: SCRouterPath.codeLoginPath, page: () => SCLoginPage()),
    /*首页*/
    GetPage(name: SCRouterPath.homePath, page: () => SCHomePage()),
    /*引导页*/
    GetPage(name: SCRouterPath.guidePath, page: () => SCGuidePage()),
    /*首次的用户协议和隐私政策弹窗*/
    GetPage(name: SCRouterPath.basePrivacyPath, page: () => SCBasePrivacyPage()),
    /*城市选择*/
    GetPage(name: SCRouterPath.selectCityPath, page: () => SCSelectCityPage()),
  ];

  /*根据code使用路由*/
  static var pageCode = {
    /*用户协议和隐私政策*/
    8000 : SCRouterPath.basePrivacyPath,
    /*引导页*/
    9000 : SCRouterPath.guidePath,
    /*验证码登录*/
    9001 : SCRouterPath.codeLoginPath,
    /*城市选择*/
    9002 : SCRouterPath.selectCityPath,
    /*tab*/
    10000 : SCRouterPath.tabPath,
    /*首页*/
    10001 : SCRouterPath.homePath,
  };
}