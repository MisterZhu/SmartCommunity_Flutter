
import 'package:get/get.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller1.dart';
import 'package:smartcommunity/page/Home/GetXController/sc_home_controller2.dart';

class SCHomeController extends GetxController {
  /// 皮肤样式,默认第一套
  int skinStyle = 0;

  /// 切换皮肤
  changeSkin({required int style}) {
    skinStyle = style;
    if (style == 0) {
      SCHomeController1 state = Get.find<SCHomeController1>();
      state.resetAllData();
    } else {
      SCHomeController2 state = Get.find<SCHomeController2>();
      state.resetAllData();
    }
    update();
  }
}