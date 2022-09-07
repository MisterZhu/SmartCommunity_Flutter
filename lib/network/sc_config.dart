import 'package:smartcommunity/constants/sc_default_value.dart';
import 'package:smartcommunity/constants/sc_enum.dart';

/// 环境配置

class SCConfig {
  static SCEnvironment env = SCEnvironment.develop;

  static String get BASE_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://jmdev.wisharetec.com";
      case SCEnvironment.pretest:
        return "https://shushuapitest.4001113900.com:10020";
      case SCEnvironment.production:
        return "https://saasprod.4001113900.com:10020";
      default:
        return "https://yshk8s.lcfw.co";
    }
  }

  static String getImageUrl(String url) {
    return BASE_URL + SCDefaultValue.files + url;
  }

}