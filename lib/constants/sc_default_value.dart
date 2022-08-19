/// 常用的默认值

class SCDefaultValue {
  const SCDefaultValue._();

  /// 屏幕默认宽度
  static const  double defaultScreenWidth = 375.0;

  /// APP名称
  static const String appName = '邑生活';

  /// client
  static const String client = 'jm-app';

  /// 手机号正则表达式
  static const String phoneReg = r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$";

  /// 网络加载失败
  static const String errorMessage = '加载失败，请稍后重试！';

  /// 高德web key
  static const String kAMapWebKey = 'fb48becc7b7a077d4da585a977d39ed2';

  /// 网络超时时间
  static const int timeOut = 30000;
}