/// flutter调用h5的方法名

class SCFlutterH5Key {
  /// 获取定位结果,status:0-权限无法确定，1-成功，2-定位权限被拒绝
  static const String location = 'sc_app_location_result';
  /// 扫码结果,status:0-权限无法确定，1-成功，2-相机权限被拒绝
  static const String scan = 'sc_app_scan_result';
  /// 用户信息结果
  static const String userInfo = 'sc_app_user_info_result';
  /// 相机
  static const String camera = 'sc_app_camera_result';
  /// 相册
  static const String photos  = 'sc_app_photos_result';
  /// 微信支付结果
  static const String wechatPay  = 'sc_app_wechat_pay_result';
  /// 支付宝支付结果
  static const String alipay  = 'sc_app_alipay_result';
}