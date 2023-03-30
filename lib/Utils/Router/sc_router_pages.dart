import 'package:get/get.dart';
import 'package:smartcommunity/Page/Base/Scan/Page/sc_scan_page.dart';
import 'package:smartcommunity/Page/Guide/Page/sc_base_privacy_page.dart';
import 'package:smartcommunity/Page/Guide/Page/sc_guide_page.dart';
import 'package:smartcommunity/Page/Home/Page/sc_home_page.dart';
import 'package:smartcommunity/Page/Login/Page/sc_improve_data_page.dart';
import 'package:smartcommunity/Page/Login/Page/sc_select_house_page.dart';
import 'package:smartcommunity/Page/Login/Page/sc_login_page.dart';
import 'package:smartcommunity/Page/Login/View/Login/sc_login_code_view.dart';
import 'package:smartcommunity/Page/Mine/Page/sc_add_house_page.dart';
import 'package:smartcommunity/Page/Mine/Page/sc_logoff_page.dart';
import 'package:smartcommunity/Page/Mine/Page/sc_personal_info_page.dart';
import 'package:smartcommunity/Page/Mine/Page/sc_real_name_verify_page.dart';
import 'package:smartcommunity/Page/Mine/Page/sc_set_nickname_page.dart';
import 'package:smartcommunity/Page/Mine/Page/sc_toggle_houses_page.dart';
import 'package:smartcommunity/Page/Tab/Page/sc_tab_page.dart';
import 'package:smartcommunity/Page/Webview/Page/sc_webview_page.dart';

import '../../Page/Coupon/Page/sc_coupon_page.dart';
import '../../Page/Login/Page/sc_select_city_page.dart';
import '../../Page/Login/Page/sc_select_community_page.dart';
import '../../Page/Message/Page/sc_message_page.dart';
import '../../Page/Mine/Page/sc_apply_logoff_page.dart';
import '../../Page/Mine/Page/sc_proxy_page.dart';
import '../../Page/Mine/Page/sc_setting_page.dart';
import '../../Page/Service/Page/sc_service_page.dart';
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
    /*扫一扫*/
    GetPage(name: SCRouterPath.scanPath, page: () => SCScanPage()),
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
    /*webView*/
    GetPage(name: SCRouterPath.webViewPath, page: () => SCWebViewPage()),
    /*房号选择*/
    GetPage(name: SCRouterPath.selectHousePath, page: () => SCSelectHousePage()),
    /*全部应用*/
    GetPage(name: SCRouterPath.servicePagePath, page: () => SCServicePage()),
    /*切换房屋*/
    GetPage(name: SCRouterPath.toggleHousesPagePath, page: () => SCToggleHousesPage()),
    /*新增房号*/
    GetPage(name: SCRouterPath.addHousePagePath, page: () => SCAddHousePage()),
    /*设置*/
    GetPage(name: SCRouterPath.settingPath, page: () => SCSettingPage()),
    /*申请注销账户*/
    GetPage(name: SCRouterPath.applyLogoffPath, page: () => SCApplyLogoffPage()),
    /*注销账户*/
    GetPage(name: SCRouterPath.logoffPath, page: () => SCLogoffPage()),
    /*个人资料*/
    GetPage(name: SCRouterPath.personalInfoPath, page: () => SCPersonalInfoPage()),
    /*实名认证*/
    GetPage(name: SCRouterPath.realNameVerifyPath, page: () => SCRealNameVerifyPage()),
    /*完善资料*/
    GetPage(name: SCRouterPath.improveDataPagePath, page: () => SCImproveDataPage()),
    /*设置昵称*/
    GetPage(name: SCRouterPath.nicknamePath, page: () => SCSetNicknamePage()),
    /*抓包设置*/
    GetPage(name: SCRouterPath.proxyPage, page: () => SCProxyPage()),
    /*消息*/
    GetPage(name: SCRouterPath.messagePage, page: () => SCMessagePage()),
    /*优惠券*/
    GetPage(name: SCRouterPath.couponPage, page: () => SCCouponPage()),
  ];

  /*根据code使用路由*/
  static var pageCode = {
    /*用户协议和隐私政策*/
    8000 : SCRouterPath.basePrivacyPath,
    /*引导页*/
    9000 : SCRouterPath.guidePath,
    /*验证码登录-输入手机号*/
    9001 : SCRouterPath.codeLoginPath,
    /*城市选择*/
    9002 : SCRouterPath.selectCityPath,
    /*社区选择*/
    9003 : SCRouterPath.selectCommunityPath,
    /*tab*/
    10000 : SCRouterPath.tabPath,
    /*首页*/
    10001 : SCRouterPath.homePath,
    /*扫一扫*/
    10002 : SCRouterPath.scanPath,
    /*全部应用*/
    10011 : SCRouterPath.servicePagePath,
    /*切换房屋*/
    5001 : SCRouterPath.toggleHousesPagePath,
    /*新增房号*/
    5002 : SCRouterPath.addHousePagePath,
    /*设置*/
    5003 : SCRouterPath.settingPath,
    /*个人资料*/
    5004 : SCRouterPath.personalInfoPath,
    /*实名认证*/
    5005 : SCRouterPath.realNameVerifyPath,
    /*webView*/
    20000 : SCRouterPath.webViewPath,
    /*房号选择*/
    20001 : SCRouterPath.selectHousePath,
  };
}