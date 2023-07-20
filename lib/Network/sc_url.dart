/// API

class SCUrl {
  /// 高德逆地理编码url
  static const String kReGeoCodeUrl = 'https://restapi.amap.com/v3/geocode/regeo';


  /************************* 登录 *************************/

  /// 发送验证码url
  static const String kSendCodeUrl = '/jmapi/user/sms';

  /// 验证码登录url
  static const String kPhoneCodeLoginUrl = '/jmapi/user/loginByCode';

  /// 验证码登录验证姓名url
  static const String kPhoneCodeLoginWithNameUrl = '/jmapi/user/login4C';

  /// 通过坐标经纬度查询项目url
  static const String kSearchCommunityByLocationUrl = '/jmapi/space/community/searchCommunityByPlace';

  /// 通过城市名称查询项目url
  static const String kSearchCommunityByCityUrl = '/jmapi/space/community/pageSearchCommunity';

  /// 用户默认配置信息url
  static const String kUserDefaultConfigUrl = "/jmapi/user/defaultConfig";

  /// 退出登录url
  static const String kLogoutUrl = '/jmapi/user/loginOut';

  /************************* 首页 *************************/

  /// 游客模式装修url
  static const String kVisitorDecorationUrl = '/jmapi/applet/decoration/pattern/visitor';

  /// 首页消息数量url
  static const String kMessageCountUrl = '/jmapi/msg/noticeConsumer/count';

  /************************* 服务 *************************/

  /// 应用列表url
  static const String kServiceAppListUrl = '/jmapi/applet/user/list';

  /************************* 我的 *************************/

  /// 我的房号列表url
  static const String kMyHouseUrl = '/jmapi/space/resident/user/housing/list';

  /// 新增房号接口
  static const String kAddHouseUrl = '/jmapi/space/resident/user/bind';

  /// 当前房屋详情接口
  static const String kCurrentHouseInfoUrl = '/jmapi/space/resident/user/housing/info';

  /// 解除绑定房号接口url
  static const String kUnbindHouseUrl = '/jmapi/space/resident/user/unbind';

  /// 通过项目Id获取房号数据url
  static const String kGetSpaceNodesUrl = '/jmapi/space/space/getSpaceNodes';

  /// 获取用户身份
  static const String kResidentUserIdentity = '/jmapi/space/resident/user/community/identity';

  /// 绑定房产
  static const String kBindAsset = '/jmapi/space/resident/user/bind';

  /// 居民档案审核通过
  static const String kExaminePass = '/jmapi/space/archive/examine/pass';

  /// 居民档案审核拒绝
  static const String kExamineReject = '/jmapi/space/archive/examine/refuse';

  /// 上传头像
  static const String kUploadHeadPicUrl = "/jmapi/user/upload/headPic";

  /// 修改用户信息
  static const String kChangeAccountInfoUrl = "/jmapi/user/info/modifyAccount";

  /// 获取用户信息
  static const String kFetchUserInfoUrl = "/jmapi/user/residentInfo";

  /************************* 消息 *************************/
  /// 消息列表
  static const String kMessageListUrl = "/jmapi/msg/noticeConsumer/list";

  /// 获取详情并更新为已读
  static const String kMessageDetailUrl = "/jmapi/msg/noticeConsumer";


  /************************* 优惠券 *************************/
  /// 我的卡包列表
  static const String kMyCouponListUrl = "/jmapi/operation/voucher/user/myPageFront";

  /// 可领的券列表
  static const String kReceiveCouponListUrl = "/jmapi/operation/voucher/user/obtainablePage";

  /// 领取优惠券
  static const String kReceiveCouponUrl = "/jmapi/operation/voucher/user/gain";

  /// page模版
  static const String pageTemplate = "/applet/decoration/v2/template";

}