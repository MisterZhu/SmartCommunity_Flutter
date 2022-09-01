/// 路由-path

class SCRouterPath {
  /// 根目录默认登录页面
  static String root = "/";// 根目录

  /// tabPage
  static String tabPath = "/root/tabPage";

  /// 引导页
  static String guidePath = "/root/guidePage";
  /// 用户协议和隐私政策弹窗
  static String basePrivacyPath = "/root/basePrivacyPage";
  /// webView
  static String webViewPath = "/root/webView/webViewPage";

  /***************************** 登录 ******************************/
  /// 验证码登录
  static String codeLoginPath = "/root/login/codeLogin";
  /// 城市选择
  static String selectCityPath = "/root/login/selectCityPage";
  /// 社区选择
  static String selectCommunityPath = "/root/login/selectCommunityPage";

  /***************************** 首页 ******************************/
  /// 首页
  static String homePath = "/home/HomePage";

  /***************************** 服务 ******************************/
  /// 全部应用
  static String servicePagePath = "/root/Service/sc_service_page";

  /***************************** 我的 ******************************/
  /// 切换房屋
  static String toggleHousesPagePath = "/root/Mine/sc_toggle_houses_page";

}