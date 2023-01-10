
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../Network/sc_http_manager.dart';
import '../../Network/sc_url.dart';
import '../Model/sc_home_visitor_decoration_model.dart';

/// 皮肤配置
class SCSkinConfig {

  /// 获取游客模式装修数据
  static getVisitorDecorationData({Function? successHandler}) {
    SCHttpManager.instance.get(
        url: SCUrl.kVisitorDecorationUrl,
        success: (value) {
          SCHomeVisitorDecorationModel visitorDecorationModel = SCHomeVisitorDecorationModel.fromJson(value);
          SCScaffoldManager.instance.visitorDecorationModel = visitorDecorationModel;
          successHandler?.call();
        },
        failure: (value) {
          print("游客模式装修失败:$value");
        });
  }

}