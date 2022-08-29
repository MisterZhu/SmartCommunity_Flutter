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

  /// 通过项目Id获取房号数据url
  static const String kGetSpaceNodesUrl = '/api/space/space/getSpaceNodes';
}