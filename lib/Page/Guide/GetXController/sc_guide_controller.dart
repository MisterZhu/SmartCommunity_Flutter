import 'package:get/get.dart';

import '../../../Network/sc_http_manager.dart';

/// 引导页controller

class SCGuideController extends GetxController {
  /// 获取版本更新信息
  getVersion() {
    SCHttpManager.instance.get(url: 'https://www.baidu.com');
  }
}