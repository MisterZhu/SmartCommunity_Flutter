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

  /***************************** 登录 ******************************/
  /// 验证码登录
  static String codeLoginPath = "/root/login/codeLogin";
  /// 城市选择
  static String selectCityPath = "/root/login/selectCityPage";
  /// 社区选择
  static String selectCommunityPath = "/root/login/selectCommunityPage";

  /// 房号选择
  static String selectHousePath = "/root/login/SCSelectHousePage";

  /// 完善资料page
  static String improveDataPagePath = "/root/login/sc_improve_data_page";

  /***************************** 首页 ******************************/
  /// 首页
  static String homePath = "/home/HomePage";
  /// 扫一扫
  static String scanPath = "/base/scan/SCScanPage";

  /***************************** 通用页 ******************************/
  /// webView
  static String webViewPath = "/root/webView/webViewPage";

  /***************************** 服务 ******************************/
  /// 全部应用
  static String servicePagePath = "/root/Service/sc_service_page";

  /***************************** 我的 ******************************/
  /// 切换房屋
  static String toggleHousesPagePath = "/root/Mine/sc_toggle_houses_page";

  /// 新增房号
  static String addHousePagePath = "/root/Mine/sc_add_house_page";

  /// 设置
  static String settingPath = "/root/Mine/sc_setting_page";

  /// 设置
  static String realNameVerifyPath = "/root/Mine/sc_real_name_verify_page";

  /// 个人资料
  static String personalInfoPath = "/root/Mine/sc_personal_info_page";

  /// 申请注销账户
  static String applyLogoffPath = "/root/Mine/sc_apply_logoff_page";

  /// 注销账户
  static String logoffPath = "/root/Mine/sc_logoff_page";

  /// 设置昵称
  static String nicknamePath = "/root/Mine/sc_set_nickname_page";

  /// 抓包设置
  static String proxyPage = "/lib/Page/Mine/Home/Page/sc_proxy_page";


  ///*************************** 消息 ******************************/

  /// 消息
  static String messagePage = "/lib/Page/Message/Page/sc_message_page";

}