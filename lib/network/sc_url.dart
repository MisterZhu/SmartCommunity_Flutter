/// API

class SCUrl {
  /// 高德逆地理编码url
  static const String kReGeoCodeUrl = 'https://restapi.amap.com/v3/geocode/regeo';


  /************************* 登陆 *************************/

  /// 发送验证码url
  static const String kSendCodeUrl = '/api/user/sms';

  /// 验证码登陆url
  static const String kPhoneCodeLoginUrl = '/api/user/loginByCode';

  /// 通过坐标经纬度查询项目url
  static const String kSearchCommunityByLocationUrl = '/api/space/community/searchCommunityByPlace';

  /// 通过城市名称查询项目url
  static const String kSearchCommunityByCityUrl = '/api/space/community/pageSearchCommunity';

 /************************* 服务 *************************/

  /// 应用列表url
  static const String kServiceAppListUrl = '/api/applet/tenant/list';

  /************************* 我的 *************************/

  /// 我的房号列表url
  static const String kMyHouseUrl = '/api/space/resident/user/housing/list';

  /// 新增房号接口
  static const String kAddHouseUrl = '/api/space/resident/user/bind';

  /// 当前房屋详情接口
  static const String kCurrentHouseInfoUrl = '/api/space/resident/user/housing/info';

  /// 解除绑定房号接口url
  static const String kUnbindHouseUrl = '/api/space/resident/user/unbind';

}