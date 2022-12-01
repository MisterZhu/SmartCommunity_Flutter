import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';

/// 环境配置

class SCConfig {
  /// 环境
  static SCEnvironment env = SCEnvironment.develop;

  /// base url
  static String get BASE_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://jmdev.wisharetec.com";
      case SCEnvironment.pretest:
        return "https://jmdev.wisharetec.com";
      case SCEnvironment.production:
        return "https://jm.wisharetec.com";
      default:
        return "https://jmdev.wisharetec.com";
    }
  }

  /// base h5 url
  static String get BASE_H5_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://saasdev.wisharetec.com";
      case SCEnvironment.pretest:
        return "https://saas.wisharetec.com";
      case SCEnvironment.production:
        return "https://saas.wisharetec.com";
      default:
        return "https://saas.wisharetec.com";
    }
  }

  /// 图片url
  static String getImageUrl(String url) {
    return BASE_URL + SCDefaultValue.files + url;
  }

  /// h5 url
  static String getH5Url(String url) {
    if (url.contains('http')) {
      return url;
    } else {
      return BASE_H5_URL + url;
    }
  }

}