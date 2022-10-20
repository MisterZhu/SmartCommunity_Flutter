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

  /// 网络加载中
  static const String loadingMessage = '加载中...';

  /// 网络加载失败
  static const String errorMessage = '加载失败，请稍后重试！';

  /// 网络不稳定
  static const String netErrorMessage = '网络不稳定，请稍后重试！';

  /// 同意协议才可以使用APP
  static const String canUseAppMessage = '同意协议后才可以使用!';

  /// 同意用户协议
  static const String agreeUserAgreementMessage = '请先同意用户协议和隐私政策！';

  /// 账户过期
  static const String accountExpiredMessage = '账户已过期,请重新登录!';

  /// 扫码权限弹窗提示内容
  static const String scanAlertMessage = "允许“${appName}”访问您的相机权限，用于您在提交工单、使用报事报修、参与活动、扫一扫功能";

  /// 相册权限弹窗提示内容
  static const String photoAlertMessage = "允许“${appName}”访问您的相册权限，用于您在提交工单、使用报事报修、参与活动、修改头像";

  /// 相机权限弹窗提示内容
  static const String cameraAlertMessage = "允许“${appName}”访问您的相机权限，用于您在提交工单、使用报事报修、参与活动、修改头像";

  /// 相机无权限提示
  static const String noCameraPermissionMessage = "相机权限受限，请在设置中开启相机权限";

  /// 相册无权限提示
  static const String noPhotoPermissionMessage = "相册权限受限，请在设置中开启相册权限";

  /// 图片路径
  static const files = "/files/";
}