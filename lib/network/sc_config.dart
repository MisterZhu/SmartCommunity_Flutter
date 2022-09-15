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
        return "https://jmdev.wisharetec.com";
      case SCEnvironment.production:
        return "https://jmdev.wisharetec.com";
      default:
        return "https://jmdev.wisharetec.com";
    }
  }

  static String getImageUrl(String url) {
    return BASE_URL + SCDefaultValue.files + url;
  }

}