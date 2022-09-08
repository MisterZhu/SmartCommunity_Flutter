/// 常用的默认值

class SCDefaultValue {
  const SCDefaultValue._();

  /// 屏幕默认宽度
  static const  double defaultScreenWidth = 375.0;

  /// APP名称
  static const String appName = '邑生活';

  /// client
  static const String client = 'jm-app';

  /// 高德web key
  static const String kAMapWebKey = 'fb48becc7b7a077d4da585a977d39ed2';

  /// 网络超时时间
  static const int timeOut = 30000;

  /// 手机号正则表达式
  static const String phoneReg = r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$";

  /// 网络加载失败
  static const String errorMessage = '加载失败，请稍后重试！';

  /// 网络不稳定
  static const String netErrorMessage = '网络不稳定，请稍后重试！';

  /// 同意协议才可以使用APP
  static const String canUseAppMessage = '同意协议后才可以使用!';

  /// 同意用户协议
  static const String agreeUserAgreementMessage = '请先同意用户协议和隐私政策！';
}