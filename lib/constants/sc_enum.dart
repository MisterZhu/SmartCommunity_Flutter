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

/// 选择房号的逻辑链路
enum SCSelectHouseLogicType {
  /// 登录逻辑  去绑定房号
  login,
  /// 新增房号  去绑定房号
  addHouse,
}

/// 首页cell样式类型
enum SCHomeCellBottomContentType {
  // 图片下面没有标题
  noBottomContent,
  // 图片下面有标题内容
  bottomContent,
}

/// picker类型
enum SCPickerType {
  // 普通的picker
  normal,
  // 日期picker
  date
}