import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';

/// 环境配置

class SCConfig {
  /// 环境
  static SCEnvironment env = SCEnvironment.develop;

  static bool isSupportProxyForProduction = false;

  /// iOS是否支持平方SC字体
  static bool isSupportPFSCForIOS = true;

  /// base url
  static String get BASE_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://saasdev.wisharetec.com";
      case SCEnvironment.pretest:
        return "https://saasdev.wisharetec.com";
      case SCEnvironment.production:
        return "https://saas.wisharetec.com";
      default:
        return "https://saasdev.wisharetec.com";
    }
  }

  /// base h5 url
  static String get BASE_H5_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://jmdev.wisharetec.com";
      case SCEnvironment.pretest:
        return "https://jmtest.wisharetec.com";
      case SCEnvironment.production:
        return "https://jm.wisharetec.com";
      default:
        return "https://jmdev.wisharetec.com";
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


  /// iOS平方SC配置
  static List<String> getPFSCForIOS() {
    if (isSupportPFSCForIOS) {
      return ["PingFang SC"];
    } else {
      return [];
    }
  }

}