/// API

class SCUrl {
  /// 高德逆地理编码url
  static const String kReGeoCodeUrl = 'https://restapi.amap.com/v3/geocode/regeo';


  /************************* 登陆 *************************/

  /// 发送验证码url
  static const String kSendCodeUrl = '/api/user/sms';

  /// 验证码登陆url
  static const String kPhoneCodeLoginUrl = '/api/user/loginByCode';

}