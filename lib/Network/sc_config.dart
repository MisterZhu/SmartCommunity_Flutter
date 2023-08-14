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
        return "https://jmdev.wisharetec.com/api";
      case SCEnvironment.pretest:
        return "https://test.fyelife.cn:28080/jmapi";
      case SCEnvironment.production:
        return "https://bsp.fineland.cn/jmapi";
      default:
        return "https://bsp.fineland.cn/jmapi";
    }
  }

  /// base h5 url
  static String get BASE_H5_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://jmdev.wisharetec.com/";
      case SCEnvironment.pretest:
        return "https://test.fyelife.cn:28080/";
      case SCEnvironment.production:
        return "https://bsp.fineland.cn/";
      default:
        return "https://bsp.fineland.cn/";
    }
  }
  /// 图片base url
  static String get BASE_IMG_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://jmdev.wisharetec.com/";
      case SCEnvironment.pretest:
        return "https://test.fyelife.cn:28080";
      case SCEnvironment.production:
        return "https://bsp.fineland.cn";
      default:
        return "https://test.fyelife.cn";
    }
  }
  /// 终端ID
  static String get getTerminalId {
    switch (env) {
      case SCEnvironment.develop:
        return "13586181992931";
      case SCEnvironment.pretest:
        return "13586181992931";
      case SCEnvironment.production:
        return "13993084622811";
      default:
        return "13993084622811";
    }
  }
  /// 推广ID
  static String get locationId {
    switch (env) {
      case SCEnvironment.develop:
        return "13553016454031";
      case SCEnvironment.pretest:
        return "13553016454031";
      case SCEnvironment.production:
        return "13795403737604";
      default:
        return "13795403737604";
    }
  }
  /// 分类ID
  static String get categoryId {
    switch (env) {
      case SCEnvironment.develop:
        return "13646517987151";
      case SCEnvironment.pretest:
        return "13646517987151";
      case SCEnvironment.production:
        return "13751484480401";
      default:
        return "13751484480401";
    }
  }
  /// 图片url
  static String getImageUrl(String url) {
    return BASE_IMG_URL + SCDefaultValue.files + url;
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
