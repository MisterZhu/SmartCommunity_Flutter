/// 常用的默认值

class SCDefaultValue {
  const SCDefaultValue._();

  /// 屏幕默认宽度
  static const  double defaultScreenWidth = 375.0;

  /// APP名称
  static const String appName = '方圆管家';

  /// h5渠道，用于表示h5是应用在flutter上
  static int h5Channel = 1;

  /// client
  static const String client = 'jm-app';
  // static const String client = 'co-pc';

  /// appCode
  static const String appCode = '100';

  /// 高德web key
  static const String kAMapWebKey = 'a88d7d7f333e55129411579a79841d4d';

  /// 微信appId
  static const String kWeChatAppId = "wx723fd7a4cb33146e";

  /// 微信appKey
  static const String kWeChatAppKey = "f3efd17386b3a55753e4f565a76bb107";

  /// 微信universalLink
  static const String kWeChatUniversalLink = "https://3c2700fc09d6a05386e7af5ee5fec806.share2dlink.com/";

  /// 网络超时时间
  static const int timeOut = 30000;

  /// 手机号正则表达式
  static const String phoneReg = r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$";

  /// 身份证正则表达式
  static const String idCardReg = r'^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$';

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
  /// 设置-注销账号提示
  static const String logOffTip = "你正在申请注销你在$appName下的账号。注销后，你将退出$appName，该账号将无法继续使用，账号下的所有数据也无法处理，请确认是否注销";

  /// 扫码权限弹窗提示内容
  static const String scanAlertMessage = "允许“$appName”访问您的相机权限，用于您在提交工单、使用报事报修、参与活动、扫一扫功能";

  /// 相册权限弹窗提示内容
  static const String photoAlertMessage = "允许“$appName”访问您的相册权限，用于您在提交工单、使用报事报修、参与活动、修改头像";

  /// 相机权限弹窗提示内容
  static const String cameraAlertMessage = "允许“$appName”访问您的相机权限，用于您在提交工单、使用报事报修、参与活动、修改头像";

  /// 相机无权限提示
  static const String noCameraPermissionMessage = "相机权限受限，请在设置中开启相机权限";

  /// 相册无权限提示
  static const String noPhotoPermissionMessage = "相册权限受限，请在设置中开启相册权限";

  /// 定位权限弹窗提示内容
  static const String locationAlertMessage = "允许“$appName”访问您的位置权限，用于您在快速定位所在园区、参与活动功能";

  /// 输入姓名提示
  static const String inputNameTip = "请输入姓名";

  /// 姓名格式错误提示
  static const String inputNameErrorTip = "请输入正确的姓名";

  /// 输入证件号码提示
  static const String inputIDCardTip = "请输入证件号码";

  /// 证件号码格式错误提示
  static const String inputIDCardErrorTip = "请输入正确的证件号码";

  /// 未安装微信
  static const String unInstalWeChatTip = "请安装微信";

  /// 未安装支付宝提示
  static const String unInstallAliPayTip = "请安装支付宝";

  /// 支付成功提示
  static const String paySuccessMessage = "支付成功";

  static const String paySuccessTip = "支付成功";

  /// 支付失败提示
  static const String payFailureTip = "支付失败";

  /// 未安装微信
  static const String unInstallWeChatTip = "请安装微信";

  /// 需要房号
  static const String needHouseId = "当前应用需要房号信息，请绑定房号";

  /// 提示登录
  static const String needLoginTip = "登录后可获取更多优质服务";

  /// 拨号失败
  static const String callFailedTip = "拨号失败";

  /// 跳转浏览器失败
  static const String browserFailedTip = "跳转失败";

  /// 图片路径
  static const files = "/files/";
}