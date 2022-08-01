import 'package:get/get.dart';
import 'package:smartcommunity/page/Home/Page/sc_home_page.dart';
import 'package:smartcommunity/page/Tab/Page/sc_tab_page.dart';

import 'sc_router_path.dart';

/// 路由-pages
class SCRouterPages {
  /*根据path使用路由*/
  static final List<GetPage> getPages = [
    /*tab*/
    GetPage(name: SCRouterPath.tabPath, page: () => SCTabPage()),
    /*首页*/
    GetPage(name: SCRouterPath.homePath, page: () => SCHomePage()),
  ];

  /*根据code使用路由*/
  static var pageCode = {
    /*tab*/
    10000 : SCRouterPath.tabPath,
    /*首页*/
    10001 : SCRouterPath.homePath,
  };
}