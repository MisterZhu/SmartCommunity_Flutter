import 'package:get/get.dart';
import 'package:smartcommunity/page/Guide/Page/sc_base_privacy_page.dart';
import 'package:smartcommunity/page/Guide/Page/sc_guide_page.dart';
import 'package:smartcommunity/page/Home/Page/sc_home_page.dart';
import 'package:smartcommunity/page/Login/Page/sc_login_page.dart';
import 'package:smartcommunity/page/Mine/Page/sc_add_house_page.dart';
import 'package:smartcommunity/page/Mine/Page/sc_setting_page.dart';
import 'package:smartcommunity/page/Mine/Page/sc_toggle_houses_page.dart';
import 'package:smartcommunity/page/Tab/Page/sc_tab_page.dart';
import 'package:smartcommunity/page/Webview/Page/sc_webview_page.dart';

import '../../page/Login/Page/sc_select_city_page.dart';
import '../../page/Login/Page/sc_select_community_page.dart';
import '../../page/Service/Page/sc_service_page.dart';
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
    /*webView*/
    GetPage(name: SCRouterPath.webViewPath, page: () => SCWebViewPage()),
    /*城市选择*/
    GetPage(name: SCRouterPath.selectCityPath, page: () => SCSelectCityPage()),
    /*社区选择*/
    GetPage(name: SCRouterPath.selectCommunityPath, page: () => SCSelectCommunityPage()),
    /*全部应用*/
    GetPage(name: SCRouterPath.servicePagePath, page: () => SCServicePage()),
    /*切换房屋*/
    GetPage(name: SCRouterPath.toggleHousesPagePath, page: () => SCToggleHousesPage()),
    /*新增房号*/
    GetPage(name: SCRouterPath.addHousePagePath, page: () => SCAddHousePage()),
    /*设置*/
    GetPage(name: SCRouterPath.settingPath, page: () => SCSettingPage()),
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
    /*社区选择*/
    9003 : SCRouterPath.selectCommunityPath,
    /*tab*/
    10000 : SCRouterPath.tabPath,
    /*首页*/
    10001 : SCRouterPath.homePath,
    /*全部应用*/
    10011 : SCRouterPath.servicePagePath,
    /*切换房屋*/
    5001 : SCRouterPath.toggleHousesPagePath,
    /*新增房号*/
    5002 : SCRouterPath.addHousePagePath,
    /*设置*/
    5003 : SCRouterPath.settingPath,
    /*webView*/
    20000 : SCRouterPath.webViewPath,
  };
}