/// API

class SCUrl {
  /// 高德逆地理编码url
  static const String kReGeoCodeUrl = 'https://restapi.amap.com/v3/geocode/regeo';


  /************************* 登录 *************************/

  /// 发送验证码url
  static const String kSendCodeUrl = '/api/user/sms';

  /// 验证码登录url
  static const String kPhoneCodeLoginUrl = '/api/user/loginByCode';

  /// 通过坐标经纬度查询项目url
  static const String kSearchCommunityByLocationUrl = '/api/space/community/searchCommunityByPlace';

  /// 通过城市名称查询项目url
  static const String kSearchCommunityByCityUrl = '/api/space/community/pageSearchCommunity';

  /// 用户默认配置信息url
  static const String kUserDefaultConfigUrl = "/api/user/defaultConfig";

  /// 退出登录url
  static const String kLogoutUrl = '/api/user/loginOut';

 /************************* 服务 *************************/

  /// 应用列表url
  static const String kServiceAppListUrl = '/api/applet/user/list';

  /************************* 我的 *************************/

  /// 我的房号列表url
  static const String kMyHouseUrl = '/api/space/resident/user/housing/list';

  /// 新增房号接口
  static const String kAddHouseUrl = '/api/space/resident/user/bind';

  /// 当前房屋详情接口
  static const String kCurrentHouseInfoUrl = '/api/space/resident/user/housing/info';

  /// 解除绑定房号接口url
  static const String kUnbindHouseUrl = '/api/space/resident/user/unbind';

  /// 通过项目Id获取房号数据url
  static const String kGetSpaceNodesUrl = '/api/space/space/getSpaceNodes';

  /// 获取用户身份
  static const String kResidentUserIdentity = '/api/space/resident/user/community/identity';

  /// 绑定房产
  static const String kBindAsset = '/api/space/resident/user/bind';

  /// 居民档案审核通过
  static const String kExaminePass = '/api/space/archive/examine/pass';

  /// 居民档案审核拒绝
  static const String kExamineReject = '/api/space/archive/examine/refuse';

  /// 上传头像
  static const String kUploadHeadPicUrl = "/api/user/upload/headPic";

  /// 修改用户信息
  static const String kChangeAccountInfoUrl = "/api/user/info/modifyAccount";

  /// 获取用户信息
  static const String kFetchUserInfoUrl = "/api/user/residentInfo";
}