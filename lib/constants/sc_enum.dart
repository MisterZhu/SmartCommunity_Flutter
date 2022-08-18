enum SCEnvironment {
  /// 研发环境
  develop,
  /// 预发环境
  pretest,
  /// 生产环境
  production
}

enum SCHttpMethod {
  get,
  post,
  put,
  delete
}

enum SCHomeFeatureStyle {
  /// 一张图片
  featureStyle1,
  /// 两张图片
  featureStyle2
}

enum SCLocationStatus {
  /// 定位未开启
  notOpen,
  /// 定位失败
  failure,
  /// 定位成功
  success,
}