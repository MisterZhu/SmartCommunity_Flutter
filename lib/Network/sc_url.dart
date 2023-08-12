/// API

class SCUrl {


  /// 高德逆地理编码url
  static const String kReGeoCodeUrl = 'https://restapi.amap.com/v3/geocode/regeo';


  /************************* 登录 *************************/

  /// 发送验证码url
  static const String kSendCodeUrl = '/user/sms';

  /// 验证码登录url
  static const String kPhoneCodeLoginUrl = '/user/loginByCode';

  /// 验证码登录验证姓名url
  static const String kPhoneCodeLoginWithNameUrl = '/user/login4C';

  /// 通过坐标经纬度查询项目url
  static const String kSearchCommunityByLocationUrl = '/space/community/searchCommunityByPlace';

  /// 通过城市名称查询项目url
  static const String kSearchCommunityByCityUrl = '/space/community/pageSearchCommunity';

  /// 用户默认配置信息url
  static const String kUserDefaultConfigUrl = "/user/defaultConfig";

  /// 退出登录url
  static const String kLogoutUrl = '/user/loginOut';
  /// 退出登录url
  static const String kLogoffUrl = '/user/logOff';
  /************************* 首页 *************************/

  /// 游客模式装修url
  static const String kVisitorDecorationUrl = '/applet/decoration/pattern/visitor';

  /// 首页消息数量url
  static const String kMessageCountUrl = '/msg/noticeConsumer/count';

  /************************* 服务 *************************/

  /// 应用列表url
  static const String kServiceAppListUrl = '/applet/user/list';

  /************************* 我的 *************************/

  /// 我的房号列表url
  static const String kMyHouseUrl = '/space/resident/user/housing/list';

  /// 新增房号接口
  static const String kAddHouseUrl = '/space/resident/user/bind';

  /// 当前房屋详情接口
  static const String kCurrentHouseInfoUrl = '/space/resident/user/housing/info';

  /// 解除绑定房号接口url
  static const String kUnbindHouseUrl = '/space/resident/user/unbind';

  /// 通过项目Id获取房号数据url
  static const String kGetSpaceNodesUrl = '/space/space/getSpaceNodes';

  /// 获取用户身份
  static const String kResidentUserIdentity = '/space/resident/user/community/identity';

  /// 绑定房产
  static const String kBindAsset = '/space/resident/user/bind';

  /// 居民档案审核通过
  static const String kExaminePass = '/space/archive/examine/pass';

  /// 居民档案审核拒绝
  static const String kExamineReject = '/space/archive/examine/refuse';

  /// 上传头像
  static const String kUploadHeadPicUrl = "/user/upload/headPic";

  /// 修改用户信息
  static const String kChangeAccountInfoUrl = "/user/info/modifyAccount";

  /// 获取用户信息
  static const String kFetchUserInfoUrl = "/user/residentInfo";

  /************************* 消息 *************************/
  /// 消息列表
  static const String kMessageListUrl = "/msg/noticeConsumer/list";

  /// 获取详情并更新为已读
  static const String kMessageDetailUrl = "/msg/noticeConsumer";


  /************************* 优惠券 *************************/
  /// 我的卡包列表
  static const String kMyCouponListUrl = "/operation/voucher/user/myPageFront";

  /// 可领的券列表
  static const String kReceiveCouponListUrl = "/operation/voucher/user/obtainablePage";

  /// 领取优惠券
  static const String kReceiveCouponUrl = "/operation/voucher/user/gain";

  /// page模版
  static const String pageTemplate = "/applet/decoration/v2/template";
  /// 获取模版id
  static const String getTemplateId = "/config/terminal";
 /// banner图
  static const String getBannerURL = "/content/promotion/list";

  /// 推广列表不分页查询
  static const String getPromotionListUrl = "/content/promotion/list";
  /// 资讯列表不分页查询
  static const String getInforListUrl = "/content/information/list";


}